resource "yandex_storage_object" "devops-picture" {
  access_key    = yandex_iam_service_account_static_access_key.yisasak-static_key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.yisasak-static_key.secret_key
  bucket        = local.bucket_name
  key           = "devops.jpg"
  source        = "~/devops.jpg"
  acl           = "public-read"
  depends_on    = [yandex_storage_bucket.alexander]
}