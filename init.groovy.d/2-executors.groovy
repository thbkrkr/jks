import jenkins.model.*

println "--> setting num executors"

Jenkins.instance.setNumExecutors(5)