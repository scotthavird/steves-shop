resource "cloudflare_ruleset" "apex_to_www" {
  zone_id     = local.zone_id
  name        = "Redirect apex to www"
  description = "301 ${var.domain_name}/* -> www.${var.domain_name}/*"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    action      = "redirect"
    expression  = "(http.host eq \"${var.domain_name}\")"
    description = "Apex to www canonical redirect"
    enabled     = true

    action_parameters {
      from_value {
        status_code           = 301
        preserve_query_string = true
        target_url {
          expression = "concat(\"https://www.${var.domain_name}\", http.request.uri.path)"
        }
      }
    }
  }
}
