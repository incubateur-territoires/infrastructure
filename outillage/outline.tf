resource "scaleway_object_bucket" "outline" {
  name = "incubateur-outline"
  acl  = "public-read"
  cors_rule {
    allowed_origins = ["https://outline.incubateur.anct.gouv.fr"]
    allowed_methods = ["GET", "POST"]
  }
}