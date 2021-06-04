#!/bin/bash
# Create new project
 oc new-project my-shared-storage

# Launch a file uploader application
oc new-app openshift/php:7.3~https://github.com/christianh814/openshift-php-upload-demo --name=file-uploader
oc set volume deployment file-uploader --add --name=my-shared-storage -t pvc --claim-mode=ReadWriteMany --claim-size=5Gi --claim-name=my-shared-storage --mount-path=/opt/app-root/src/uploaded --claim-class=ocs-storagecluster-cephfs
oc expose svc file-uploader


# Check the progress
oc logs -f bc/file-uploader -n my-shared-storage

