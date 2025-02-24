**Use Case Overview: Deploying Node.js Microservices on AWS ECS Fargate with Terraform and Monitoring with Prometheus & Grafana **

This use case focuses on deploying two Node.js-based microservices—Patient Service and Appointment Service—on AWS ECS Fargate. The entire infrastructure and application setup are automated using Terraform and GitHub Actions for Continuous Integration/Continuous Deployment (CI/CD). The application services are containerized using Docker and are hosted within a Virtual Private Cloud (VPC) consisting of public and private subnets for secure communication and scaling. 

The project aims to achieve automated deployment, reliable scaling, and secure communication between the services. The use of AWS ECS Fargate ensures that the application runs in a serverless environment, where resources are allocated dynamically, removing the need for managing individual EC2 instances. 

Key Components: 

Node.js Microservices: 

Patient Service: Manages patient data such as name, contact information, medical history, etc. 

Appointment Service: Handles appointment scheduling, cancellation, and management for patients. 

AWS ECS Fargate: 

ECS Fargate is used for running Docker containers without the need to manage the underlying infrastructure. It automates resource allocation and scaling. 

Terraform: 

Terraform is used to automate the creation of AWS resources, such as ECS clusters, VPCs, subnets, and load balancers. It ensures reproducibility and scalability of the environment. 

Docker: 

Both microservices are packaged into Docker containers, ensuring consistency across different environments and simplifying deployment. 

 

GitHub Actions for CI/CD: 

GitHub Actions automates the process of building, testing, and deploying the microservices. Every time there is a code change, the CI/CD pipeline ensures that the latest code is built and deployed to ECS Fargate. 

 

Monitoring with CloudWatch, AWS X-Ray: 

 CloudWatch: Provides monitoring and observability of AWS resources and applications by collecting and tracking metrics, logs, and events in real-time. 

AWS X-Ray: Helps analyze and debug distributed applications by providing insights into application performance, tracing requests, and identifying bottlenecks. 

 

Monitoring with Prometheus and Grafana: 

To ensure the reliability and performance of the deployed microservices, Prometheus and Grafana are incorporated for monitoring and visualization. 

Prometheus: 

Prometheus is used to collect metrics from the Node.js microservices. It scrapes data on various parameters such as request count, response times, error rates, and resource usage (CPU, memory). Prometheus runs as a time-series database and stores these metrics for later analysis. 

Grafana: 

Grafana is integrated with Prometheus to visualize the collected metrics. Dashboards in Grafana will display real-time data and trends, allowing users to monitor the health and performance of the Patient and Appointment services. Alerts can also be configured to notify administrators when certain thresholds are exceeded, such as high error rates or slow response times. 

By incorporating these monitoring tools, the team can ensure the application is running smoothly, detect issues early, and optimize performance through insights provided by Grafana visualizations. 

Goal: 

This project combines modern technologies to build a scalable, reliable, and automated application infrastructure. AWS ECS Fargate handles the deployment and scaling of microservices, while Terraform automates infrastructure provisioning. CI/CD via GitHub Actions ensures that code changes are quickly and safely deployed. Additionally, Prometheus and Grafana provide real-time monitoring and visualization, ensuring that the services perform optimally in a production environment. 

Amazon ECS Overview 

Definition: Fully managed container orchestration service for running and managing Docker containers 

Key Components:  

Cluster: Grouping of resources (Fargate tasks or EC2 instances) 

Task Definition: Specifies Docker container configurations 

Task: Running instance of a task definition 

Service: Ensures the desired number of tasks are running 

 

AWS Fargate (Serverless Compute) 

Definition: Serverless engine for Amazon ECS that runs containers without needing to manage the infrastructure 

Key Features:  

No Infrastructure Management: No EC2 instances to manage 

Auto-Scaling: Scales automatically based on demand 

Pay-per-Use: Charges based on CPU and memory resources 

Ideal for Simplicity: Focus on application logic without worrying about servers 

When to Choose Fargate vs. EC2 

Choose Fargate:  

When you need serverless, scalable, and managed container deployments 

Minimal infrastructure management 

Choose EC2:  

When you need full control over the virtual machine or have complex configurations 

Ideal for persistent storage needs and custom environment setups 

 

 

Architecture Diagram: 
A screenshot of a computer

AI-generated content may be incorrect. 
 

Target Technology Stack 

AWS Environment Setup: 

Virtual Private Cloud (VPC): Isolated network setup with public and private subnets 

Security Groups: Control inbound and outbound traffic to resources in VPC 

Load Balancer: Distributes incoming traffic across ECS tasks in different Availability Zones 

IAM Policies and Roles: Securely manage permissions for users and resources within AWS 

Amazon ECS: 

ECS Cluster: Container orchestration service to manage Docker containers 

ECS Service and Task Definition: Define and manage containerized applications with task definitions specifying container details 

Amazon Elastic Container Registry (ECR): 

Secure container image storage, used to store Docker images 

Amazon S3 and DynamoDB: 

     		For storing statefile and locking mechanism for concurrent access 

AWS Fargate: 

Serverless compute engine for running containers without managing infrastructure 

Amazon CloudWatch and X-Ray Service: 

Real-time monitoring and logging of AWS resources and application performance  

Directory Structure 

The repository is structured as follows: 

Github repository: https://github.com/hassanmirdev/ecs-monitoring.git 

ecs-monitoring 

. 

├── App 

│   ├── Appointment 

│   │   ├── Dockerfile 

│   │   ├── appointment-service.js 

│   │   └── package.json 

│   ├── Patient 

│   │   ├── Dockerfile 

│   │   ├── package.json 

│   │   └── patient-service.js 

│   └── README.md 

