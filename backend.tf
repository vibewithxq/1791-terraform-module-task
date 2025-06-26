## this option enables the use of an s3 bucket for state file management with native locking ###

# terraform {
#   backend "s3" {
#   bucket = "1791-prod-bucket"
#   key = "state-file"
#   region = var.region
#   encrypt = true
#   use_lockfile = true
#   }
# }