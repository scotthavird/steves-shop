variable "cloudflare_api_token" {
  description = "Cloudflare API token. Required scopes: Account.Cloudflare Pages:Edit, Zone.DNS:Edit, Zone.Zone:Read. Set via TF_VAR_cloudflare_api_token env var."
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID (sidebar of dash.cloudflare.com)."
  type        = string
}

variable "domain_name" {
  description = "Root domain (zone). Used for the apex record and as suffix for www."
  type        = string
  default     = "stevesboards.com"
}

variable "namespace" {
  description = "Pages project name. Also the <name>.pages.dev preview hostname — public, pick something publish-friendly."
  type        = string
  default     = "steves-shop"
}

variable "github_owner" {
  description = "GitHub owner of the source repo."
  type        = string
  default     = "scotthavird"
}

variable "github_repo" {
  description = "GitHub repo name."
  type        = string
  default     = "steves-shop"
}