└── Infra 

    ├── Environments 

    │   └── dev 

    │       ├── README.md 

    │       ├── backend.tf 

    │       ├── dev-var.tfvars 

    │       ├── main.tf 

    │       ├── outputs.tf 

    │       ├── provider.tf 

    │       ├── variables.tf 

    │       └── versions.tf 

    └── Modules 

        ├── ALB 

        │   ├── main.tf 

        │   ├── outputs.tf 

        │   └── variables.tf 

        ├── Cloudwatch 

        │   ├── main.tf 

        │   ├── outputs.tf 

        │   └── variables.tf 

        ├── ECR 

        │   ├── main.tf 

        │   ├── outputs.tf 

        │   └── variables.tf 

        ├── ECS 

        │   ├── main.tf 

        │   ├── outputs.tf 

        │   └── variables.tf 

        ├── IAM 

        │   ├── main.tf 

        │   ├── outputs.tf 

        │   └── variables.tf 

        └── VPC 

            ├── main.tf 

            ├── outputs.tf 

            └── variables.tf 

  

14 directories, 33 files  

Key Components and Concepts 

Terraform Modules 

Terraform modules are reusable components that encapsulate infrastructure logic. They promote code reusability, maintainability, and scalability. 

Modules in This Project: 

VPC Module: 

Provisions a VPC with public and private subnets, NAT Gateway, Internet Gateway (IGW), and Route Tables (RT). 

Ensures secure and isolated networking for the ECS Fargate tasks. 

ECR Module: 

Provisions an Elastic Container Registry (ECR) for storing Docker images of the microservices. 

ECS Module: 

Provisions an ECS Cluster with Fargate launch type. 

Deploys the microservices in private subnets for enhanced security. 

Setup Xray and CloudWatch Logs. 

ALB Module: 

Provisions an Application Load Balancer (ALB) to route traffic to the ECS services. 

IAM Module: 

Provisions IAM roles and policies for ECS tasks, Fargate, and other AWS resources. 

CloudWatch Module: 

Provisions CloudWatch Logs for monitoring and logging ECS tasks. 

VPC with Public and Private Subnets 

A VPC is a logically isolated network in AWS. This project provisions a VPC with: 

Public Subnets: For resources that need direct internet access (e.g., ALB). 

Private Subnets: For resources that should not be exposed to the internet (e.g., ECS Fargate tasks). 

Key Components: 

Internet Gateway (IGW): Enables communication between the VPC and the internet. 

NAT Gateway: Allows resources in private subnets to access the internet for updates or external API calls. 

Route Tables (RT): Define how traffic is routed within the VPC. 

ECS with Fargate 

Amazon Elastic Container Service (ECS) is a fully managed container orchestration service. Fargate is a serverless compute engine for containers that eliminates the need to manage EC2 instances. 

Why Use ECS Fargate? 

Serverless: No need to manage EC2 instances. 

Scalability: Automatically scales based on demand. 

Security: Tasks run in private subnets, isolated from the public internet. 

 

ECR (Elastic Container Registry) 

ECR is a fully managed Docker container registry that stores, manages, and deploys Docker images. 

Why Use ECR? 

Secure: Integrates with IAM for access control. 

Scalable: Automatically scales with your container workloads. 

Integrated: Works seamlessly with ECS and Fargate. 

Terraform State Management 

Terraform state is stored remotely in an S3 bucket with state locking using a DynamoDB table. 

Why Use Remote State? 

Collaboration: Enables multiple team members to work on the same infrastructure. 

Consistency: Ensures that the state is always up-to-date. 

Locking: Prevents concurrent modifications using DynamoDB. 

GitHub Actions for CI/CD 

GitHub Actions automates the Terraform workflow, including: 

Terraform fmt and validate: Ensures code formatting and syntax correctness. 

Terraform plan: Generates an execution plan for review. 

Terraform apply: Applies the infrastructure changes on merge to the main branch. 

 

Why Use GitHub Actions? 

Automation: Reduces manual effort and human error. 

Consistency: Ensures that all changes are validated and tested before deployment. 

Integration: Works seamlessly with GitHub repositories. 

 

Infra Provisioning using Terraform 

infra/environments/main.tf 

module "vpc" { 
  source            = "../../Modules/VPC" 
  vpc_cidr         = var.vpc_cidr 
  public_subnets   = var.public_subnets 
  private_subnets  = var.private_subnets 
  availability_zones = var.availability_zones 
} 

module "vpc": This declares a vpc module, which is sourced from ../../Modules/VPC. The path tells Terraform to use the VPC module defined in the Modules/VPC directory. 

vpc_cidr, public_subnets, private_subnets, availability_zones: These variables are being passed into the VPC module, which will configure the CIDR block, subnets, and availability zones for your virtual private cloud. 

module "iam" { 
  source = "../../Modules/IAM" 
} 
  

module "iam": This imports the IAM module, which handles creating AWS Identity and Access Management resources like roles, policies, and permissions. The module is located in the Modules/IAM directory. 

module "ecr" { 
	source    = "../../Modules/ECR" 
 	repo_name = var.repo_name 
 } 

module "ecr" (commented): This section is commented out. If enabled, it would source the ECR (Elastic Container Registry) module from the Modules/ECR directory to create an ECR repository for storing Docker images. The repo_name variable would specify the repository name. 

module "ecs" { 
  source          = "../../Modules/ECS" 
  cluster_name    = var.cluster_name 
  task_name       = var.task_name 
  image_url       = var.image_url 
  image_url_patient = var.image_url_patient 
  task_memory     = var.task_memory 
  task_cpu        = var.task_cpu 
  execution_role  = module.iam.ecs_task_role_arn 
  patient_service_name    = var.patient_service_name 
  appointment_service_name = var.appointment_service_name 
  cluster_id      = module.ecs.cluster_id 
  task_definition = module.ecs.task_definition_arn 
  subnets         = module.vpc.private_subnets 
  security_groups = module.alb.sg_id 
  appointment_container_name  = var.appointment_container_name 
  patient_container_name = var.patient_container_name 
  appointment_tg_arn  = module.alb.appointment_tg_arn 
  patient_tg_arn      = module.alb.patient_tg_arn 
  prometheus_tg_arn = module.alb.prometheus_tg_arn 
  grafana_tg_arn = module.alb.grafana_tg_arn 
} 
 

