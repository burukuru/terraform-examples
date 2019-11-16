resource "aws_ecs_task_definition" "test_task_def" {
  family                   = "test_task_def"
  container_definitions    = file("${path.module}/task_definition/service.json")
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
}

resource "aws_ecs_service" "test_service" {
  name            = "test_service"
  task_definition = aws_ecs_task_definition.test_task_def.arn
  cluster         = aws_ecs_cluster.test_cluster.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnet_ids.default.ids
    assign_public_ip = true
  }
}

resource "aws_ecs_cluster" "test_cluster" {
  name = "test_cluster"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
