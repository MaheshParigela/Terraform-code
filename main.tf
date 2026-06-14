
# creating multiple providers in aws using terraform.
/*provider "aws" {
  region = "ap-south-2"

}

provider "aws" {
  region = "us-east-1"
  alias  = "usa"
}


resource "aws_instance" "Webserver" {
  ami           = "ami-04e44fc07a0954cc9"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0a1d9f2bed733b4ba"

  tags = {
    Name = "Hyderabad-Webserver"
  }
}

resource "aws_s3_bucket" "mybucket" {
    bucket = "bucket-tf-0606"
}

resource "aws_instance" "usaserver" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = "t3.small"
  provider        = aws.usa

  tags = {
    Name = "Virginia-Webserver"
  }
}

output "instance_id" {
  value = aws_instance.Webserver.id
}

output "instance_public_ip" {
  value = aws_instance.Webserver.public_ip
}
output "instance_region" {
  value = aws_instance.Webserver.region
}

output "usaserver_id" {
  value = aws_instance.usaserver.id
}
output "usaserver_public_ip" {
  value = aws_instance.usaserver.public_ip
}

output "mybucket_name" {
  value = aws_s3_bucket.mybucket.bucket
} */
#COUNT - META-ARGUMENT-EXAMPLE

/*provider "aws" {
  region = "ap-south-2"
}

resource "aws_instance" "webserver" {
  count         = 3
  ami           = "ami-04e44fc07a0954cc9"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0a1d9f2bed733b4ba"
  tags = {
    Name = "Web-server-${count.index}"
  }
}

output "instance_id" {
  value = aws_instance.webserver[*].id
}*/

# FOR_EACH - META-ARGUMENT-EXAMPLE
/*provider "aws" {
  region = "ap-south-2"
}
locals {
    servers ={
        dev ="t3.micro",
        uat ="t3.small",
       # prod="t3.medium"        
    }
}
resource "aws_instance" "webserver"{
    for_each = local.servers
    ami = "ami-04e44fc07a0954cc9"
    instance_type = each.value
    subnet_id     = "subnet-0a1d9f2bed733b4ba"
    tags = {
        Name = "${each.key}-webserver"
        environment = each.key
    }
}*/
#FOR EACH ANOTHER EXAMPLE WITH TOSET- META-ARGUMENT-EXAMPLE
/*provider "aws" {
  region = "ap-south-2"
}


resource "aws_instance" "webserver" {
  for_each      = toset(["dev", "uat"])
  ami           = "ami-04e44fc07a0954cc9"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0a1d9f2bed733b4ba"
  tags = {
    Name = "$(each.key)-webserver"
  }
}*/
# Dependency in terraform
/*provider "aws" {
  region = "ap-south-2"
}
provider "aws" {
  region = "us-east-1"
  alias  = "usa"
}
resource "aws_instance" "webserver" {
  ami           = "ami-04e44fc07a0954cc9"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0a1d9f2bed733b4ba"
  tags = {
    Name = "Hyderabad-Webserver"
  }
}

resource "aws_instance" "usaserver" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = "t3.micro"
  provider      = aws.usa
  depends_on    = [aws_instance.webserver]
  tags = {
    Name = "Virginia-Webserver"
  }
}

output "instance_id" {
  value = aws_instance.webserver.id
}
output "instance_public_ip" {
  value = aws_instance.webserver.public_ip
}
output "instance_id_usa" {
  value = aws_instance.usaserver.id
}
output "instance_public_ip_usa" {
  value = aws_instance.usaserver.public_ip
}*/
# Launching an web server using user data in terraform
/* provider "aws" {
  region = "ap-south-2"
}
provider "aws" {
  region = "us-east-1"
  alias  = "usa"
}
resource "aws_instance" "webserver" {
  ami                    = "ami-04e44fc07a0954cc9"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0a1d9f2bed733b4ba"
  vpc_security_group_ids = ["sg-06bb6e87c7de719a7"]
  user_data              = file("C:\\Users\\Mahesh\\Desktop\\MyDevops_Journey\\Terraform-Code\\hyduserdata.txt")
  tags = {
    Name = "India-Webserver"
  }
}

resource "aws_instance" "usaserver" {
  ami                    = "ami-091138d0f0d41ff90"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-0abc4655c92aaeefe"]
  user_data              = file("C:\\Users\\Mahesh\\Desktop\\MyDevops_Journey\\Terraform-Code\\Ususerdata.txt")
  provider               = aws.usa
  depends_on             = [aws_instance.webserver]
  tags = {
    Name = "USA-Webserver"
  }
}

output "instance_id" {
  value = aws_instance.webserver.id
}
output "instance_public_ip" {
  value = aws_instance.webserver.public_ip
}
output "instance_id_usa" {
  value = aws_instance.usaserver.id
}
output "instance_public_ip_usa" {
  value = aws_instance.usaserver.public_ip
}  */
# Prevent destroying of resource in terraform
/*provider "aws" {
  region = "ap-south-2"
}
resource "aws_instance" "webserver" {
  ami           = "ami-04e44fc07a0954cc9"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0a1d9f2bed733b4ba"
  tags = {
    Name = "Web-server"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [instance_type]
  }
}*/

