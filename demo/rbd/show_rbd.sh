oc get route rails-pgsql-persistent -n my-database-app -o jsonpath --template="http://{.spec.host}/articles{'\n'}"
