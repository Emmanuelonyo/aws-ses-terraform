
resource "aws_s3_bucket" "ms" {
  bucket = "cloudnolx-test-bucket-dev"
}

resource "aws_s3_bucket_ownership_controls" "ms" {
  bucket = aws_s3_bucket.ms.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "ms" {
  bucket = aws_s3_bucket.ms.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "ms" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ms,
    aws_s3_bucket_public_access_block.ms,
  ]

  bucket = aws_s3_bucket.ms.id
  acl    = "public-read"
}