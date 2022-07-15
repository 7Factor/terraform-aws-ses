# AWS SES Configuration via Terraform

This repo contains all the terraform for creating an SES user and domain identity. Creation of the DKIM, MX, SPF, and DMARC DNS records for SES is out of scope for this module and is assumed to be handled elsewhere in your infrastructure. You can look at the 7F-aws-infrastructure repository to see how those are created.

## How to Use This

Check the variables files for the appropriate configuration depending on your
environment, and run terraform apply. You should
[read the documentation](https://www.terraform.io/docs/configuration/index.html)
on how to use TF before you really do much with it else you might blow something
up. However, not to worry. That's why we have this system in place--if you blow
it away we can simply rebuild it with a few commands.

## Summary

In this doc we'll describe at a very high level what's going on, but you should
really read the variable definitions for development and prod in order to gain
a complete understanding of the details.

## Example Usage

```hcl-terraform
module "networking" {
  source  = "7Factor/ses/aws"
  version = "~> 1"

  dmarc_email   = "youremail@7factor.io"
  domain_name   = "domain.com"
  route53_zone_id = "Z1PSM7MU3C2H4Z"
}
```

## Migrating to Terraform Registry version

We have migrated this module to the 
[Terraform Registry](https://registry.terraform.io/modules/7Factor/ses/aws/latest)! Going forward, you should
endeavour to use the registry as the source for this module. It is also **highly recommended** that you migrate existing
projects to the new source at your earliest convenience. Using it in this way, you can select a range of versions to use
in your service which allows us to make potentially breaking changes to the module without breaking your service.

For new versions of this module, make sure to commit changes to the **main** branch, and not 'master'. The 'master' branch is deprecated and maintained for backwards compatibility as it was the first version of this module before we registered it in Terraform. That way we prevent other teams from having to update the version number on their existing pipelines. But moving forward, please use **main**.

### Migration instructions

You need to change the module source from the GitHub url to `7Factor/ses/aws`. This will pull the module from
the Terraform registry. You should also add a version to the module block. See the [example](#example-usage) above for
what this looks like together.

**Major version 1 is intended to maintain backwards compatibility with the old module source.** To use the new module
source and maintain compatibility, set your version to `"~> 1"`. This means you will receive any updates that are
backwards compatible with the old module. 