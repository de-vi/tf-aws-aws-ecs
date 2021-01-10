resource "aws_iam_role" "instance_role" {
  name               = format("%s-%s", var.name,"instance")
  assume_role_policy = file("${path.module}/instance_role_assume_role_policy.json")
}

resource "aws_iam_role_policy" "instance_role_policy" {
  name   = format("%s-%s", var.name,"instance")
  role   = aws_iam_role.instance_role.id
  policy = file("${path.module}/instance_role_policy.json")
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = format("%s-%s", var.name,"instance-profile")
  role = aws_iam_role.instance_role.name
}
/*
 * Create ECS IAM Service Role and Policy
 */
resource "aws_iam_role" "service_role" {
  name               = format("%s-%s", var.name,"service")
  assume_role_policy = file("${path.module}/ecs_service_role_assume_role_policy.json")
}

resource "aws_iam_role_policy" "service_role_policy" {
  name   = format("%s-%s", var.name,"service")
  role   = aws_iam_role.service_role.id
  policy = file("${path.module}/ecs_service_role_policy.json")
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.name
}

resource "aws_ecs_task_definition" "task_def" {
  family                = var.name
  container_definitions = file("${path.module}/service.json")
}

resource "aws_ecs_service" "app" {
  name            = var.name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count   = 1
  iam_role        = aws_iam_role.service_role.arn
  depends_on      = [aws_iam_role_policy.service_role_policy]

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "app"
    container_port   = 5000
  }

}
