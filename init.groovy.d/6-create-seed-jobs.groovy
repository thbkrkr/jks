
import hudson.model.FreeStyleProject;
import hudson.plugins.git.GitSCM;
import hudson.plugins.git.UserRemoteConfig;
import hudson.plugins.git.BranchSpec;
import hudson.triggers.SCMTrigger;
import javaposse.jobdsl.plugin.*;
import jenkins.model.Jenkins;

println "--> create z_seed-jobs"

def gitSeedScmURL = System.getenv("SEED_JOBS_URL")
assert gitSeedScmURL != null : "No SEED_JOBS_URL env var provided, but required"
println "--> seed jobs url: " + gitSeedScmURL

def gitSeedCredentialsId = System.getenv("SEED_CREDS_ID")

jenkins = Jenkins.instance;

jobName = "z_seed-jobs";
branch = "*/master"

jenkins.items.findAll { job -> job.name == jobName }
  .each { job -> job.delete() }

gitTrigger = new SCMTrigger("H * * * *");
dslBuilder = new ExecuteDslScripts()

dslBuilder.setTargets("**/*.groovy")
dslBuilder.setUseScriptText(false)
dslBuilder.setIgnoreExisting(false)
dslBuilder.setIgnoreMissingFiles(false)
dslBuilder.setRemovedJobAction(RemovedJobAction.DISABLE)
dslBuilder.setRemovedViewAction(RemovedViewAction.IGNORE)
dslBuilder.setLookupStrategy(LookupStrategy.SEED_JOB)

dslProject = new hudson.model.FreeStyleProject(jenkins, jobName);
dslProject.scm = new GitSCM(gitSeedScmURL);
dslProject.scm.branches = [new BranchSpec(branch)];
if (gitSeedCredentialsId != null) {
  println "--> seed jobs credentials: " + gitSeedCredentialsId
  config = new UserRemoteConfig(gitSeedScmURL, null, null, gitSeedCredentialsId)
  dslProject.scm.userRemoteConfigs = [config];
}

dslProject.addTrigger(gitTrigger);
dslProject.createTransientActions();
dslProject.getPublishersList().add(dslBuilder);

jenkins.add(dslProject, jobName);

gitTrigger.start(dslProject, true);