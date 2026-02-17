resource "aws_instance" "strapi_instance" {
  ami           = var.ami_id 
  instance_type = var.instance_type
  key_name      = "strapi-key-cicd"

  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.strapi_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              sudo usermod -aG docker $USER
              sudo newgrp docker

              sleep 10

              docker pull amanyadavvv/strapi-docker:latest
              docker run -d -p 1337:1337 --name strapi amanyadavvv/strapi-docker:latest
              EOF


  tags = {
    Name = "Strapi-instance"
  }

}

########################
# Key Pair
########################
