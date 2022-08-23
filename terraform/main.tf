terraform {
  backend "s3" {
    bucket = "shintaroa-mention-manager"
    region = "ap-northeast-1"
    key    = "terraform.tfstate"
  }
}

# デフォルトプロバイダ
provider "aws" {
  region = "ap-northeast-1"
}
