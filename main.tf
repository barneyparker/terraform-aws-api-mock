module "mock_integration" {
  source = "github.com/barneyparker/terraform-aws-api-generic"

  api_id   = var.api_id
  resource_id   = var.resource_id
  http_method   = var.http_method
  authorization = var.authorization

  method_request_parameters   = var.method_request_parameters
  integration_request_parameters   = var.integration_request_parameters

  type              = "MOCK"
  request_templates = var.request_templates
  responses = var.responses
}