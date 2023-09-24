resource "aws_vpc" "vpc-terraform" {
  cidr_block = var.vpc-terraform-cidr_block
  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_internet_gateway" "gw-terraform" {
  vpc_id = aws_vpc.vpc-terraform.id

  tags = {
    Name = "gw-terraform"
  }
}

resource "aws_route_table" "route-terraform" {
  vpc_id = aws_vpc.vpc-terraform.id

  route {
    cidr_block = var.anyOne-cidr
    gateway_id = aws_internet_gateway.gw-terraform.id
  }

  tags = {
    Name = "route-terraform"
  }
}

resource "aws_security_group" "terraform-securityG" {
  name_prefix = "terraform-securityG"
  vpc_id     = aws_vpc.vpc-terraform.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.anyOne-cidr]
  }
  
  ingress {
    description = "Http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.anyOne-cidr]
  }
  ingress {
    description = "Jenkins from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.anyOne-cidr]
  }
  ingress {
    description = "Flask_app from VPC"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = [var.anyOne-cidr]
  }
  ingress {
    description = "Flask_app from VPC"
    from_port   = 32000
    to_port     = 32700
    protocol    = "tcp"
    cidr_blocks = [var.anyOne-cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.anyOne-cidr]
    # ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = "terraform-securityG"
  }
}

resource "aws_subnet" "subnet-terraform" {
  for_each = var.subnet-terraform
  vpc_id     = aws_vpc.vpc-terraform.id
  cidr_block = each.value[0]
  availability_zone = each.value[1]
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

# subnet-terraform["public-subnet-terraform"]
# subnet-terraform["private-subnet-terraform"]

# Add here NAT gateway attached to public vpc subnet

# resource "aws_nat_gateway" "gw-NAT-Terraform" {
#   subnet_id = aws_subnet.subnet-terraform["public-subnet-terraform"].id
#   allocation_id = aws_eip.eip.id
#   tags = {
#     Name = "gw-NAT-Terraform"
#   }

#   depends_on = [aws_internet_gateway.gw-terraform]
# }

# resource "aws_eip" "eip" {}

# ----------------------------

resource "aws_route_table" "route-terraform-private" {
  vpc_id = aws_vpc.vpc-terraform.id

  # route {
  #   cidr_block     = var.anyOne-cidr
  #   gateway_id     = "local"
  # }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_security_group" "terraform-securityG-privateInstance" {
  name_prefix = "terraform-securityG-privateInstance"
  vpc_id     = aws_vpc.vpc-terraform.id

  # For a private instance, you might want to allow incoming traffic only from the public subnet.

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc-terraform-cidr_block]
  }

  # Allow outgoing traffic to the internet through the NAT Gateway.

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.anyOne-cidr]
  }

  tags = {
    Name = "terraform-securityG-privateInstance"
  }
}

# --------------------

resource "aws_route_table_association" "sub-ass-terraform" {
  subnet_id      = aws_subnet.subnet-terraform["public-subnet-terraform"].id
  route_table_id = aws_route_table.route-terraform.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.subnet-terraform["private-subnet-terraform"].id
  route_table_id = aws_route_table.route-terraform-private.id
}
resource "aws_route_table_association" "sub-ass-terraform-2" {
  subnet_id      = aws_subnet.subnet-terraform["public-2-subnet-terraform"].id
  route_table_id = aws_route_table.route-terraform.id
}

resource "aws_route_table_association" "private_subnet_association-2" {
  subnet_id      = aws_subnet.subnet-terraform["private-2-subnet-terraform"].id
  route_table_id = aws_route_table.route-terraform-private.id
}
