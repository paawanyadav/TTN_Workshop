ports         = [22, 80, 8080, 3306, 5601, 3000]
ami           = "ami-04505e74c0741db8d"
instance_type = "t2.micro"


#RDS value assign to variables 
allocated_storage   = 10
engine              = "mysql"
engine_version      = "8.0.27"
instance_class      = "db.t3.micro"
db_name             = "wordpress"
username            = "admin"
password            = "admin123"
multi_az            = true
port                = 3306
publicly_accessible = false
storage_type        = "gp2"


