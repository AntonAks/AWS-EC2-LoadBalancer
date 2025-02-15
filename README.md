# Terraform AWS EC2 and Load Balancer Example

## Description

This Terraform project demonstrates how to create three EC2 instances and a Load Balancer in AWS. It serves as a basic example for deploying infrastructure as code (IaC) using Terraform.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html)
- AWS CLI configured with appropriate credentials

## Usage

1. **Clone the repository**

2. **Initialize & Validate Terraform**

   ```sh
   terraform init
   terraform validate
   ```

3. **Plan the infrastructure**

   ```sh
   terraform plan
   ```

4. **Apply the configuration**

   ```sh
   terraform apply
   ```

## Cleanup

To remove the created resources, run:

```sh
terraform destroy
```

## Notes

- This is a simple example and may require modifications for production use.
- Ensure your AWS credentials and permissions are correctly configured.

---

Feel free to contribute or modify the project as needed!

