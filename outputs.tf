output "secret_ids" {
  description = "Secret ids map"
  value       = { for k, v in aws_secretsmanager_secret.this : k => v["id"] }
}

output "secret_arns" {
  description = "Secrets arns map"
  value       = { for k, v in aws_secretsmanager_secret.this : k => v["arn"] }
}