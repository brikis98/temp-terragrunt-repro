locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
  vpc_name     = local.environment_vars.locals.vpc_name
}

terraform {
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)
