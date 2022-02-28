# textReplace
## Introduction

## Solution
What follows is a detailed description of the components of the solution and how they work together.
The files, when deployed with Terraform, will generate an architecture as seen in the diagram. These components expose a REST API, which can then be used to perform the text replacement.
The API exposes a single resource as POST /synctransform, which takes a json message with the string to be processed (the structure of the message can be seen below), and a synchronous response will include the text with the replacements performed.

### File Structure
```
├── apiGateway        -> API gateway module definition
│   ├── spec.yml      -> Contains the OpenAPI specification for the API gateway
│   ├── main.tf       -> Terraform file containing resource definitions for the gateway
│   ├── variables.tf  -> variables file to integrate with lambda function
├── backend           -> Lambda function module definition
│   ├── main.tf       -> Terraform file containing resource definitions for the function
│   ├── outputs.tf    -> Output file for integration with gateway
├── backendCodeBase   -> Codebase folder
│   ├── main.py       -> Main python codefile for text replacement logic
├── main.tf           -> Main terraform file
└── .gitignore
```
The solution is divided in modules, one for the Gateway definition and deployment, a second for the Lambda function which will perform the replacement. A third folder will host the code for the lambda component.
These are all tied together and deployed through the main.tf file.
### Architecture
![Untitled Diagram (1)](https://user-images.githubusercontent.com/16083769/155941353-95b52c25-aa47-40b3-8f45-f0519b92d11c.jpg)

### API Info
the API has been pre-deployed to: https://3p6i38iye6.execute-api.eu-central-1.amazonaws.com/prod/synctransform
The request must follow the defined schema:
```
{
  "textbody": "string"
}
```
While the response will come as:
```
{
  "message": "string"
}
```
