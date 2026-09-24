# Internal API on AWS

I built this project to practice deploying and operating a small internal API on AWS. The Flask app is intentionally basic; most of the work is in the infrastructure and delivery setup around it.

The API stores items in PostgreSQL and provides `GET` and `POST` endpoints at `/items`, along with health checks. The project uses Docker, Terraform, ECS Fargate, ECR, Secrets Manager, GitHub Actions with OIDC, and CloudWatch.

**[Watch the project walkthrough on YouTube](https://youtu.be/1i83Vgep9Eg)**

## How it fits together

```text
Internal client
      |
      v
Internal Application Load Balancer
      |
      v
ECS Fargate tasks ------> PostgreSQL on RDS
      |
      +------------------> CloudWatch logs and alarms
```

Terraform creates the VPC, subnets, NAT gateways, load balancer, ECS service, ECR repository, database, and monitoring resources. The load balancer is internal, the ECS tasks have no public IPs, and the database only accepts connections from the ECS security group.

## CI/CD

On pull requests to `main`, CI checks formatting and lint, runs the unit tests and dependency audit, then builds and scans the image. It also starts the container with PostgreSQL and checks the API endpoints.

On pushes to `main`, CD uses GitHub OIDC to access AWS, pushes the new image to ECR, and updates the ECS service. It checks the rollout and runs a smoke test; if verification fails, it attempts to restore the previous task definition.

## A few shortcuts and trade-offs

- The app currently uses the RDS master credentials and creates its table at startup. That keeps this demo simple. For a long-running service, I'd give the app a separate, limited database user and handle schema changes outside app startup.
- Terraform state is local and ignored by Git. State can contain sensitive values, so keep it private and backed up. For a shared environment, use encrypted remote state with access controls and locking.
- Two ECS tasks, Multi-AZ RDS, two NAT gateways, an internal load balancer, and Managed Grafana make the setup more resilient and useful to observe, but they cost money while running. They are here to demonstrate those AWS features; a low-cost setup would use fewer resources and have less redundancy.

## Optional bastion

Set `bastion_enabled = true` in `terraform.tfvars` to launch a temporary Amazon Linux 2023 instance. It is accessed through Systems Manager, has no SSH ingress, and sends low-rate requests to the internal ALB's `/health` and `/items` endpoints. Use `journalctl -u internal-api-traffic-generator` in an SSM session to view its logs. Turn it off when you no longer need the traffic generator.
