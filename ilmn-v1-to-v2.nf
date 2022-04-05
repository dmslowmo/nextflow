#!/usr/bin/env nextflow

// Maintainer Raden Indah Kendarsarii
// To transfer data from ICAv1 to ICAv2 using temporary credentials

nextflow.enable.dsl = 2

// parameters

params.tokenv2="eyJraWQiOiI3OWMyZmFkMzM1ODNkOTljMDQ2NTA0Y2U4OGVjMTRkNSIsInR5cCI6IkpXVCIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI4YjY3NjM2ZC05ZGY0LTMwZjEtYThkOC1hMWUxZGQwMWE2ODAiLCJpc3MiOiJodHRwczovL3BsYXRmb3JtLmxvZ2luLmlsbHVtaW5hLmNvbSIsImFjbCI6WyJ1aWQ6OGI2NzYzNmQtOWRmNC0zMGYxLWE4ZDgtYTFlMWRkMDFhNjgwIiwidGlkOllYZHpMWFZ6TFhCc1lYUm1iM0p0T2pFd01EQXdPRFF5T2pBd05XVXlOemc1TFdZMllUSXROR0V3TUMwNU1ESmtMVGRpTWprNFpUVm1ZVGMyTVEiXSwiZ3R5IjoiYXBpX2tleSIsInRpZCI6IllYZHpMWFZ6TFhCc1lYUm1iM0p0T2pFd01EQXdPRFF5T2pBd05XVXlOemc1TFdZMllUSXROR0V3TUMwNU1ESmtMVGRpTWprNFpUVm1ZVGMyTVEiLCJhdWQiOiJpY2EiLCJuYmYiOjE2NDczMzIyNTYsIm1lbSI6eyJ3aWQ6NGZiNTg3OWEtMTQ1Mi0zNzNiLTk1YjUtYWFhMjBhYWM4YjE4IjoiMCwxLDIsMyw0LDUsNiw3LDgsOSwxMCwxMSwxMiwxMywxNCwxNSwxNiwxNyIsIndpZDo0ZGExNmM0Ni01YjUxLTNiNzQtOTFjMS1mMDg3OTYzNzhkZDEiOiIwLDEsMiwzLDQsNSw2LDcsOCw5LDEwLDExLDEyLDEzLDE0LDE1LDE2LDE3IiwidWlkOjhiNjc2MzZkLTlkZjQtMzBmMS1hOGQ4LWExZTFkZDAxYTY4MCI6IioifSwiYXpwIjoiaWNhIiwic2NvcGUiOiJHRFMuRk9MREVSUy5ERUxFVEUsR0RTLkZPTERFUlMuUkVBRCxHRFMuVk9MVU1FUy5HUkFOVCxHRFMuVk9MVU1FUy5DUkVBVEUsR0RTLkZPTERFUlMuR1JBTlQsR0RTLkZJTEVTLlVQREFURSxHRFMuRk9MREVSUy5BUkNISVZFLEdEUy5WT0xVTUVTLkRFTEVURSxHRFMuRklMRVMuREVMRVRFLEdEUy5GSUxFUy5SRUFELEdEUy5GT0xERVJTLlVQREFURSxHRFMuVk9MVU1FUy5BUkNISVZFLEdEUy5GSUxFUy5ET1dOTE9BRCxHRFMuRk9MREVSUy5DUkVBVEUsR0RTLlZPTFVNRVMuVVBEQVRFLEdEUy5GSUxFUy5BUkNISVZFLEdEUy5WT0xVTUVTLlJFQUQsR0RTLkZJTEVTLkNSRUFURSIsInRucyI6ImlsbW4tcHJvZC1wcmVjaXNlIiwiZXhwIjoxNjU1OTcyMjU2LCJpYXQiOjE2NDczMzIyNTYsImp0aSI6ImFXeHRiaTF3Y205a0xYQnlaV05wYzJVc05HRm1NREkyWVdNdFltVmhNeTB6TURFeUxXSTVORFF0T1dGak0yUmhOell3T1RReCJ9.TRDFkcTSIzqc8IVfrFBB3gjr3WHQPD010MkHnP8dsrGZoC-8GxzWIDh3LSCQozbOEAc8sWm-mWAb2Mv-OGlOSxpeK9H2Sa5vCNa42uO32W9caoGtOa12pK6MfyKrIdF8dS9N388nU0w0JcJwO8xZIgXfwhT-QkHG_7rksUMHU99IaFN5TmeKxqBoogLbBsNBe5liCNlGvzq1vc2lyWQ7gmYsIEMtTQiYe8drCFf2vckb8WpO24UP7G6wfYUpOe7729pop8Y8hPb1YfVApeQO0TESR0wTqcGbXHzJ0XSzZe5Xlbky3dQzq0k2rgZ3sBtdBckmPG98Z9Z1GT-8Snnc5A"
params.projectIdv2="23f95d2d-24b4-48c8-bd53-1b8386e349ff"
params.newFolderv2="local-run-001"