module "ecs": This imports the ECS module from Modules/ECS to manage AWS ECS (Elastic Container Service) clusters and tasks. It sets up containerized services using Docker images. 

cluster_name, task_name, image_url, task_memory, task_cpu: These are configuration parameters that are passed to ECS. image_url represents the location of the Docker image, and task_memory/task_cpu specify the resource allocation for ECS tasks. 

execution_role: The execution_role is pulled from the IAM module (module.iam.ecs_task_role_arn) to specify which IAM role ECS tasks should use to execute. 

patient_service_name, appointment_service_name: These variables represent the names of the services being run (likely corresponding to the Docker containers). 

subnets, security_groups: These parameters specify which subnets and security groups ECS should use, pulling values from the vpc and alb modules. 

appointment_container_name, patient_container_name: The container names for appointment and patient services. 

appointment_tg_arn, patient_tg_arn, prometheus_tg_arn, grafana_tg_arn: These are target group ARNs (Amazon Resource Names) for the load balancer to route traffic to. 

module "alb" { 
  source      = "../../Modules/ALB" 
  vpc_id      = module.vpc.vpc_id 
  subnets     = module.vpc.public_subnets 
  domain_name = var.domain_name 
} 
  

module "alb": This imports the ALB module from the Modules/ALB directory. This module is used to create an Application Load Balancer (ALB) to route traffic to the ECS services. 

vpc_id, subnets, domain_name: These are the configuration parameters for the ALB, specifying which VPC, subnets, and domain name the ALB should use. 

module "monitoring" { 
  source         = "../../Modules/Cloudwatch" 
  log_group_name = var.log_group_name 
} 
  

module "monitoring": This imports the Cloudwatch module, which sets up monitoring and logging for the ECS services using AWS CloudWatch. 

log_group_name: The log group name is passed to the Cloudwatch module for creating the necessary log groups in AWS CloudWatch. 

dev-vars.tf 

This file defines the input variables used in the main.tf configuration. 

aws_region = "us-west-2" 
  

aws_region: Specifies the AWS region where the resources will be deployed. 

vpc_cidr = "10.0.0.0/16" 
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"] 
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"] 
availability_zones = ["us-east-1a", "us-east-1b"] 
  

vpc_cidr, public_subnets, private_subnets, availability_zones: These define the CIDR block for the VPC and the CIDR blocks for public and private subnets, as well as the availability zones to use. 

security_groups = ["sg-09c3b12ec1c311254"] 
  

security_groups: This is the security group ID that will be applied to the ECS services and load balancer. 

repo_name = "my-app-repo" 
cluster_name = "my-ecs-cluster" 
task_name = "my-task" 
appoinment_container_name = "appointment-container" 
image_url = "677276078111.dkr.ecr.us-east-1.amazonaws.com/my-app-repo:appointment-service-latest" 
task_memory = 2048 
task_cpu = 1024 
  

repo_name, cluster_name, task_name, appoinment_container_name: These define the application repository, ECS cluster name, ECS task name, and the appointment container name. 

image_url: URL of the Docker image for the appointment service. 

task_memory, task_cpu: Defines how much memory and CPU the ECS task should use. 

log_group_name = "ecs-application-logs" 
image_url_patient = "677276078111.dkr.ecr.us-east-1.amazonaws.com/my-app-repo:patient-service-latest" 
patient_container_name = "patient-container" 
appointment_service_name = "appointment-service" 
patient_service_name = "patient-service" 
domain_name = "patients.example.com" 
  

log_group_name: The CloudWatch log group name for storing logs. 

image_url_patient: URL for the Docker image of the patient service. 

patient_container_name, appointment_service_name, patient_service_name: Defines container names and service names for the patient and appointment services. 

domain_name: The domain name to associate with the load balancer for routing traffic. 

 

Summary: 

The code provisions an ECS-based microservices architecture with services for appointment and patient (likely corresponding to Docker containers). 

The modules VPC, IAM, ECS, ALB, and Cloudwatch are used to set up the infrastructure, including networking (VPC), security (IAM), container orchestration (ECS), load balancing (ALB), and monitoring (Cloudwatch). 

The dev-vars.tf file defines the configuration variables, such as region, subnets, cluster names, task definitions, and Docker image URLs. 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

Terraform Modules 

1. ALB Module (main.tf) 

