terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.25.0"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
}

resource "aws_apprunner_service" "example" {
  service_name = "example"

  source_configuration {
    authentication_configuration {

      connection_arn = aws_apprunner_connection.example.arn
      
    }
    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "pip install -r requirements.txt"
          port          = "8000"
          runtime       = "PYTHON_3"
          start_command = "python server.py"
        }
        configuration_source = "API"
      }
      repository_url = "https://github.com/cskalyan/python-hello"
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }
    }
  }

#   network_configuration {
#     egress_configuration {
#       egress_type       = "VPC"
#       vpc_connector_arn = aws_apprunner_vpc_connector.connector.arn
#     }
#   }

tags = {
    Name = "example-apprunner-service"
  }
}
