## Access Ceph command https://access.redhat.com/articles/4870821
oc rsh -n openshift-storage $(oc get pods -n openshift-storage -o name -l app=rook-ceph-operator)

sh-5.1$ export CEPH_ARGS='-c /var/lib/rook/openshift-storage/openshift-storage.config'

sh-5.1$ **ceph osd tree**

**#List mapping ceph osd to disk drive**

sh-5.1$ **ceph device ls**

DEVICE                     HOST:DEV                                                        DAEMONS            WEAR  LIFE EXPECTANCY

ATA_QEMU_HARDDISK_QM00001  compact-master-0:sda compact-master-1:sda compact-master-2:sda  osd.0 osd.1 osd.2                       

**sh-5.1$ceph df**

**sh-5.1$ ceph osd pool ls detail**

**sh-5.1$ ceph config dump**

https://access.redhat.com/articles/4870821

Link - https://www.redhat.com/en/blog/10-commands-every-ceph-administrator-should-know


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


## In case daemon crash
ceph crash ls

ceph crash rm <> 

## OCS Debugging
oc get events --sort-by='{.lastTimestamp}' -n openshift-storage

oc logs rook-ceph-osd-0-7d67d6bfd4-f49jb -n openshift-storage -f

## Fillup ODF rbd application
dd if=/dev/zero of=/var/lib/pgsql/data/fill.up bs=1M count=38500
