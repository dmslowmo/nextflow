#!/usr/bin/env nextflow

// To transfer data from ICAv1 to ICAv2 using temporary credentials

nextflow.enable.dsl = 2

// parameters

params.tokenv2="eyJraWQiOiI3OWMyZmFkMzM1ODNkOTljMDQ2NTA0Y2U4OGVjMTRkNSIsInR5cCI6IkpXVCIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI4YjY3NjM2ZC05ZGY0LTMwZjEtYThkOC1hMWUxZGQwMWE2ODAiLCJpc3MiOiJodHRwczovL3BsYXRmb3JtLmxvZ2luLmlsbHVtaW5hLmNvbSIsImFjbCI6WyJ1aWQ6OGI2NzYzNmQtOWRmNC0zMGYxLWE4ZDgtYTFlMWRkMDFhNjgwIiwidGlkOllYZHpMWFZ6TFhCc1lYUm1iM0p0T2pFd01EQXdPRFF5T2pBd05XVXlOemc1TFdZMllUSXROR0V3TUMwNU1ESmtMVGRpTWprNFpUVm1ZVGMyTVEiXSwiZ3R5IjoiYXBpX2tleSIsInRpZCI6IllYZHpMWFZ6TFhCc1lYUm1iM0p0T2pFd01EQXdPRFF5T2pBd05XVXlOemc1TFdZMllUSXROR0V3TUMwNU1ESmtMVGRpTWprNFpUVm1ZVGMyTVEiLCJhdWQiOiJpY2EiLCJuYmYiOjE2NDc4Mzg2ODQsIm1lbSI6eyJ3aWQ6NGZiNTg3OWEtMTQ1Mi0zNzNiLTk1YjUtYWFhMjBhYWM4YjE4IjoiMCwxLDIsMyw0LDUsNiw3LDgsOSwxMCwxMSwxMiwxMywxNCwxNSwxNiwxNyIsIndpZDo0ZGExNmM0Ni01YjUxLTNiNzQtOTFjMS1mMDg3OTYzNzhkZDEiOiIwLDEsMiwzLDQsNSw2LDcsOCw5LDEwLDExLDEyLDEzLDE0LDE1LDE2LDE3IiwidWlkOjhiNjc2MzZkLTlkZjQtMzBmMS1hOGQ4LWExZTFkZDAxYTY4MCI6IioifSwiYXpwIjoiaWNhIiwic2NvcGUiOiJHRFMuRk9MREVSUy5ERUxFVEUsR0RTLkZPTERFUlMuUkVBRCxHRFMuVk9MVU1FUy5HUkFOVCxHRFMuVk9MVU1FUy5DUkVBVEUsR0RTLkZPTERFUlMuR1JBTlQsR0RTLkZJTEVTLlVQREFURSxHRFMuRk9MREVSUy5BUkNISVZFLEdEUy5WT0xVTUVTLkRFTEVURSxHRFMuRklMRVMuREVMRVRFLEdEUy5GSUxFUy5SRUFELEdEUy5GT0xERVJTLlVQREFURSxHRFMuVk9MVU1FUy5BUkNISVZFLEdEUy5GSUxFUy5ET1dOTE9BRCxHRFMuRk9MREVSUy5DUkVBVEUsR0RTLlZPTFVNRVMuVVBEQVRFLEdEUy5GSUxFUy5BUkNISVZFLEdEUy5WT0xVTUVTLlJFQUQsR0RTLkZJTEVTLkNSRUFURSIsInRucyI6ImlsbW4tcHJvZC1wcmVjaXNlIiwiZXhwIjoxNjU2NDc4Njg0LCJpYXQiOjE2NDc4Mzg2ODQsImp0aSI6ImFXeHRiaTF3Y205a0xYQnlaV05wYzJVc016Vmxaakl4TVdRdFlUUmhNaTB6TjJKaExUa3haVFV0WkdOak5HTTVaVGcxTldZMyJ9.i0-7rRB6t97tlt0w8EUq8JPZrzKMs976SwjKh9btAlR29W_wChyyYxH4lesU5-khcX36v0uHFt1vWXIOp403mJP4QC-VzdsiySKWoLoWCTw2gOa-p-sWcWQ9rixOik2c2Q4i2Ewf_fokZA9qqLXK4mPqXthdD2xfdiHmRtX3HMHnOQSHjAQ0Y77XHgbeDhzFx2pZ3wpHhAxyNH1dRtWPHmofTb0jlXZb342J_8drquSprUqfCIL6JeJuG_lThftR6eQ-2q9-4VSDoPJyrbsSUpv7v38pcdNdgDCh08LB_w7nQ_RSz0Yqs7MA_ZTqTJBZ15hmb95MKZlY7HGjsXZ3EA"
params.projectIdv2="23f95d2d-24b4-48c8-bd53-1b8386e349ff"
params.newFolderv2="local-run-006"