resource "aws_security_group" "app_alb_sg" { 
  name_prefix = "app-alb-sg" 
  vpc_id      = var.vpc_id 
 
  egress { 
    from_port   = 0 
    to_port     = 0 
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
 
  ingress { 
    from_port   = 80 
    to_port     = 80 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
 
  ingress { 
    from_port   = 443 
    to_port     = 443 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
   
  ingress { 
    from_port   = 3000 
    to_port     = 3000 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
 
  ingress { 
    from_port   = 3001 
    to_port     = 3001 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
 
  ingress { 
    from_port   = 9090 
    to_port     = 9090 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
 
  tags = { 
    Name = "app-alb-sg" 
  } 
} 
  

Purpose: Defines a security group for the Application Load Balancer (ALB). 

Egress: Allows all outgoing traffic to anywhere (0.0.0.0/0). 

Ingress: Defines multiple ingress rules allowing traffic on:  

Port 80 (HTTP) 

Port 443 (HTTPS) 

Ports 3000, 3001, and 9090 (these could correspond to services like Grafana, Prometheus, or app-specific ports). 

Tags: Names the security group as "app-alb-sg". 

2. Application Load Balancer (ALB) - app_alb 

resource "aws_lb" "app_alb" { 
  name               = var.alb_name 
  internal           = false 
  load_balancer_type = "application" 
  security_groups    = [aws_security_group.app_alb_sg.id] 
  subnets            = var.subnets 
  enable_deletion_protection = false 
  enable_cross_zone_load_balancing = true 
  enable_http2               = true 
 
  tags = { 
    Name = var.alb_name 
  } 
} 
  

Purpose: Creates an ALB that is externally accessible (internal = false). 

security_groups: Associates the ALB with the security group app_alb_sg defined earlier. 

subnets: Specifies the subnets where the ALB will be deployed (provided via the variable var.subnets). 

enable_deletion_protection: Disables protection to allow the ALB to be deleted. 

enable_cross_zone_load_balancing: Enables load balancing across multiple availability zones. 

enable_http2: Enables HTTP/2 for better performance. 

Tags: Tags the ALB with the name provided in var.alb_name. 

3. Target Groups for ALB 

Two target groups are defined for different services: 

Patient Target Group - patient_tg 

resource "aws_lb_target_group" "patient_tg" { 
  name     = "patient-tg" 
  port     = 3002 
  protocol = "HTTP" 
  vpc_id   = var.vpc_id 
  target_type = "ip" 
  health_check { 
    path                = "/health" 
    protocol            = "HTTP" 
    interval            = 30 
    timeout             = 5 
    healthy_threshold   = 3 
    unhealthy_threshold = 3 
    matcher             = "200" 
  } 
} 
  

Purpose: Defines a target group for the "patient" service. 

Port: Listens on port 3002 using the HTTP protocol. 

Health Check: Checks the /health endpoint to ensure the service is healthy. 

Appointment Target Group - appointment_tg 

resource "aws_lb_target_group" "appointment_tg" { 
  name     = "appointment-tg" 
  port     = 3001 
  protocol = "HTTP" 
  vpc_id   = var.vpc_id 
  target_type = "ip" 
  health_check { 
    path                = "/health" 
    protocol            = "HTTP" 
    interval            = 30 
    timeout             = 5 
    healthy_threshold   = 3 
    unhealthy_threshold = 3 
    matcher             = "200" 
  } 
} 
  

Purpose: Defines a target group for the "appointment" service. 

Port: Listens on port 3001 using the HTTP protocol. 

Health Check: Checks the /health endpoint to ensure the service is healthy. 

4. ALB Listener (HTTP - Port 80) 

resource "aws_lb_listener" "http" { 
  load_balancer_arn = aws_lb.app_alb.arn 
  port              = 80 
  protocol          = "HTTP" 
 
  default_action { 
    type = "fixed-response" 
    fixed_response { 
      status_code = 200 
      content_type = "text/plain" 
      message_body = "Welcome to the Service" 
    } 
  } 
} 
  

Purpose: Creates an HTTP listener on port 80 for the ALB. 

Default Action: Returns a simple "Welcome to the Service" message for any traffic that doesn’t match the listener rules. 

5. Listener Rules for Appointment and Patient Services 

Appointment Service Rule 

resource "aws_lb_listener_rule" "appointment_rule" { 
  listener_arn = aws_lb_listener.http.arn 
  priority     = 10 
 
  action { 
    type = "forward" 
    target_group_arn = aws_lb_target_group.appointment_tg.arn 
  } 
 
  condition { 
    path_pattern { 
      values = ["/appointments"] 
    } 
  } 
} 
  

Purpose: Routes traffic with the path /appointments to the appointment_tg target group. 

Patient Service Rule 

resource "aws_lb_listener_rule" "patient_rule" { 
  listener_arn = aws_lb_listener.http.arn 
  priority     = 20 
 
  action { 
    type = "forward" 
    target_group_arn = aws_lb_target_group.patient_tg.arn 
  } 
 
  condition { 
    path_pattern { 
      values = ["/patients"] 
    } 
  } 
} 
  

Purpose: Routes traffic with the path /patients to the patient_tg target group. 

6. Monitoring ALB 

resource "aws_lb" "monitoring" { 
  name               = "monitoring-alb" 
  internal           = false 
  load_balancer_type = "application" 
  security_groups    = [aws_security_group.app_alb_sg.id] 
  subnets           = var.subnets 
} 
  

Purpose: Creates a second ALB for monitoring services like Grafana and Prometheus. 

7. Listeners for Monitoring ALB (Grafana & Prometheus) 

Grafana Listener 

resource "aws_lb_listener" "grafana" { 
  load_balancer_arn = aws_lb.monitoring.arn 
  port              = "3000" 
  protocol          = "HTTP" 
  default_action { 
    type             = "forward" 
    target_group_arn = aws_lb_target_group.grafana.arn 
  } 
} 
  

Purpose: Creates a listener for Grafana on port 3000. 

Action: Forwards traffic to the grafana target group. 

Prometheus Listener 

resource "aws_lb_listener" "prometheus" { 
  load_balancer_arn = aws_lb.monitoring.arn 
  port              = "9090" 
  protocol          = "HTTP" 
  default_action { 
    type             = "forward" 
    target_group_arn = aws_lb_target_group.prometheus.arn 
  } 
} 
  

Purpose: Creates a listener for Prometheus on port 9090. 

Action: Forwards traffic to the prometheus target group. 

8. Target Groups for Grafana and Prometheus 

Prometheus Target Group 

resource "aws_lb_target_group" "prometheus" { 
  name        = "prometheus-tg" 
  port        = 9090 
  protocol    = "HTTP" 
  vpc_id      = var.vpc_id 
  target_type = "ip" 
  health_check { 
    path                = "/-/healthy" 
    healthy_threshold   = 2 
    unhealthy_threshold = 10 
  } 
} 
  

Purpose: Defines a target group for Prometheus on port 9090. 

Health Check: Uses the /healthy path to verify that the Prometheus service is up. 

Grafana Target Group 

resource "aws_lb_target_group" "grafana" { 
  name        = "grafana-tg" 
  port        = 3000 
  protocol    = "HTTP" 
  vpc_id      = var.vpc_id 
  target_type = "ip" 
  health_check { 
    path                = "/api/health" 
    healthy_threshold   = 2 
    unhealthy_threshold = 10 
  } 
} 
  

Purpose: Defines a target group for Grafana on port 3000. 

Health Check: Uses the /api/health path to verify that the Grafana service is up. 

 

Summary: 

This Terraform configuration creates two ALBs: one for application services (e.g., patient and appointment services) and one for monitoring services (e.g., Grafana and Prometheus). It also sets up target groups for each service, defines listeners for HTTP traffic, and configures listener rules for routing traffic based on URL paths. The security group attached to the ALBs ensures that the correct ports (80, 443, 3000, 3001, 9090) are open for inbound traffic. 

 

2. CloudWatch Module (main.tf) 

resource "aws_cloudwatch_log_group" "ecs_logs" { 
  name = "/ecs/${var.log_group_name}" 
} 
  

Creates a CloudWatch log group to store logs for ECS services, where log_group_name is passed as a variable. 

 

3. ECS Module (main.tf) 

Let’s break down the provided Terraform code resource by resource: 

1. ECS Cluster (aws_ecs_cluster.main) 

resource "aws_ecs_cluster" "main" { 
  name = var.cluster_name 
 
  setting { 
    name  = "containerInsights" 
    value = "enabled" 
  } 
} 
  

aws_ecs_cluster.main: Creates an ECS cluster. 

name = var.cluster_name: The cluster is named using the variable cluster_name. 

setting: Enabling container insights for monitoring ECS resources. This allows enhanced visibility into ECS containers' performance. 

2. CloudWatch Log Group (aws_cloudwatch_log_group.ecs_logs) 

resource "aws_cloudwatch_log_group" "ecs_logs" { 
  name              = "/ecs/${var.cluster_name}" 
  retention_in_days = 30  # Adjust as needed 
} 
  

aws_cloudwatch_log_group.ecs_logs: Creates a CloudWatch log group where logs from ECS tasks will be stored. 

name = "/ecs/${var.cluster_name}": Log group name is dynamically generated using the cluster name. 

retention_in_days = 30: Sets the retention period for the logs to 30 days. 

3. Appointment Service Task Definition (aws_ecs_task_definition.appointment_service) 

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
          awslogs-region        = "us-east-1" 
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
          value = "xray.us-east-1.amazonaws.com:2000" 
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
          awslogs-region        = "us-east-1" 
          awslogs-stream-prefix = "xray" 
        } 
      } 
    } 
  ]) 
} 
  