params.access_key_id="ASIARFCPI2IGSZSCBCXD"
params.secret_access_key="ICQyPifSUIbSw40MRxf36Gqv4+rNYq0YOBi3moz5"
params.region="ap-southeast-1"
params.server_side_encryption="AES256"
params.session_token="FwoGZXIvYXdzECMaDGeL+q/jjNYdJ/NkKSK4Awe/AMQIETAmztwP7B/9MIgpHlQMITqzHHj+Qesv/MvV2ppNPBSVp6vMxvoaCDs9lCiqqcsVFEegvyU1qGSIUhjR5Cw5g5zQVLGzDrxF7ySUc60GjcL0a9qVllXbEfhCHPUVy1H5CA3glggdxQIeArCmM+lPQCCs4DgBNqUkNWk+bNHUwrCRjk9AXZJ6ZWSn7q7UeeQAVPLHLpny/ZLxXq+vvrQmmnl/K6+KofLS53aAjOYHAlCR4aykAsr9/fRRlPOUvNW5Ej5F3ejMh78pvibxx98HJzSHzpimVP6eU4qqaru1xZJnPeYg+x5diBNlpCNgiZJtjyrm1QH5Yb6ZY1B76F6IABNXcOB5lOf1AaD/FjU23b6oPr8caDK44rEJ8uy0u9d8+ZdzZ8BTde+XrZ5ws1CPlOZXpMi2KXIGb1C0uHxUm8MTKqfk3CWxXS9kT/HPW5dE2NUU0nnigpzlPAxJyO8T11P4L5zLTzbkDPkEuHXAeedRwOQI3a2SgTrA4HuKvFnLFL9sdLnjkYi0N7k8MHBViWQrNgdskU894p3NeHA1pnlJkXp9mowh+uzQTFMh6NQGZEIMKIncxpEGMinYbzT1GFYEDkqcvZWp+APHj58/5YtxoKj5MuHyNE1TAlj//+5PWpiROA=="
params.bucket="stratus-gds-aps1"
params.key_prefix="194e381a-104f-4b55-ebd4-08d95dc306cc/datasets/app.aps1-sh-prod.205205/contractual-metrics/output/"


process getConfigV1 {

    errorStrategy 'retry'
    maxRetries 3
    container 'broadinstitute/python-requests:latest'
  
    publishDir 'out'

    output:
        path 'tmpcredsv1.config', emit: config_v1

"""
#!/usr/bin/env python3

config_file = open('tmpcredsv1.config', 'w')
config_list = [
    '[v1]',
    'type=s3',
    'provider=AWS',
    'no_check_bucket=true'
]
for line in config_list:
    print(line, file=config_file)
print('access_key_id=${params.access_key_id}', file=config_file)
print('secret_access_key=${params.secret_access_key}', file=config_file)
print('region=${params.region}', file=config_file)
print('server_side_encryption=${params.server_side_encryption}', file=config_file)
print('session_token=${params.session_token}', file=config_file)
config_file.close()

print('getConfigV1 done!')

"""
}

// steps in ICAv2

process makeEmptyFolder {
    container 'broadinstitute/python-requests:latest'

    publishDir 'out'

    output:
        path 'folderId.out', emit: folderId
        path 'folderId.json', emit: folderIdJson

    script:
    """
    #!/usr/bin/env python3

    import requests
    import json
    
    projectIdv2 = "${params.projectIdv2}"
    newFolderv2 = "${params.newFolderv2}"
    print(newFolderv2)
    tokenv2 = "${params.tokenv2}"
  
    resp = requests.post(f'https://ica.illumina.com/ica/rest/api/projects/{projectIdv2}/data',
                     headers={'Accept': 'application/vnd.illumina.v3+json',
                            'Content-Type': 'application/vnd.illumina.v3+json',
                            'Authorization': 'Bearer ' + tokenv2},
                     data=json.dumps({
                         'name': newFolderv2,
                         'dataType': 'FOLDER'
                     }))
    f = open('folderId.json', 'w')
    f.write(json.dumps(resp.json()))
    f.close()
    
    folderIdJson = resp.json()
    folder_id = folderIdJson['data']['id']
    f = open('folderId.out', 'w')
    f.write(folder_id)
    f.close()

    """
}


