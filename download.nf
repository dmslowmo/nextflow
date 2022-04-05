#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

params.presignedurl = "https://dev-sgdata-bucket.s3.amazonaws.com/temp-creds-test/temp-creds-20220301084834.json?AWSAccessKeyId=ASIA6NHZ3GMHVHP2FIAA&Signature=uXMi9GccOPb4mGx7ajJ%2B8xRpZ1w%3D&x-amz-security-token=FwoGZXIvYXdzELL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDC%2FFV0alCDmw%2FLsiziLvAXARwSluQtlrQXMSdXsE0yXnP1%2B5rpvKS0S9qoPhDrniVQJVxbW8obxGA4MVgL4XZFtl6Eca60UEOCvb2cSwXftuf3yLcaRQ61V63EsRwQeRUqudlGdaMj4IzV8OpMiggt6odOPYGaJGMKfY0T48V4UpdCM24DUEmrpqtXkT%2Fz1OjYyUo0lzxocb%2FIwvZM4mVhxinUvrvSSBOOmxmiIi2gQ1wVlUjAUz6%2B%2BpYSjBvBzqjx7LVBXn03NQVD97nYJwDDACk1KqzT6ech7FMcu%2BYjgU5l0A5YSJUTuv0qAJ7SqnNVo8kYVV76%2Fh8ilLGgt5KNHa9ZAGMit%2BtA%2BJ2vwsIX2hZ%2ByWTS7IScRmTevg0flLeo%2F82VTnrU6YoEr2979cugZa&Expires=1646142850"

process download {

    container 'broadinstitute/python-requests:latest'
    // publishDir('output', mode: 'move')
    publishDir 'out'

    output:
        path 'test.json', emit: kkk
        path 'aaa.json', emit: hhh

    script:
    //     temp = file(params.presignedurl)
    //     temp.copyTo('output/test.json')

    // """
    // #!/usr/bin/env python3

    // import requests

    // r = requests.get('${params.presignedurl}')
    // print(r.content)
    // open('test.json', 'wb').write(r.content)
    // """
    """
    #!/usr/bin/env bash

    echo "olleh" > test.json
    echo "lalala/$params.presignedurl" >> test.json
    echo "$params.presignedurl"
    echo "aaa" > aaa.json
    """
}

process bbb {
    publishDir 'out'

    input:
        path 'aaa.json'
        path 'test.json'
    
    output:
        path 'bbb.json'

    shell:
    """
    cat test.json
    cat 'test.json' >> 'bbb.json'
    cp aaa.json bbb.json
    """
}

workflow {
    download()
    bbb(download.out.hhh, download.out.kkk)
}
