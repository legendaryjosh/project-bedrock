# Security Group for RDS
resource "aws_security_group" "rds" {
  name        = "project-bedrock-rds-sg"
  description = "Allow database access from EKS nodes"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project-bedrock-rds-sg"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "project-bedrock-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "project-bedrock-db-subnet-group"
  }
}

# MySQL RDS Instance
resource "aws_db_instance" "mysql" {
  identifier        = "project-bedrock-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "catalog"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  multi_az            = false

  tags = {
    Name = "project-bedrock-mysql"
  }
}

# PostgreSQL RDS Instance
resource "aws_db_instance" "postgresql" {
  identifier        = "project-bedrock-postgresql"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "orders"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  multi_az            = false

  tags = {
    Name = "project-bedrock-postgresql"
  }
}

# Store DB credentials in Secrets Manager
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "project-bedrock-db-credentials"

  tags = {
    Name = "project-bedrock-db-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username            = var.db_username
    password            = var.db_password
    mysql_endpoint      = aws_db_instance.mysql.endpoint
    postgresql_endpoint = aws_db_instance.postgresql.endpoint
  })
}
