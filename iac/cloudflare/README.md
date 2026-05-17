# Cloudflare Pages infra for steves-shop

Terraform-managed CF resources for `www.stevesboards.com`. Mirrors the pattern from `contentindexer.com/iac/cloudflare/`.

## What this manages

- `cloudflare_pages_project.main` — Pages project wired to `scotthavird/steves-shop` GitHub repo, auto-deploys on push to `main`
- `cloudflare_pages_domain.root` / `.www` — custom domains on the project
- `cloudflare_record.root` / `.www` — CNAMEs pointing at the Pages subdomain (proxied)
- `cloudflare_ruleset.apex_to_www` — 301 `stevesboards.com/*` → `www.stevesboards.com/*` so search/AI crawlers see one canonical host

## One-time prerequisite (not Terraformed)

The Cloudflare GitHub app must be authorized for `scotthavird/steves-shop` before the first `apply`. In the CF dashboard: **Workers & Pages → Create → Pages → Connect to Git → authorize** for this repo, then cancel out of the wizard. Terraform will create the project on apply.

If a sibling site already authorized the CF app for `scotthavird/*`, this may already be done — just confirm `steves-shop` is in the app's allowed-repo list.

## Apply

```bash
cd iac/cloudflare
cp terraform.tfvars.example terraform.tfvars   # fill in cloudflare_account_id
export TF_VAR_cloudflare_api_token=...          # token with Pages:Edit, DNS:Edit, Zone:Read
terraform init
terraform plan
terraform apply
```

Outputs `pages_preview_url` and `production_url` once applied.

## Verify

```bash
curl -I https://stevesboards.com/        # expect 301 -> https://www.stevesboards.com/
curl -I https://www.stevesboards.com/    # expect 200
```

## State

Local state for now. To move to S3+DynamoDB later, uncomment the backend block in `main.tf` (see `../../../havoptic.com/havoptic-scripts/iac/prod/main.tf` for a working example).
