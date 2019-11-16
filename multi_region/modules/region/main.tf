provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
}

module "ecs-app" {
  source = "./ecs-app"
}

module "aurora" {
  source = "./aurora"
}