#create_before_destroy in terraform using depends_on example
/* provider "aws" {
  region = "ap-south-2"
}
resource "aws_instance" "Webserver" {
  ami           = "ami-04e44fc07a0954cc9"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0a1d9f2bed733b4ba"
  tags = {
    Name = "Webserver"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_s3_bucket" "mybucket"{
    bucket = "mybucket-tf-0607"
    depends_on = [aws_instance.Webserver]
} */

# using remote-exec provisioner in terraform

/*provider "aws" {
  region = "ap-south-2"
}
resource "aws_instance" "webserver" {
  ami                    = "ami-04e44fc07a0954cc9"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0a1d9f2bed733b4ba"
  vpc_security_group_ids = ["sg-06bb6e87c7de719a7"]
  key_name               = "myjourney"
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\Mahesh\\Desktop\\Key Pairs\\myjourney.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = ["sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "echo \"<h1>Hello World from Terraform Webserver</h1>\" | sudo tee /var/www/html/index.html"
    ]
  }
  tags = {
    Name = "Webserver"
  }
}
output "instance_id"{
    value = aws_instance.webserver.id
}
output "instance_public_ip"{
    value = aws_instance.webserver.public_ip
}*/

#Example for storing an source of truth file in the local system.

/* provider "aws" {
  region = "ap-south-2"
}

resource "aws_instance" "webserver" {
  instance_type = "t3.micro"
  ami           = "ami-08c198d6392bd152f"
  subnet_id     = "subnet-0a1d9f2bed733b4ba"
  tags = {
    Name = "HydServer"
  }
}
terraform {
  backend "local" {
    path = "C:\\Users\\Mahesh\\Desktop\\MyDevops_Journey\\Terraform-Code\\tflock\\terraform.tfstate"
    
  }
}
output "instance_id" {
  value = aws_instance.webserver.id
} */

# Example for storing the source of truth file in the s3 bucket

provider "aws" {
  region = "ap-south-2"
}

terraform {
  backend "s3" {
    bucket       = "aviz-terraform-statedemo"
    key          = "ec2proj/terraform.tfstate"
    region       = "ap-south-2"
    use_lockfile = true
    
  }
}
resource "aws_instance" "webserver" {
  instance_type          = "t3.micro"
  ami                    = "ami-08c198d6392bd152f"
  subnet_id              = "subnet-0a1d9f2bed733b4ba"
  vpc_security_group_ids = ["sg-06bb6e87c7de719a7"]
  user_data              = file("C:\\Users\\Mahesh\\Desktop\\MyDevops_Journey\\Terraform-Code\\hyduserdata.txt")

}


output "instance_id" {
  value = aws_instance.webserver.id
}
output "instance_public_ip" {
  value = aws_instance.webserver.public_ip

}
