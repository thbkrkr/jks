// Thanks https://gist.github.com/hayderimran7/50cb1244cc1e856873a4
import jenkins.model.*
import hudson.security.*

println "--> creating admin user"

def adminUsername = System.getenv("ADMIN_USERNAME")
def adminPassword = System.getenv("ADMIN_PASSWORD")
assert adminPassword != null : "No ADMIN_USERNAME env var provided, but required"
assert adminPassword != null : "No ADMIN_PASSWORD env var provided, but required"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("touriste", "touriste")
Jenkins.instance.setSecurityRealm(hudsonRealm)

hudsonRealm.createAccount(adminUsername, adminPassword)
Jenkins.instance.setSecurityRealm(hudsonRealm)

def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.READ, "touriste")
strategy.add(Jenkins.ADMINISTER, adminUsername)
Jenkins.instance.setAuthorizationStrategy(strategy)

Jenkins.instance.save()
