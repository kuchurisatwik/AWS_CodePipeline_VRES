resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: In production, restrict to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "backend_server" {
  ami           = "ami-04b4f1a9cf54c11d0" # Ubuntu 24.04 LTS (us-east-1). Update if needed.
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups      = [aws_security_group.web_sg.name]

  tags = {
    Name = "tf-ec2-instance" # MATCHES CodeDeploy Filter
    Project = var.project_name
  }

  # User data to install CodeDeploy Agent (REQUIRED)
  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y ruby wget
    cd /home/ubuntu
    wget https://aws-codedeploy-${var.aws_region}.s3.amazonaws.com/latest/install
    chmod +x ./install
    ./install auto
    service codedeploy-agent start
  EOF
}