aws_ecs_task_definition.appointment_service: Defines the ECS task definition for the appointment service. 

family = var.task_name: Task family name (e.g., a version identifier) comes from task_name. 

requires_compatibilities = ["FARGATE"]: Specifies that the task uses Fargate launch type. 

network_mode = "awsvpc": Defines the network mode, where each task gets its own elastic network interface (ENI). 

execution_role_arn = var.execution_role: Assigns the execution role ARN to allow ECS tasks to interact with AWS services (like pulling images from ECR). 

cpu = var.task_cpu and memory = var.task_memory: Defines CPU and memory for the task. 

container_definitions: This is where the configuration for containers within the task is provided:  

First container (appointment_service):  

image = var.image_url: Specifies the Docker image for the service. 

portMappings: Maps port 3001 on the container to port 3001 on the host. 

logConfiguration: Configures CloudWatch logging with the appropriate log group. 

Second container (xray-daemon):  

image = "amazon/aws-xray-daemon": A container for AWS X-Ray to capture trace data. 

environment: Configures X-Ray daemon's environment variables. 

logConfiguration: Configures CloudWatch logs for X-Ray. 

4. Prometheus Task Definition (aws_ecs_task_definition.prometheus) 

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
          value = "us-east-1" 
        } 
      ] 
      logConfiguration = { 
        logDriver = "awslogs" 
        options = { 
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name 
          awslogs-region        = "us-east-1" 
          awslogs-stream-prefix = "prometheus" 
        } 
      } 
    } 
  ]) 
} 
  

aws_ecs_task_definition.prometheus: Task definition for Prometheus. 

family = "prometheus-task": Defines the task family name. 

cpu = 256 and memory = 512: Assigns CPU and memory to the task. 

container_definitions: This defines the Prometheus container configuration.  

image = "prom/prometheus:latest": The Docker image for Prometheus. 

portMappings: Exposes Prometheus on port 9090. 

logConfiguration: Logs Prometheus' output to CloudWatch. 

5. Grafana Task Definition (aws_ecs_task_definition.grafana) 

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
          awslogs-region        = "us-east-1" 
          awslogs-stream-prefix = "grafana" 
        } 
      } 
    } 
  ]) 
} 
  

aws_ecs_task_definition.grafana: Task definition for Grafana. 

family = "grafana": Task family name for Grafana. 

container_definitions: Configures the Grafana container, exposing port 3000 and setting up CloudWatch logs. 

6. Patient Service Task Definition (aws_ecs_task_definition.patient_service) 

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
          awslogs-region        = "us-east-1" 
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
          value = "xray.us-east-1.amazonaws.com:2000" 
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
          awslogs-region        = "us-east-1" 
          awslogs-stream-prefix = "xray" 
        } 
      } 
    } 
  ]) 
} 
  

aws_ecs_task_definition.patient_service: Defines a task for the patient service, similar to the appointment service, including the X-Ray daemon container. 

 

The rest of the code (ECS Service definitions) follows a similar pattern for deploying the services (appointment, patient, Prometheus, Grafana) to ECS with load balancing. These services are each configured with Fargate, CloudWatch logs, network settings, and ports exposed for traffic routing. 

7. ECS Services 

The final part involves creating ECS services (for appointment, patient, Prometheus, and Grafana) with load balancing settings to make them accessible via specific ports through the ALB. Each ECS service definition: 

Links to the respective ECS task definition (for example, aws_ecs_task_definition.appointment_service.arn). 

Specifies desired counts, subnets, and security groups for networking. 

Configures a load balancer to route traffic to the service containers. 

 

4. IAM Module (main.tf) 

IAM Roles and Policies 

resource "aws_iam_role" "ecs_task_role" { 
  name = "ecsTaskExecutionRole" 
  assume_role_policy = jsonencode({ 
    Version = "2012-10-17", 
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "ecs-tasks.amazonaws.com" } }] 
  }) 
} 
  

Defines IAM roles for ECS tasks (ecs_task_role) and assigns necessary policies. 

