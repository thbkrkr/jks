/*
 * Disable Jenkins CLI.
 * This init script for Jenkins fixes a zero day vulnerability.
 * http://jenkins-ci.org/content/mitigating-unauthenticated-remote-code-execution-0-day-jenkins-cli
 * https://github.com/jenkinsci-cert/SECURITY-218
 */
import jenkins.*

CLI.get().setEnabled(false)

println "--> disabling the Jenkins CLI"
