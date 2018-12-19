# Example ALB

This directory contains a few examples to show the usages of an application load balancer.

The following examples are included:
- `lb_internal_no_ssl.tf` - ALB for internal routing, default result: `404 - not found`.
- `lb_no_ssl_public.tf` - ALB route traffic over HTTP, default result: `404 - not found`.
- `lb_ssl_public.tf` - ALB route traffic over SSL via Route53 DNS, default result: `404 - not found`.

The variable `dns_name` needs explicit to be set during a plan or apply.


## Prerequisites for running the example
Terraform is managed via the tool `tfenv`. Ensure you have installed [tfenv](https://github.com/kamatama41/tfenv). And install via tfenv the required terraform version as listed in `.terraform-version`

## Generate ssh and init terraform

```
source ./generate-ssh-key.sh
terraform init

```

## Plan the changes and inspect

```
terraform plan
```

## Create the environment.

```
terraform apply
```

Once done you can test the service via the URL on the console. It can take a few minutes before the service is available


## Cleanup

```
terraform destroy
```