The ecsTaskExecutionRole allows ECS tasks to assume the role for execution. 

resource "aws_iam_role_policy_attachment" "ecs_execution" { 
  role = aws_iam_role.ecs_task_role.name 
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy" 
} 
  

Attaches the AmazonECSTaskExecutionRolePolicy to the ECS task role to allow tasks to interact with AWS resources. 

 

5. VPC (Virtual Private Cloud) 

resource "aws_vpc" "main" { 
  cidr_block = var.vpc_cidr 
  enable_dns_support = true 
  enable_dns_hostnames = true 
 
  tags = { 
    Name = var.vpc_name 
  } 
} 
  

resource "aws_vpc" "main": Creates a VPC with the name "main." 

cidr_block = var.vpc_cidr: Defines the IP address range (CIDR block) of the VPC. The value comes from the variable var.vpc_cidr. 

enable_dns_support = true: Enables DNS resolution within the VPC. 

enable_dns_hostnames = true: Enables DNS hostnames for instances within the VPC. 

tags: Tags the VPC with the name provided in var.vpc_name. 

a. Internet Gateway 

resource "aws_internet_gateway" "main" { 
  vpc_id = aws_vpc.main.id 
 
  tags = { 
    Name = "MainInternetGateway" 
  } 
} 
  

resource "aws_internet_gateway" "main": Creates an Internet Gateway for the VPC. 

vpc_id = aws_vpc.main.id: Associates the internet gateway with the VPC created in the previous resource. 

tags: Tags the internet gateway with the name "MainInternetGateway." 

b. Route Table for Public Subnets 

resource "aws_route_table" "public" { 
  vpc_id = aws_vpc.main.id 
 
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.main.id 
  } 
 
  tags = { 
    Name = "PublicRouteTable" 
  } 
} 
  

resource "aws_route_table" "public": Creates a route table for public subnets. 

vpc_id = aws_vpc.main.id: Associates this route table with the VPC. 

route:  

cidr_block = "0.0.0.0/0": Defines the route for all outbound traffic (0.0.0.0/0 is the default route for all destinations). 

gateway_id = aws_internet_gateway.main.id: Routes outbound traffic to the internet gateway. 

tags: Tags the route table with the name "PublicRouteTable." 

c. Route Table Association for Public Subnets 

resource "aws_route_table_association" "public" { 
  count          = length(var.public_subnets) 
  subnet_id      = aws_subnet.public[count.index].id 
  route_table_id = aws_route_table.public.id 
} 
  

resource "aws_route_table_association" "public": Associates the public subnets with the public route table. 

count = length(var.public_subnets): Loops over the list of public subnets defined in var.public_subnets. 

subnet_id = aws_subnet.public[count.index].id: Associates each public subnet with the route table. 

route_table_id = aws_route_table.public.id: Links the public route table to the public subnets. 

d. Public Subnets 

resource "aws_subnet" "public" { 
  count = length(var.public_subnets) 
  vpc_id = aws_vpc.main.id 
  cidr_block = var.public_subnets[count.index] 
  map_public_ip_on_launch = true 
  availability_zone = element(var.availability_zones, count.index) 
 
  tags = { Name = "public-subnet-${count.index}" } 
} 
  

resource "aws_subnet" "public": Creates public subnets in the VPC. 

count = length(var.public_subnets): Loops over the public subnets defined in var.public_subnets. 

vpc_id = aws_vpc.main.id: Associates the subnets with the VPC created earlier. 

cidr_block = var.public_subnets[count.index]: Uses the CIDR block for each subnet from the var.public_subnets list. 

map_public_ip_on_launch = true: Ensures that instances launched in the subnet will automatically get a public IP address. 

availability_zone = element(var.availability_zones, count.index): Assigns each subnet to an availability zone defined in var.availability_zones. 

tags: Tags each public subnet with a name in the format "public-subnet-${count.index}". 

e. Private Subnets 

resource "aws_subnet" "private" { 
  count = length(var.private_subnets) 
  vpc_id = aws_vpc.main.id 
  cidr_block = var.private_subnets[count.index] 
  availability_zone = element(var.availability_zones, count.index) 
 
  tags = { Name = "private-subnet-${count.index}" } 
} 
  

resource "aws_subnet" "private": Creates private subnets in the VPC. 

count = length(var.private_subnets): Loops over the private subnets defined in var.private_subnets. 

vpc_id = aws_vpc.main.id: Associates the subnets with the VPC created earlier. 

cidr_block = var.private_subnets[count.index]: Uses the CIDR block for each subnet from the var.private_subnets list. 

availability_zone = element(var.availability_zones, count.index): Assigns each subnet to an availability zone defined in var.availability_zones. 

tags: Tags each private subnet with a name in the format "private-subnet-${count.index}". 

f. Elastic IP for NAT Gateway 

resource "aws_eip" "nat" { 
  depends_on = [aws_internet_gateway.main]  
} 
  

resource "aws_eip" "nat": Allocates an Elastic IP address to be used by the NAT Gateway. 

depends_on = [aws_internet_gateway.main]: Ensures that the Internet Gateway is created before the Elastic IP is allocated. 

g. NAT Gateway 

resource "aws_nat_gateway" "nat" { 
  allocation_id = aws_eip.nat.id 
  subnet_id     = aws_subnet.public[0].id  # Use the first public subnet 
  depends_on    = [aws_internet_gateway.main] 
} 
  

resource "aws_nat_gateway" "nat": Creates a NAT Gateway that allows instances in private subnets to access the internet via the public subnet. 

allocation_id = aws_eip.nat.id: Associates the NAT Gateway with the Elastic IP allocated earlier. 

subnet_id = aws_subnet.public[0].id: Places the NAT Gateway in the first public subnet (index 0). 

depends_on = [aws_internet_gateway.main]: Ensures that the Internet Gateway is created before the NAT Gateway. 

h. Route Table for Private Subnets 

resource "aws_route_table" "private" { 
  vpc_id = aws_vpc.main.id 
} 
  

