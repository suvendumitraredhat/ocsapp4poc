# Get the endpoint
bktname=photo-album

endpoint=$(oc get route s3 -n openshift-storage -o 'jsonpath={.spec.host}')

# Get bucket name
bucket_name=$(oc get cm $bktname -o 'jsonpath={.data.BUCKET_NAME}')

# Get access_key
access_key=$(oc get secrets $bktname -o go-template='{{.data.AWS_ACCESS_KEY_ID | base64decode }}')

# Get secret_key
secret_key=$(oc get secrets $bktname -o go-template='{{.data.AWS_SECRET_ACCESS_KEY | base64decode }}')

echo "AWS_ACCESS_KEY_ID=$access_key AWS_SECRET_ACCESS_KEY=$secret_key aws --endpoint https://$endpoint --no-verify-ssl --recursive s3  ls s3://$bucket_name"
AWS_ACCESS_KEY_ID=$access_key AWS_SECRET_ACCESS_KEY=$secret_key aws --endpoint https://$endpoint --no-verify-ssl --recursive s3  ls s3://$bucket_name
