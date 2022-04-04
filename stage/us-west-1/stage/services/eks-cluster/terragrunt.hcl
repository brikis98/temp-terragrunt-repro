include "root" {
  path = find_in_parent_folders()
}

# Include the component configuration, which has settings that are common for the component across all environments
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/services/eks-cluster.hcl"
  # We want to reference the variables from the included config in this configuration, so we expose it.
  expose = true
}

terraform {
  source = "git::git@github.com:gruntwork-io/terraform-aws-eks.git//modules/eks-cluster?ref=v0.50.0"
}

# ---------------------------------------------------------------------------------------------------------------------
# Module parameters to pass in. Note that these parameters are environment specific.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  asg_default_enable_detailed_monitoring = true

  # We override the AMI filters just for the dev environment to show an example of how you can test a new version of the
  # EKS Cluster AMI in a single environment. This setting replaces the `ami_filters` configuration defined in the base.
  cluster_instance_ami_filters = {
    owners = [include.envcommon.locals.common_vars.locals.account_ids.shared]
    filters = [
      {
        name   = "name"
        values = ["eks-workers-v0.82.0-*"]
      },
    ]
  }
}
