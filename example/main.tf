resource "aws_api_gateway_rest_api" "api" {
  name = "api_mock"
}

module "api-mock" {
  source  = "barneyparker/api-mock/aws"

  api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_rest_api.api.root_resource_id

  http_method = "GET"

  method_request_parameters   = {
    "method.request.querystring.myParam" = false
  }

  request_templates = {
    "application/json" = <<-EOT
      {
        #if( $input.params('myParam') == "terraform" )
          "statusCode": 200
        #else
          "statusCode": 400
        #end
      }
    EOT
  }

  responses = [
    {
      status_code = "200"
      selection_pattern = "200"
      templates = {
        "application/json" = jsonencode({
          statusCode = 200
          message    = "OK"
        })
      }
    },
    {
      status_code = "400"
      selection_pattern = "4\\d{2}"
      templates = {
        "application/json" = jsonencode({
          statusCode = 400
          message    = "Error"
        })
      }
    }
  ]
}