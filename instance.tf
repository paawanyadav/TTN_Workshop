#s3 bucket for storing backup
terraform {
  backend "s3" {
    bucket = "1project-bucket"
    key    = "bootcamp/ec2/terraform.tfstate"
    region = "us-east-1"

  }
}

# EC2 for Jenkins 
resource "aws_instance" "Jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "LEMPAWS"
  vpc_security_group_ids = [aws_security_group.Security_TF.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("./script/jenkins_Script.sh")
  tags = {
    Name = "jenkins"
  }
}


#EC2 for Monitoring and logs
resource "aws_instance" "Monitoring_Logs" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "LEMPAWS"
  vpc_security_group_ids = [aws_security_group.sg_private.id]
  subnet_id              = aws_subnet.private_subnet.id
  #user_data = file("./script/elastic_script.sh")
  tags = {
    Name = "Monitoring_Logs"
  }
}

