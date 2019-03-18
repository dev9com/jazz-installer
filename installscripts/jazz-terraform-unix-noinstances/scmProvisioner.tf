// Create Projects in Bitbucket. Will be executed only if the SCM is Bitbucket.
resource "null_resource" "createProjectsInBB" {
  # TODO drop depends_on = ["null_resource.postJenkinsConfiguration"]
  count = "${var.scmbb}"

  provisioner "local-exec" {
<<<<<<< HEAD
    command = "${var.scmclient_cmd} ${lookup(var.scmmap, "scm_username")} ${lookup(var.scmmap, "scm_passwd")} ${lookup(var.scmmap, "scm_elb")} ${var.atlassian_jar_path}"
=======
    command = "${var.scmclient_cmd} ${lookup(var.scmmap, "scm_username")} ${lookup(var.scmmap, "scm_passwd")} ${ lookup(var.scmmap, "scm_elb")} ${var.atlassian_jar_path}"
>>>>>>> upstream/master
  }
}

// Copy the jazz-build-module to SLF in SCM
resource "null_resource" "copyJazzBuildModule" {
  depends_on = ["null_resource.postJenkinsConfiguration", "null_resource.createProjectsInBB"]

  provisioner "local-exec" {
<<<<<<< HEAD
    command = "${var.scmpush_cmd} ${lookup(var.scmmap, "scm_elb")} ${lookup(var.scmmap, "scm_username")} ${lookup(var.scmmap, "scm_passwd")} ${var.cognito_pool_username} ${lookup(var.scmmap, "scm_privatetoken")} ${lookup(var.scmmap, "scm_slfid")} ${lookup(var.scmmap, "scm_type")}  ${lookup(var.jenkinsservermap, "jenkins_elb")} ${lookup(var.jenkinsservermap, "jenkinsuser")} ${lookup(var.jenkinsservermap, "jenkinspasswd")} ${aws_api_gateway_rest_api.jazz-prod.id} ${var.region} builds"
=======
    command = "${var.scmpush_cmd} ${var.scmgitlab == 1 ? join(" ", aws_lb.alb_ecs_gitlab.*.dns_name) : lookup(var.scmmap, "scm_elb") } ${lookup(var.scmmap, "scm_username")} ${lookup(var.scmmap, "scm_passwd")} ${var.cognito_pool_username} ${var.scmgitlab == 1 ? join(" ", data.external.gitlabcontainer.*.result.token) : lookup(var.scmmap, "scm_privatetoken") } ${var.scmgitlab == 1 ? join(" ", data.external.gitlabcontainer.*.result.scm_slfid) : lookup(var.scmmap, "scm_slfid") } ${lookup(var.scmmap, "scm_type")}  ${var.dockerizedJenkins == 1 ? join(" ", aws_lb.alb_ecs_jenkins.*.dns_name) : lookup(var.jenkinsservermap, "jenkins_elb") } ${lookup(var.jenkinsservermap, "jenkinsuser")} ${lookup(var.jenkinsservermap, "jenkinspasswd")} ${aws_api_gateway_rest_api.jazz-prod.id} ${var.region} builds"
>>>>>>> upstream/master
  }
}

// Configure jazz-installer-vars.json and push it to SLF/jazz-build-module
resource "null_resource" "configureJazzBuildModule" {
<<<<<<< HEAD
  depends_on = ["null_resource.copyJazzBuildModule", "null_resource.update_jenkins_configs" ]
  provisioner "local-exec" {
    command = "${var.pushInstallervars_cmd} ${lookup(var.scmmap, "scm_username")} ${urlencode(lookup(var.scmmap, "scm_passwd"))} ${lookup(var.scmmap, "scm_elb")} ${lookup(var.scmmap, "scm_pathext")} ${var.cognito_pool_username}"
=======
  depends_on = ["null_resource.copyJazzBuildModule"]
  provisioner "local-exec" {
    command = "${var.pushInstallervars_cmd} ${lookup(var.scmmap, "scm_username")} ${urlencode(lookup(var.scmmap, "scm_passwd"))} ${var.scmgitlab == 1 ? join(" ", aws_lb.alb_ecs_gitlab.*.dns_name) : lookup(var.scmmap, "scm_elb") } ${lookup(var.scmmap, "scm_pathext")} ${var.cognito_pool_username}"
>>>>>>> upstream/master
  }
}

// Push all other repos to SLF
resource "null_resource" "configureSCMRepos" {
  depends_on = ["null_resource.configureJazzBuildModule"]

  provisioner "local-exec" {
<<<<<<< HEAD
    command = "${var.scmpush_cmd} ${lookup(var.scmmap, "scm_elb")} ${lookup(var.scmmap, "scm_username")} ${lookup(var.scmmap, "scm_passwd")} ${var.cognito_pool_username} ${lookup(var.scmmap, "scm_privatetoken")} ${lookup(var.scmmap, "scm_slfid")} ${lookup(var.scmmap, "scm_type")} ${lookup(var.jenkinsservermap, "jenkins_elb")} ${lookup(var.jenkinsservermap, "jenkinsuser")} ${lookup(var.jenkinsservermap, "jenkinspasswd")} ${aws_api_gateway_rest_api.jazz-prod.id} ${var.region}"
=======
    command = "${var.scmpush_cmd} ${var.scmgitlab == 1 ? join(" ", aws_lb.alb_ecs_gitlab.*.dns_name) : lookup(var.scmmap, "scm_elb") } ${lookup(var.scmmap, "scm_username")} ${lookup(var.scmmap, "scm_passwd")} ${var.cognito_pool_username} ${var.scmgitlab == 1 ? join(" ", data.external.gitlabcontainer.*.result.token) : lookup(var.scmmap, "scm_privatetoken") } ${var.scmgitlab == 1 ? join(" ", data.external.gitlabcontainer.*.result.scm_slfid) : lookup(var.scmmap, "scm_slfid") } ${lookup(var.scmmap, "scm_type")} ${var.dockerizedJenkins == 1 ? join(" ", aws_lb.alb_ecs_jenkins.*.dns_name) : lookup(var.jenkinsservermap, "jenkins_elb") } ${lookup(var.jenkinsservermap, "jenkinsuser")} ${lookup(var.jenkinsservermap, "jenkinspasswd")} ${aws_api_gateway_rest_api.jazz-prod.id} ${var.region}"
>>>>>>> upstream/master
  }
}
