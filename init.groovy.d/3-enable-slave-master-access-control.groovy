import jenkins.model.*
import jenkins.security.s2m.AdminWhitelistRule

println "--> Enable slave master access control"

Jenkins.instance.injector.getInstance(AdminWhitelistRule.class)
    .setMasterKillSwitch(false);

Jenkins.instance.save()