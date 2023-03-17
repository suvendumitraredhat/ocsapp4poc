# ocsapp4poc
OCS App for PoC

git clone https://github.com/luisrico/ocs-operator.git

GitHub
luisrico/ocs-operator
Operator for RHOCS. Contribute to luisrico/ocs-operator development by creating an account on GitHub.
## RWO Example: mysql
oc new-project test
oc get pvc 
oc get pod
oc create -f ocs-operator/mysql.yaml

## RWX Example:
oc new-app openshift/php:7.3~https://github.com/christianh814/openshift-php-upload-demo --name=file-uploader
oc expose svc file-uploader
oc get route
oc set volume deployment file-uploader --add --name=my-shared-storage -t pvc --claim-mode=ReadWriteMany --claim-size=5Gi --claim-name=my-shared-storage --mount-path=/opt/app-root/src/uploaded --claim-class=ocs-storagecluster-cephfs

## OBC example: 
git clone https://github.com/ksingh7/openshift-photo-album-app.git
oc adm policy add-scc-to-user anyuid -z default -n test
oc get route -n openshift-storage 
vi openshift-photo_album/photo_album_app_on_OCS_OBC.yaml <-- add ENDPOINT_URL_S3 from oc describe noobaa
oc apply -f openshift-photo_album/photo_album_app_on_OCS_OBC.yaml
oc get cm photo-album
oc get secret photo-album
Scaling number of workers... if it's OpenShift IPI deployment:
## Scale number of workers:
oc get machineset -n openshift-machine-api 
oc -n openshift-machine-api scale machinesets xxxxxxxx --replicas=2

## Label nodes for OCS and then "Add Capacity" to OCS cluster
oc get nodes | grep worker | cut -d' ' -f1 | while read worker_node; do oc label nodes $worker_node cluster.ocs.openshift.io/openshift-storage='';done

## Access Ceph command
oc rsh -n openshift-storage $(oc get pods -n openshift-storage -o name -l app=rook-ceph-operator)

export CEPH_ARGS='-c /var/lib/rook/openshift-storage/openshift-storage.config'

https://access.redhat.com/articles/4870821

#oc patch OCSInitialization ocsinit -n openshift-storage --type json --patch  '[{ "op": "replace", "path": "/spec/enableCephTools", "value": true }]'

## In case daemon crash
ceph crash ls

ceph crash rm <> 

## OCS Debugging
oc get events --sort-by='{.lastTimestamp}' -n openshift-storage

oc logs rook-ceph-osd-0-7d67d6bfd4-f49jb -n openshift-storage -f

## Fillup ODF rbd application
dd if=/dev/zero of=/var/lib/pgsql/data/fill.up bs=1M count=38500
