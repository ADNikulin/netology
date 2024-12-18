locals {
    current_timestamp   = timestamp()
    formatted_date      = formatdate("DD-MM-YYYY", local.current_timestamp)
    bucket_name         = "alexander-${local.formatted_date}"
}

// Создаем сервисный аккаунт для backet
resource "yandex_iam_service_account" "yisa-service" {
  folder_id             = var.folder_id
  name                  = "bucket-sa"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "yrfim-bucket-editor" {
  folder_id             = var.folder_id
  role                  = "storage.editor"
  member                = "serviceAccount:${yandex_iam_service_account.yisa-service.id}"
  depends_on            = [yandex_iam_service_account.yisa-service]
}

resource "yandex_resourcemanager_folder_iam_member" "yrfim-bucket-encrypterDecrypter" {
  folder_id             = var.folder_id
  role                  = "kms.keys.encrypterDecrypter"
  member                = "serviceAccount:${yandex_iam_service_account.yisa-service.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "yisasak-static_key" {
  service_account_id    = yandex_iam_service_account.yisa-service.id
  description           = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "alexander" {
  access_key            = yandex_iam_service_account_static_access_key.yisasak-static_key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.yisasak-static_key.secret_key
  bucket                = local.bucket_name
  acl                   = "public-read-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.secret-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_kms_symmetric_key" "secret-key" {
  name                  = "key-1"
  description           = "ключ для шифрования бакета"
  default_algorithm     = "AES_128"
  rotation_period       = "24h"
}