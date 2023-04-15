resource "aws_secretsmanager_secret" "this" {
  for_each = var.secrets
  name     = lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")
  # name_prefix             = lookup(each.value, "name_prefix", null) != null ? lookup(each.value, "name_prefix") : null
  description             = lookup(each.value, "description", null)
  kms_key_id              = lookup(each.value, "kms_key_id", null)
  policy                  = lookup(each.value, "policy", null)
  recovery_window_in_days = lookup(each.value, "recovery_window_in_days", var.recovery_window_in_days)
  tags                    = merge(var.tags, lookup(each.value, "tags", null))

}

resource "aws_secretsmanager_secret_version" "this" {
  for_each      = { for k, v in var.secrets : k => v if !var.unlocked }
  secret_id     = lookup(each.value, "name")
  secret_string = lookup(each.value, "secret_string", null) != null ? lookup(each.value, "secret_string", null) : (lookup(each.value, "secret_key_value", null) != null ? jsonencode(lookup(each.value, "secret_key_value", {})) : null)
  secret_binary = lookup(each.value, "secret_binary", null) != null ? base64encode(lookup(each.value, "secret_binary")) : null
  depends_on    = [aws_secretsmanager_secret.this]
  lifecycle {
    ignore_changes = [
      secret_id,
    ]
  }
}

resource "aws_secretsmanager_secret_version" "this_unlocked" {
  for_each      = { for k, v in var.secrets : k => v if var.unlocked }
  secret_id     = lookup(each.value, "name")
  secret_string = lookup(each.value, "secret_string", null) != null ? lookup(each.value, "secret_string") : (lookup(each.value, "secret_key_value", null) != null ? jsonencode(lookup(each.value, "secret_key_value", {})) : null)
  secret_binary = lookup(each.value, "secret_binary", null) != null ? base64encode(lookup(each.value, "secret_binary")) : null
  depends_on    = [aws_secretsmanager_secret.this]

  lifecycle {
    ignore_changes = [
      secret_string,
      secret_binary,
      secret_id,
    ]
  }
}