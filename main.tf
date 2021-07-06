module "outillage" {
  source               = "./outillage"
  s3_access_key_id     = var.s3_access_key_id
  s3_secret_access_key = var.s3_secret_access_key
  smtp_address         = var.smtp_address
  smtp_password        = var.smtp_password
  smtp_port            = var.smtp_port
  smtp_user            = var.smtp_user
}