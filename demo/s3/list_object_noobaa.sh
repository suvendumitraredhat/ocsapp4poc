# Get the endpoint
bktname=photo-album

endpoint=$(oc get route s3 -n openshift-storage -o 'jsonpath={.spec.host}')

# Get bucket name
bucket_name=$(oc get cm $bktname -o 'jsonpath={.data.BUCKET_NAME}')

# Get access_key
access_key=$(oc get secrets $bktname -o go-template='{{.data.AWS_ACCESS_KEY_ID | base64decode }}')

# Get secret_key
secret_key=$(oc get secrets $bktname -o go-template='{{.data.AWS_SECRET_ACCESS_KEY | base64decode }}')

#AWS_ACCESS_KEY_ID=kgE2c5igOjXIQ9ehWoia AWS_SECRET_ACCESS_KEY=pOvNi3qqkM0nRT/L9j/Uy8UT4KKEjKMk6DvmrTC1 aws --endpoint https://a666f11eb677845eca42f1499c0211e9-335652715.eu-west-1.elb.amazonaws.com:443 --no-verify-ssl s3 ls 

AWS_ACCESS_KEY_ID=$access_key AWS_SECRET_ACCESS_KEY=$secret_key aws --endpoint https://$endpoint --no-verify-ssl --recursive s3  ls s3://$bucket_name
