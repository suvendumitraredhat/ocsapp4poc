oc get route photo-album -n demo -o jsonpath --template="http://{.spec.host}{'\n'}"
