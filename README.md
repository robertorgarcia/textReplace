# textReplace

## Solution
What follows is a detailed description of the components of the solution and how they work together.

The repository contains Terraform code, an Infrastructure as Code (IaC) tool which can be used to define the instances and configurations of cloud components. It takes a modular structure (which is defined below in _File Structure_) to define AWS components and their configurations. As it's an IaC deployment, the lifecycle of the entire solution is controlled through code, its' deployment, updates and destruction is controlled through Terraform. When deployed, these components expose a REST API, which can then be used to perform the text replacement.

The API exposes a single resource as POST /synctransform, which takes a json message with the string to be processed (the structure of the message can be seen below), and a synchronous response will include the text with the replacements performed.
The replacements performed are: 'Oracle' to 'Oracle©', 'Google' to 'Google©', 'Microsoft' to 'Microsoft©', 'Amazon' to 'Amazon©', 'Deloitte' to 'Deloitte©'

### File Structure
```
├── apiGateway                             -> API gateway module definition
│   ├── spec.yml                           -> Contains the OpenAPI specification for the API gateway
│   ├── main.tf                            -> Terraform file containing resource definitions for the gateway
│   ├── variables.tf                       -> variables file to integrate with lambda function
├── backend                                -> Lambda function module definition
│   ├── main.tf                            -> Terraform file containing resource definitions for the function
│   ├── outputs.tf                         -> Output file for integration with gateway
├── backendCodeBase                        -> Codebase folder
│   ├── main.py                            -> Main python codefile for text replacement logic
├── postmanTesting                         -> Codebase folder
│   ├── textReplaceAPI-postman.yaml        -> Main python codefile for text replacement logic
├── main.tf                                -> Main terraform file
└── .gitignore
```
The solution is divided in modules, one for the Gateway definition and deployment, a second for the Lambda function which will perform the replacement. A third folder will host the code for the lambda component.
These are all tied together and deployed through the main.tf file.
### Architecture
![Untitled Diagram (1)](https://user-images.githubusercontent.com/16083769/155941353-95b52c25-aa47-40b3-8f45-f0519b92d11c.jpg)

### API Info
the API has been pre-deployed to: https://3p6i38iye6.execute-api.eu-central-1.amazonaws.com/prod/synctransform
When testing please remember to [Sign the request](https://docs.aws.amazon.com/apigateway/api-reference/signing-requests/). For testing purposes you may also find a Postman project file [here](postmanTesting\textReplaceAPI-prod-swagger-postman.yaml)

The request's body must follow the defined schema:
```
{
  "textbody": "string"
}
```
While the response body will follow:
```
{
  "message": "string"
}
```
If, for example, the request body does not follow the provided schema the response will be:
```
{
  "message": "Internal server error"
}
```
