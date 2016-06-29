import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*

println "--> setting seed ssh creds"

def seedCredsId = System.getenv("SEED_CREDS_ID")
assert seedCredsId != null : "No SEED_CREDS_ID env var provided, but required"

def global_domain = Domain.global()

def credentialsStore =
  Jenkins.instance.getExtensionList(
    'com.cloudbees.plugins.credentials.SystemCredentialsProvider'
  )[0].getStore()

def name = seedCredsId
def id = seedCredsId
def username = seedCredsId
def passphrase = "MMHAXFn3kdfa/rWXyYFYAA==" // FIXME
def privateKey = "/usr/share/jenkins/keys/" + seedCredsId
def keySource = new BasicSSHUserPrivateKey.FileOnMasterPrivateKeySource(privateKey)
def description = ""

// TODO: Test privateKey is a file
def privateKeyFile = new File(privateKey)
//assert privateKeyFile.exists() : privateKey + " doesn't exist"
if (!privateKeyFile.exists()) {
  println "WARNING: " + privateKey + " doesn't exist"
}

def credentials = new BasicSSHUserPrivateKey(
  CredentialsScope.GLOBAL,
  id,
  username,
  keySource,
  passphrase,
  description
)

credentialsStore.addCredentials(global_domain, credentials)