resource "aws_route_table" "private": Creates a route table for private subnets without any routes initially. 

i. Route for Private Subnet Traffic to NAT Gateway 

resource "aws_route" "private_nat_gateway" { 
  route_table_id         = aws_route_table.private.id 
  destination_cidr_block = "0.0.0.0/0" 
  nat_gateway_id         = aws_nat_gateway.nat.id 
} 
  

resource "aws_route" "private_nat_gateway": Creates a route in the private route table. 

route_table_id = aws_route_table.private.id: Specifies the route table for private subnets. 

destination_cidr_block = "0.0.0.0/0": Specifies that all outbound traffic should go through the NAT Gateway. 

nat_gateway_id = aws_nat_gateway.nat.id: Routes traffic from private subnets to the NAT Gateway for internet access. 

j. Route Table Association for Private Subnets 

resource "aws_route_table_association" "private" { 
  count          = length(aws_subnet.private) 
  subnet_id      = aws_subnet.private[count.index].id 
  route_table_id = aws_route_table.private.id 
} 
  

resource "aws_route_table_association" "private": Associates the private subnets with the private route table. 

count = length(aws_subnet.private): Loops over the private subnets. 

subnet_id = aws_subnet.private[count.index].id: Associates each private subnet with the private route table. 

route_table_id = aws_route_table.private.id: Links the private route table to the private subnets. 

 

Detailed Workflow 

Infrastructure Provisioning 

VPC Setup: 

The VPC module provisions the networking infrastructure, including subnets, IGW, NAT Gateway, and route tables. 

ECR Setup: 

The ECR module provisions a repository for storing Docker images. 

ECS Setup: 

The ECS module provisions an ECS cluster and Fargate tasks. 

ALB Setup: 

The ALB module provisions a load balancer to route traffic to the ECS services. 

IAM Setup: 

The IAM module provisions roles and policies for ECS tasks and other resources. 

Application Deployment 

Containerization: 

Docker images for the Patient Service and Appointment Service are built and pushed to ECR. 

ECS Deployment: 

The ECS Fargate tasks are deployed in private subnets, and the ALB routes traffic to the services. 

CI/CD Automation 

Pull Request: 

GitHub Actions runs terraform fmt, validate, and plan to validate changes. 

Merge to Main: 

GitHub Actions runs terraform apply to deploy the infrastructure. 

Best Practices 

Terraform Best Practices 

Modularity: Use modules to encapsulate reusable components. 

Remote State: Store state in an S3 bucket with DynamoDB locking. 

Workspaces: Use workspaces to manage multiple environments (dev, staging, prod). 

Input Variables: Use variables to make the code reusable and configurable. 

Output Values: Use outputs to expose important information (e.g., ECR repository URL, ALB DNS name). 

Security Best Practices 

Private Subnets: Deploy ECS tasks in private subnets for enhanced security. 

IAM Roles: Use least privilege principles for IAM roles and policies. 

Encryption: Enable encryption for ECR repositories and S3 buckets. 

CI/CD Best Practices 

Automated Testing: Run terraform validate and checkov for security scanning. 

Approval Workflow: Require manual approval for terraform apply. 

Documentation: Generate Terraform docs automatically using terraform-docs. 

 

Conclusion 

This use case deploys microservices on AWS Fargate using Terraform and GitHub Actions. By following best practices for modularity, security, and automation, the project ensures a scalable, secure, and maintainable infrastructure. The use of ECS Fargate and private subnets enhances security, while GitHub Actions streamlines the CI/CD process. This approach is ideal for modern cloud-native applications requiring high scalability and resilience. 

 

Automating Terraform Infrastructure and Docker Build/Deployment using GitHub Actions 

This documentation provides an overview of automating the complete process of building Docker images, pushing them to Amazon ECR, provisioning infrastructure, and destroying it — all with Terraform and GitHub Actions. 

The automation process includes the following workflows: 

app-build.yml: Builds Docker images, pushes them to Amazon ECR. 

destroy-infra.yml: Destroys infrastructure after approval. 

infra-prov.yml: Provisions the infrastructure (VPC, IGW, subnets, NAT, EIP, ECR, ECS with Fargate) using Terraform. 

Terraform Validation: Ensures that your infrastructure code is correct using terraform validate. 

Linting and Security Checks: tflint and checkov are used to lint Terraform code and check for security vulnerabilities. 

Markdown Report: Generates and uploads a markdown report in the PR with linting, validation, and security check results. 

PR Approval and Merge: Terraform resources are applied only when the pull request is reviewed, approved, and merged. 

 

1. Workflow Overview 

1.1. app-build.yml - Docker Image Build and ECR Push 

This workflow focuses on automating the process of building Docker images and pushing them to an Amazon Elastic Container Registry (ECR). Docker images are used in environments like ECS (Elastic Container Service) with Fargate for scalable and serverless container deployment. 

Key Concepts: 

Docker Image Build: The process of building a container image from a Dockerfile. This involves creating a self-contained environment with your application, dependencies, and configuration. 

Amazon ECR (Elastic Container Registry): A fully managed Docker container registry where you can store your Docker images. 

GitHub Actions: GitHub's continuous integration and continuous delivery (CI/CD) service, used here to automate Docker image builds, testing, and deployments. 

Process: 

Install Docker: Ensure that Docker is installed and available in the GitHub Actions runner. 

Build Docker Image: The Docker image is built using the docker build command, based on the Dockerfile in the repository. 

Push Image to ECR: The Docker image is tagged with the appropriate ECR repository URL, and pushed using the docker push command. 

1.2. destroy-infra.yml - Infrastructure Destruction 

This workflow ensures that your infrastructure is destroyed safely, typically used when you want to clean up resources after testing or deployment. 

Key Concepts: 

Terraform destroy: Terraform’s destroy command is used to delete the infrastructure that was previously provisioned. This is a crucial step to avoid unnecessary costs and ensure proper cleanup. 

GitHub Actions Trigger: The destruction process is typically triggered manually (using workflow_dispatch) to avoid accidental infrastructure deletions. 

