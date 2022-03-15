# Creating RDS 
resource "aws_db_instance" "default" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true
  identifier             = "db-1"
  db_subnet_group_name   = aws_db_subnet_group._.id
  multi_az               = var.multi_az
  port                   = var.port
  publicly_accessible    = var.publicly_accessible
  storage_type           = var.storage_type
  vpc_security_group_ids = ["${aws_security_group.sg_private.id}"]

}
