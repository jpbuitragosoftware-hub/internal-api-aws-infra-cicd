# internal-api-aws-infra-cicd
Production-oriented implementation of an internal Python API platform using AWS, Terraform, ECS Fargate, PostgreSQL, CI/CD, and observability.

## Optional temporary bastion

Set `bastion_enabled = true` in `terraform.tfvars` to create the temporary
Amazon Linux 2023 EC2 bastion. It runs in a private subnet by default, has no
SSH ingress, and is accessed through AWS Systems Manager. Its systemd-managed
traffic generator makes low-rate requests to the internal ALB `/health` and
`/items` endpoints and logs response codes and errors to the service journal.
Use `journalctl -u internal-api-traffic-generator` through an SSM session to
inspect activity. Set `bastion_enabled = false` when the traceability workload
is no longer needed.
