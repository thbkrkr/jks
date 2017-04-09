import jenkins.model.*

println "--> setting num executors to 5"

Jenkins.instance.setNumExecutors(5)