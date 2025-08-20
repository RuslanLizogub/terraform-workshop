## Terraform Workshop
Hands-on Terraform labs and modules for learning IaC — from basics to reusable patterns.

### Prerequisites
- Homebrew installed (macOS)
- AWS CLI v2 configured for SSO
- Terraform (installed via Homebrew)

### Install/upgrade tools
- `brew update` — update Homebrew
- `brew install terraform` or `brew upgrade terraform` — install/upgrade Terraform

### AWS SSO login
- `aws configure sso` — one-time SSO profile setup
- `aws sso login --profile tf` — authenticate the `tf` profile

### Project layout
- Root: simple examples and ad-hoc resources
- `gpt-test/`: identity and outputs demo
- `module/` + `resources/`: reusable modules with S3 backend

### Common Terraform commands (root or module directory)
- `terraform init -upgrade` — initialize/upgrade providers
- `terraform plan` — preview changes
- `terraform apply` — apply changes interactively
- `terraform plan -out tfplan` — save plan to file
- `terraform apply tfplan` — apply saved plan
- `terraform destroy` — destroy managed resources

### Backend (module with S3 state)
- Configure S3 and IAM once, then set in `module/main.tf`:
  - bucket: `tf-state-960585837301-eu-north-1` — your S3 bucket for state
  - key: `tfstate/eu-north-1.tfstate` — path/file in the bucket
  - region: `eu-north-1`
  - profile: `tf`

### Troubleshooting
- Locks: `pkill -f "terraform (plan|apply|init)"; pkill -f terraform-provider-; rm -f .terraform.tfstate.lock.info gpt-test/.terraform.tfstate.lock.info; terraform plan -lock-timeout=120s`
- Force unlock (remote backends): `terraform force-unlock <LOCK_ID>`
- Plugin quarantine (macOS): `xattr -dr com.apple.quarantine ~/.terraform.d/plugin-cache .terraform`
- Verify arch: `uname -m` and `terraform -v` (prefer `darwin_arm64` on Apple Silicon)

### Git hygiene
- `.gitignore` excludes Terraform state, lockfiles and `.terraform/` in all subfolders
- To remove mistakenly committed artifacts: `git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch -r .terraform/ .terraform.lock.hcl *.tfstate*' --prune-empty --tag-name-filter cat -- --all` then `git push --force`

### Example workflows
- Root EC2 example:
  - `aws sso login --profile tf`
  - `terraform init && terraform plan && terraform apply`
- Module with S3 backend:
  - `cd module`
  - `aws sso login --profile tf`
  - `terraform init && terraform plan && terraform apply`
