resource "cloudflare_pages_project" "main" {
  account_id        = var.cloudflare_account_id
  name              = local.namespace
  production_branch = "main"

  build_config {
    build_command   = ""
    destination_dir = ""
    root_dir        = ""
  }

  source {
    type = "github"
    config {
      owner                         = var.github_owner
      repo_name                     = var.github_repo
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "all"
      preview_branch_includes       = ["*"]
      preview_branch_excludes       = []
    }
  }
}

resource "cloudflare_pages_domain" "root" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.main.name
  domain       = var.domain_name
}

resource "cloudflare_pages_domain" "www" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.main.name
  domain       = "www.${var.domain_name}"
}

resource "cloudflare_record" "root" {
  zone_id = local.zone_id
  name    = "@"
  type    = "CNAME"
  value   = cloudflare_pages_project.main.subdomain
  ttl     = 1
  proxied = true
  comment = "Managed by Terraform - steves-shop apex"
}

resource "cloudflare_record" "www" {
  zone_id = local.zone_id
  name    = "www"
  type    = "CNAME"
  value   = cloudflare_pages_project.main.subdomain
  ttl     = 1
  proxied = true
  comment = "Managed by Terraform - steves-shop www"
}
