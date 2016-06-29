// Thanks https://gist.github.com/xbeta/e5edcf239fcdbe3f1672
import jenkins.model.*;
import java.lang.reflect.Field;

if ( Jenkins.instance.pluginManager.activePlugins.find { it.shortName == "hipchat" } != null ) {
  println "--> setting hipchat plugin"

  def descriptor = Jenkins.instance.getDescriptorByType(jenkins.plugins.hipchat.HipChatNotifier.DescriptorImpl.class)

  def hipChatToken = System.getenv("HIPCHAT_TOKEN")
  assert hipChatToken != null : "No HIPCHAT_TOKEN env var provided, but required"

  // no setters :-(
  // Groovy can disregard object's pivacy anyway to directly access private
  // fields, but we use a different technique 'reflection' this time
  Field[] fld = descriptor.class.getDeclaredFields();
  for(Field f:fld){
    f.setAccessible(true);
    switch (f.getName()) {
      case "server":
        f.set(descriptor, "api.hipchat.com")
        break
      case "token":
        f.set(descriptor, hipChatToken)
        break
      case "room":
        f.set(descriptor, "dev")
        break
      case "buildServerUrl":
        f.set(descriptor, "/")
        break
      case "sendAs":
        f.set(descriptor, "jenkinsbot")
        break
    }
  }
}