process getTmpCredsv2 {
    container 'broadinstitute/python-requests:latest'
    
    publishDir 'out'

    input:
        path 'folderId.out'
        path 'folderId.json'

    output:
        path 'tmpcredsv2.config', emit: config_v2
        path 'tmpcredsv2.json', emit: tempcredsJson

    shell:
"""
#!/usr/bin/env python3

import requests
import json

projectIdv2 = "${params.projectIdv2}"
tokenv2 = "${params.tokenv2}"

f = open('folderId.out', 'r')
folder_id = f.read()
f.close()

resp = requests.post(f'https://ica.illumina.com/ica/rest/api/projects/{projectIdv2}/data/{folder_id}:createTemporaryCredentials',
                headers={'Accept': 'application/vnd.illumina.v3+json',
                    'Content-Type': 'application/vnd.illumina.v3+json',
                    'Authorization': 'Bearer ' + tokenv2},
                data=json.dumps({'credentialsFormat': 'RCLONE'}))
resp_json = resp.json()
f = open('tmpcredsv2.json', 'w')
f.write(json.dumps(resp_json))
f.close()

print('Generating the rclone config file for ICAv2')

config_file = open('tmpcredsv2.config', 'w')
config_list = [
    '[v2]',
    'type=s3',
    'provider=AWS',
    'no_check_bucket=true'
]
for line in config_list:
    print(line, file=config_file)
print('access_key_id=' + resp_json['rcloneTempCredentials']['config']['access_key_id'], file=config_file)
print('secret_access_key=' + resp_json['rcloneTempCredentials']['config']['secret_access_key'], file=config_file)
print('server_side_encryption=' + resp_json['rcloneTempCredentials']['config']['server_side_encryption'], file=config_file)
print('session_token=' + resp_json['rcloneTempCredentials']['config']['session_token'], file=config_file)
print('region=' + resp_json['rcloneTempCredentials']['config']['region'], file=config_file)
if 'sse_kms_key_id' in resp_json['rcloneTempCredentials']['config']:
    print('sse_kms_key_id=' + resp_json['rcloneTempCredentials']['config']['sse_kms_key_id'], file=config_file)
else:
    print('not encrypted with SSE KMS key')
config_file.close()

print('getTmpCredsV2 done!')

"""
}


process rclone {
    container 'broadinstitute/python-requests:latest'
    
    publishDir 'out'

    input:
        path 'tmpcredsv1.config'
        path 'tmpcredsv2.config'
        path 'tmpcredsv2.json'

    output:
        path 'rclone.config'
        path 'rclone.log'
        path 'rclone.md5'

"""
#!/usr/bin/env python3

import subprocess
import json

f = open('tmpcredsv2.config', 'r')
config_v2 = f.read()
f.close()

f = open('tmpcredsv1.config', 'r')
config_v1 = f.read()
f.close()

f = open('rclone.config', 'w')
print(config_v1, file=f)
print(config_v2, file=f)
f.close()

srcpath = f'v1:/${params.bucket}/${params.key_prefix}'

f = open('tmpcredsv2.json', 'r')
config_v2_jsonstr = f.read()
f.close()
tmpcredsv2 = json.loads(config_v2_jsonstr)
file_prefix = tmpcredsv2['rcloneTempCredentials']['filePathPrefix']
print(f'file_prefix = {file_prefix}')
dstpath = f'v2:/{file_prefix}'

flog = open('rclone.log', 'w')
fmd5 = open('rclone.md5', 'w')

path='/usr/local/bin:/usr/bin'
sync_p = subprocess.run(['/usr/bin/env', '-P', path, 'rclone', 'sync', srcpath, dstpath, '--config', 'rclone.config', '--log-file', 'rclone.log', '-vv'], stdin=subprocess.PIPE, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
check_p = subprocess.run(['/usr/bin/env', '-P', path, 'rclone', 'check', srcpath, dstpath, '--config', 'rclone.config', '--log-file', 'rclone.md5', '-vv'], stdin=subprocess.PIPE, stderr=subprocess.PIPE, stdout=subprocess.PIPE)


flog.close()
fmd5.close()

print("SUCCESS!")
"""
}


workflow {
    getConfigV1()
    makeEmptyFolder()
    getTmpCredsv2(makeEmptyFolder.out.folderId, makeEmptyFolder.out.folderIdJson)
    rclone(getConfigV1.out.config_v1, getTmpCredsv2.out.config_v2, getTmpCredsv2.out.tempcredsJson)
}