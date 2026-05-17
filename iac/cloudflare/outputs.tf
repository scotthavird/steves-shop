output "pages_preview_url" {
  description = "Cloudflare-generated preview hostname for the Pages project."
  value       = "https://${cloudflare_pages_project.main.subdomain}"
}

output "production_url" {
  description = "Canonical production URL once DNS resolves and the apex redirect is active."
  value       = "https://www.${var.domain_name}"
}

output "project_id" {
  description = "Pages project ID."
  value       = cloudflare_pages_project.main.id
}
