terraform {
  backend "s3" {
    bucket = "x-point-1-mention-manager"
    region = "ap-northeast-1"
    key    = "terraform.tfstate"
  }
}

# デフォルトプロバイダ
provider "aws" {
  region = "ap-northeast-1"
}
