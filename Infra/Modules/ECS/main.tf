resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.cluster_name}"
  retention_in_days = 30  # Adjust as needed
}

resource "aws_ecs_task_definition" "appointment_service" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions = jsonencode([
    {
      name      = var.appointment_container_name
      image     = var.image_url
      essential = true
      cpu       = 512
      memory    = 1024
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "appointment-service"
        }
      }
    },
    {
      name      = "xray-daemon"
      image     = "amazon/aws-xray-daemon"
      essential = true
      cpu       = 50
      memory    = 128
      environment = [
        {
          name  = "AWS_XRAY_TRACING_NAME"
          value = "appointment-service-trace"
        },
        {
          name  = "AWS_XRAY_DAEMON_ADDRESS"
          value = "xray.us-west-2.amazonaws.com:2000"
        },
        {
          name  = "AWS_XRAY_DAEMON_DISABLE_METADATA"
          value = "true"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "xray"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "prometheus" {
  family                   = "prometheus-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "prometheus"
      image     = "prom/prometheus:latest"
      essential = true
      cpu       = 128
      memory    = 256
      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "AWS_REGION"
          value = "us-west-2"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "prometheus"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "grafana" {
  family                   = "grafana"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn      = var.execution_role
 
  container_definitions = jsonencode([
    {
      name  = "grafana"
      image = "grafana/grafana:latest"
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "GF_SECURITY_ADMIN_PASSWORD"
          value = "admin"
        }
      ]
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "grafana"
        }
      }
    }
  ])
}


    

resource "aws_ecs_task_definition" "patient_service" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions    = jsonencode([
    {
      name  = var.patient_container_name
      image = var.image_url_patient
      memory = 512
      cpu    = 256
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "patient-service"
        }
      }
    },
    {
      name  = "xray-daemon"
      image = "amazon/aws-xray-daemon"
      essential = true
      cpu    = 50
      memory = 128
      environment = [
  {
    name  = "AWS_XRAY_TRACING_NAME"
    value = "appointment-service-trace"
  },
  {
    name  = "AWS_XRAY_DAEMON_ADDRESS"
    value = "xray.us-west-2.amazonaws.com:2000"
  },
  {
    name  = "AWS_XRAY_DAEMON_DISABLE_METADATA"
    value = "true"
  }
]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "xray"
        }
      }
    }
  ])
}



# ECS Service for Appointment Service
resource "aws_ecs_service" "appointment_service" {
  name            = var.appointment_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appointment_service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.appointment_tg_arn
    container_name   = var.appointment_container_name
    container_port   = 3001
  }
}

# ECS Service for Patient Service
resource "aws_ecs_service" "patient_service" {
  name            = var.patient_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.patient_service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.patient_tg_arn
    container_name   = var.patient_container_name
    container_port   = 3000
  }
}

resource "aws_ecs_service" "prometheus" {
  name            = "prometheus-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.prometheus.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.prometheus_tg_arn
    container_name   = "prometheus"
    container_port   = 9090
  }
}

resource "aws_ecs_service" "grafana" {
  name            = "grafana-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.grafana.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.grafana_tg_arn
    container_name   = "grafana"
    container_port   = 3000
  }
}