Process: 

Trigger: The destruction workflow is typically triggered manually or after successful reviews to ensure that only authorized users destroy the infrastructure. 

Terraform Destroy: Once triggered, the workflow will run terraform destroy to remove all the infrastructure created during the provisioning stage. 

1.3. infra-prov.yml - Infrastructure Provisioning (Terraform) 

This workflow automates the process of provisioning cloud infrastructure using Terraform. Specifically, this workflow will create resources like VPCs, Subnets, Internet Gateways (IGW), NAT Gateways, Elastic IPs (EIP), Amazon ECR repositories, and ECS services running on AWS Fargate. 

Key Concepts: 

Terraform: A tool used to manage infrastructure as code (IaC). It enables the provisioning, modification, and destruction of infrastructure through declarative configuration files. 

VPC (Virtual Private Cloud): A network that allows users to provision resources and control network settings, such as IP ranges, routing, and security. 

IGW (Internet Gateway): A gateway attached to a VPC that allows communication between instances in the VPC and the internet. 

NAT (Network Address Translation) Gateway: A managed NAT service that allows instances in a private subnet to access the internet securely. 

EIP (Elastic IP): A static IPv4 address that can be associated with instances or resources like NAT Gateways. 

ECR (Elastic Container Registry): A service to store Docker container images. 

ECS with Fargate: A serverless container service where you run Docker containers. Fargate handles the underlying infrastructure, removing the need to manage EC2 instances. 

Process: 

Terraform Init: Initialize Terraform, setting up providers and backends. 

Terraform Plan: Generate an execution plan to ensure Terraform will create the desired resources without errors. 

Terraform Apply: Apply the execution plan, provisioning resources like VPC, subnets, security groups, ECS with Fargate, and ECR repositories. 

 

2. Code Quality and Security Automation 

2.1. Terraform Validate (terraform validate) 

Terraform has a built-in validation mechanism to check if the syntax of your configuration files is correct. 

Purpose: To ensure that Terraform configuration files are valid before applying or deploying them. 

Integration with GitHub Actions: This validation process is typically automated to run on each pull request (PR). If any syntax errors are found, they are flagged, preventing faulty configurations from being applied. 

2.2. tflint - Terraform Linter 

tflint is a Terraform linter that helps you enforce best practices and identify potential issues in your Terraform configuration. 

Purpose: tflint ensures that your Terraform code adheres to best practices and is free of common mistakes, such as missing variables, undefined resources, or misconfigured settings. 

Integration with GitHub Actions: This is run automatically whenever there’s a new pull request or a code update to catch issues early in the CI/CD pipeline. 

Output: The results of tflint are displayed, including warnings and errors about any coding mistakes or non-compliance with best practices. 

2.3. Checkov - Static Code Analysis and Security Checks 

Checkov is a static analysis tool that scans Terraform (and other infrastructure-as-code files) for security vulnerabilities and misconfigurations. 

Purpose: Checkov analyzes your Terraform code and identifies potential security risks or non-compliant configurations, such as open security groups, unencrypted data storage, or inappropriate IAM roles and policies. 

Integration with GitHub Actions: Run checkov as part of the PR process to ensure your infrastructure is not introducing security risks. If a vulnerability is found, it is flagged as a failed check in the PR, preventing it from being merged until reviewed and fixed. 

 

3. GitHub Actions PR Workflow: Validation and Approval 

3.1. Markdown Report Generation 

After running tools like terraform validate, tflint, and checkov, the results are aggregated into a Markdown report. This report is uploaded to the pull request (PR) to provide visibility to the reviewers. 

Purpose: The Markdown report consolidates the output of the validation, linting, and security checks, making it easier for reviewers to assess the state of the code. 

Content:  

Terraform Validate: Syntax and configuration errors (if any). 

tflint: Linting errors or warnings regarding code quality and best practices. 

Checkov: Security vulnerabilities and policy violations. 

3.2. PR Review and Merge 

Review Process: The PR is reviewed by team members to verify the correctness of the changes, review the generated report, and ensure that there are no issues with the infrastructure. 

Approval: Once the PR passes validation checks, security scans, and linting, the reviewers approve the PR. 

Merge: Upon approval, the PR is merged into the main branch, triggering the infrastructure provisioning process (infra-prov.yml) to apply the changes. 

 

4. Applying Terraform Changes Only After PR Merge 

To ensure safe and controlled deployment, Terraform changes are applied only after the pull request is merged into the main branch. This minimizes the risk of applying unreviewed code directly into production. This process can be automated as follows: 

The infra-prov.yml workflow is set to trigger only when a PR is merged into the main branch. 

Terraform provisioning steps (plan and apply) run only on merged code, ensuring that only reviewed and approved changes are deployed. 

 

5. Conclusion 

This setup automates the entire process, from building Docker images and pushing them to Amazon ECR, to provisioning and destroying infrastructure using Terraform, all with the power of GitHub Actions. By integrating validation, linting, and security checks into the CI/CD pipeline, you ensure high-quality code, security, and compliance before making changes to production environments. The automated workflows for building, validating, and deploying infrastructure significantly streamline the deployment process while maintaining security and quality standards. 

 

 

 

 

 

 

Implementation: Application Output 

A screenshot of a computer

AI-generated content may be incorrect.A screenshot of a computer

AI-generated content may be incorrect. 

 

Implementation Outputs: ECS Cluster & Services 

A screenshot of a computer

AI-generated content may be incorrect.A screenshot of a computer

AI-generated content may be incorrect. 

 

Implementaion Outputs: Task Logs 

Implementation Outputs: ECS Tasks 

A screenshot of a computer

AI-generated content may be incorrect. 

CloudWatch Logs Group: X-RAY Service 

A screenshot of a computer

AI-generated content may be incorrect. 

CloudWatch Log Group: App Logs 

 

 

 

Monitoring: Prometheus 

 

 

 

Monitoring: Grafana 

A screenshot of a computer

AI-generated content may be incorrect. 
