nextflow.enable.dsl = 2

params.is_cloud = true
params.ref_dir = "NO_DIR"
params.ref_tar = "NO_TAR"
params.vega_reference = "NO_FILE1"
params.lic_instance_id_location = "/opt/instance-identity"
params.rna_library_type = "SF"
params.umi_source = "qname"
params.fastq_list = "NO_LIST"
params.read1 = "NO_READ1"
params.read2 = "NO_READ2"
params.barcode_sequence_whitelist = "NO_FILE2"
params.annotation_file = "NO_FILE3"
params.generate_sa_tags = true
params.number_cells = ""
params.threshold = "ratio"
params.feature_barcode_r2umi = ""
params.cell_hashing_reference =
    "NO_FILE4" // One or both of cell-hashing and feature barcode references should be set when feature barcode r2 UMI is set
params.feature_barcode_reference = "NO_FILE5"
params.demux_detect_doublets = false
params.demux_sample_vcf = "NO_FILE6"
params.demux_reference_vcf = "NO_FILE7"
params.demux_number_samples = ""
params.barcode_read = "NO_BARCODE"

include { UntarVegaReference } from './tools-vega.nf'

process DragenSingleCellRna {

    container '102576526753.dkr.ecr.us-east-1.amazonaws.com/dragen/dragen:3.9.5-159'
    pod annotation: 'scheduler.illumina.com/presetSize', value: 'fpga-medium'

    publishDir("out", mode: "move")

    input:
        tuple path(read1), path(read2)
        path fastq_list
        val sample_id

    output:
        stdout emit: result
        path 'output', emit: output
        path 'logs', emit: logs

    script:
        def cleanup_command = ""
        def annotation_gtf = file(params.annotation_file)
        def ref_dir = ""

        // Untar command
        vega_reference_tar = file(params.vega_reference)
        ref_tar = file(params.ref_tar)
        if (vega_reference_tar.exists()) {
            (untar_command, cleanup_command, ref_dir, default_annotation_file) = UntarVegaReference(vega_reference_tar)
            if (!file(params.annotation_file).exists()) {
                annotation_gtf = default_annotation_file
            }
        } else if (file(params.ref_tar).exists()) {
            file_name = "${ref_tar}"
            ref_dir = "/scratch" + file_name.tokenize('.')[0]
            untar_command = "mkdir -p $ref_dir && tar -C $ref_dir -xf ${ref_tar}"
        } else {
            ref_dir = file(params.ref_dir, type: 'dir')
        }

        def reconfig_command = ""
        if (params.is_cloud) {
            reconfig_command = "/opt/edico/bin/dragen --partial-reconfig HMM --ignore-version-check true 2>&1"
        }

        def args = [
            "/opt/edico/bin/dragen",
            "--autodetect-reference-validate", "true",
            "--enable-bam-indexing", "true",
            "--enable-map-align-output", "true",
            "--enable-map-align", "true",
            "--ref-dir", ref_dir,
            "--output-file-prefix", sample_id,
            "--output-directory", "output",
            "--force",
            "--enable-rna", "true",
            "--rrna-filter-enable", "true",
            "--enable-variant-caller", "false",
            "--enable-cnv", "false",
            "--enable-sv", "false",
            "--repeat-genotype-enable", "false",
            "--enable-single-cell-rna", "true",
            "--umi-source", params.umi_source,
            "--single-cell-global-umi", "true",
            "--rna-library-type", params.rna_library_type,
            "--single-cell-barcode-position", params.barcode_position,
            "--annotation-file", annotation_gtf,
            "--single-cell-umi-position", params.umi_position,
            "--vc-enable-profile-stats", "true",
            "--qc-enable-depth-metrics", "false",
            "--output-format", params.output_format,
            "--enable-metrics-json", "true",
            "--json-dataset-type", "/opt/edico/config/datasettype.json",
            "--keep_all_dragen_logs", "true"
        ]

        if (fastq_list.exists()) {
            args.addAll(["--fastq-list", fastq_list, "--fastq-list-sample-id", sample_id])
        } else {
            args.addAll(["-1", read2, "--RGSM", sample_id, "--RGID", sample_id])
        }

        args.addAll(
            file(params.lic_instance_id_location).exists() ?
                ["--lic-instance-id-location", params.lic_instance_id_location] : []
        )
        args.addAll(
            file(params.barcode_sequence_whitelist).exists() ?
                ["--single-cell-barcode-sequence-whitelist", params.barcode_sequence_whitelist] : []
        )
        args.addAll(params.generate_sa_tags ? ["--generate-sa-tags", "true"] : [])
        args.addAll(params.number_cells ? ["--single-cell-number-cells", params.number_cells] : [])
        args.addAll(params.threshold ? ["--single-cell-threshold", params.threshold] : [])

        if (params.feature_barcode_r2umi) {
            args.addAll(["--single-cell-feature-barcode-r2umi", params.feature_barcode_r2umi])
            if (file(params.cell_hashing_reference).exists()) {
                args.addAll(["--single-cell-cell-hashing-reference", params.cell_hashing_reference])
            }
            if (file(params.feature_barcode_reference).exists()) {
                args.addAll(["--single-cell-feature-barcode-reference", params.feature_barcode_reference])
            }
        }
        if (file(params.cell_hashing_reference).exists()
            || file(params.demux_sample_vcf).exists()
            || file(params.demux_reference_vcf).exists()) {
            args.addAll(
                params.demux_detect_doublets ? ["--single-cell-demux-detect-doublets", "true"] :
                    ["--single-cell-demux-detect-doublets", "false"]
            )
        }

        args.addAll(
            file(params.demux_sample_vcf).exists() ? ["--single-cell-demux-sample-vcf", params.demux_sample_vcf] : []
        )

        if (file(params.demux_reference_vcf).exists() && params.demux_number_samples) {
            args.addAll(
                [
                    "--single-cell-demux-reference-vcf", params.demux_reference_vcf,
                    "--single-cell-demux-number-samples", params.demux_number_samples
                ]
            )
        }
        def dragen_command = "\"${args.join('\" \"')}\""
        """
        set -uox

        $untar_command
        $reconfig_command

        mkdir -p output
        $dragen_command

        mkdir -p output/.basespace && cp -v output/*.metrics.json output/.basespace/dataset.json
        mkdir -p logs/ && \\
            cp -r /var/log/dragen/* logs/ && \\
            rm -rf logs/dragen_last_good_run.log
        $cleanup_command
        """
}

workflow {

    DragenSingleCellRna(
        [file(params.read1), file(params.read2)],
        file(params.fastq_list),
        params.sample_id
    )

}