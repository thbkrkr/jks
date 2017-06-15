import jenkins.*
import jenkins.model.*
import hudson.model.*
import java.util.logging.Logger

println "--> disabling the Jenkins CLI"

// disabled CLI access over TCP listener (separate port)
def p = AgentProtocol.all()
p.each { x ->
  if (x.name?.contains("CLI")) {
    p.remove(x)
  }
}

// disable CLI access over /cli URL
def removal = { lst ->
  lst.each { x ->
    if (x.getClass().name.contains("CLIAction")) {
      lst.remove(x)
    }
  }
}

def j = Jenkins.instance
removal(j.getExtensionList(RootAction.class))
removal(j.actions)
