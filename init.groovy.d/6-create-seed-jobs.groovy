
import hudson.model.FreeStyleProject;
import hudson.plugins.git.GitSCM;
import hudson.plugins.git.BranchSpec;
import hudson.triggers.SCMTrigger;
import javaposse.jobdsl.plugin.*;
import jenkins.model.Jenkins;

println "--> create z_seed-jobs"

def gitScmURL = System.getenv("SEED_JOBS_URL")
assert gitScmURL != null : "No SEED_JOBS_URL env var provided, but required"

jenkins = Jenkins.instance;

jobName = "z_seed-jobs";
branch = "*/master"

jenkins.items.findAll { job -> job.name == jobName }
  .each { job -> job.delete() }

gitTrigger = new SCMTrigger("* * * * *");
dslBuilder = new ExecuteDslScripts()

dslBuilder.setTargets("**/*.groovy")
dslBuilder.setUseScriptText(false)
dslBuilder.setIgnoreExisting(false)
dslBuilder.setIgnoreMissingFiles(false)
dslBuilder.setRemovedJobAction(RemovedJobAction.DISABLE)
dslBuilder.setRemovedViewAction(RemovedViewAction.IGNORE)
dslBuilder.setLookupStrategy(LookupStrategy.SEED_JOB)

dslProject = new hudson.model.FreeStyleProject(jenkins, jobName);
dslProject.scm = new GitSCM(gitScmURL);
dslProject.scm.branches = [new BranchSpec(branch)];

dslProject.addTrigger(gitTrigger);
dslProject.createTransientActions();
dslProject.getPublishersList().add(dslBuilder);

jenkins.add(dslProject, jobName);

gitTrigger.start(dslProject, true);