params.access_key_id="ASIARFCPI2IGWWSXD3WE"
params.secret_access_key="CGKgjNJypihx3FgUYAE4uK2V5Uib2NGnyFrbrSYU"
params.region="ap-southeast-1"
params.server_side_encryption="AES256"
params.session_token="FwoGZXIvYXdzEJb//////////wEaDD9VWkcZu2zJvIeHwSKhA5ZbzPRLW/3KgXTZFyOtW5PlqDDK/gbLL2r9DbBjvQ2aFgjjlxeRhUhIRVNWJ2pv7Qx/XO/dblD4KeW0rlZqZSg7iGqpW0N/NnlHseAKYjvBchM/9a1eOljelZjhvOUDeY6VMpH/smqEV/XHmrhdT3Rdew/B2/dr8nZ06annFIaD/xnVzmpqIjAgiJ5TC627OERX6bv097m6SJEhJoWoz6XNwE6GxOl6tYeg+IAJv6oQkasQCpwhesOeFGIIy7OAICZKjfdWm3KJtMUiaKEvLGssqEyFvv7hc5Y20np/KBvVC2K05ibxWlvHN+QIAj9b137AVVTWa7nuxLjYxv3dHo6sYLub2jAmFN3Cm/GdnQJQEYs+IgqE1X0rs3QLeY/652NH4kqrabohgB3QPO9dStl7U3dHZKDoD4XcjbcHcPBbEjNym+h3lz6TNApwMbchjm6RVeZtzkxLrLpaSa6I2DSLwhdEP70eVZQJGrmIZl43XCgPFGE821yNCRDvcCmIlZdcA1v2p4RyJgGE9rhFJdLcnrwPbRU7Z+SzwFlB9xRN9iili+CRBjIpG9featUD1kyXioPZfSxAye6EQPo9coBcEA0zlqvdUJHsKOuYBqNNAms="
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

    script:
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
    container 'rikscratch/test01-pub:second-try'
    
    publishDir 'out'

    input:
        path 'tmpcredsv1.config'
        path 'tmpcredsv2.config'
        path 'tmpcredsv2.json'

    output:
        path 'rclone.config'
        path 'rclone.log'
        path 'rclone.md5'

    shell:
'''
cat tmpcredsv1.config > rclone.config
echo "" >> rclone.config
cat tmpcredsv2.config >> rclone.config
touch rclone.log
touch rclone.md5
srcpath="v1:/!{params.bucket}/!{params.key_prefix}"
dstpath="v2:/$(jq -r .rcloneTempCredentials.filePathPrefix tmpcredsv2.json)"

rclone sync $srcpath $dstpath --config rclone.config --log-file rclone.log -vv
rclone check $srcpath $dstpath --config rclone.config --log-file rclone.md5 -vv

'''
}

process deleteTempCredsFiles {
    input:
        path 'tmpcredsv1.config'
        path 'tmpcredsv2.config'
        path 'tmpcredsv2.json'

    script:
    myFile = file('tmpcredsv1.config')
    result = myFile.delete()
    println result ? "OK" : "Cannot delete: $myFile"    

    myFile = file('tmpcredsv2.config')
    result = myFile.delete()
    println result ? "OK" : "Cannot delete: $myFile"

    myFile = file('tmpcredsv2.json')
    result = myFile.delete()
    println result ? "OK" : "Cannot delete: $myFile" 

}


workflow {
    getConfigV1()
    makeEmptyFolder()
    getTmpCredsv2(makeEmptyFolder.out.folderId, makeEmptyFolder.out.folderIdJson)
    rclone(getConfigV1.out.config_v1, getTmpCredsv2.out.config_v2, getTmpCredsv2.out.tempcredsJson)
    deleteTempCredsFiles(getConfigV1.out.config_v1, getTmpCredsv2.out.config_v2, getTmpCredsv2.out.tempcredsJson)
}