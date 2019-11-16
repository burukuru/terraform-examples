module "global" {
  source = "../../modules/global"
}

module "us_east_1" {
  source = "../../modules/region"
  region = "us-east-1"
}

module "us_west_1" {
  source = "../../modules/region"
  region = "us-west-1"
}
