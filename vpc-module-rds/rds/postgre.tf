# create the db 
resource "aws_db_instance" "python-db" {
  identifier                  = var.identifier
  engine                      = var.engine
  engine_version              = var.vers
  instance_class              = var.instance_class
#  allocated_storage           = var.store1
  #max_allocated_storage       = var.store2
  publicly_accessible         = false
  name                        = var.name
  username                    = var.username
  password                    = var.password
  skip_final_snapshot         = true
  parameter_group_name        = aws_db_parameter_group.postgres.name
  backup_retention_period     = var.retention_period
  deletion_protection         = var.deletion_protection
  multi_az                    = var.multi_az
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true

  vpc_security_group_ids = [aws_security_group.postgres.id]
  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-postgres", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

resource "aws_security_group" "postgres" {
  name_prefix = format("%s-%s-%s-postgres-sg", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
 # vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "postgres_ingress" {
  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.postgres.id
}

resource "aws_security_group_rule" "postgres_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.postgres.id
}

resource "aws_db_subnet_group" "postgres" {
  depends_on = [
    data.aws_subnet.subnet_01,
    data.aws_subnet.subnet_02
  ]
  name = format("%s-%s-%s-postgres-subnet_group", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  subnet_ids = [
    "${data.aws_subnet.subnet_01.id}",
    "${data.aws_subnet.subnet_02.id}"
  ]


}

resource "aws_db_parameter_group" "postgres" {
  name   = var.name_parameter
  family = var.family
}