variable "codestar_connector_credentials"{
    type = string
    default = null
}
variable "codebuild_role"{
    type = string
    default = null
}
variable "codepipeline_role"{
    type = string
        default = null
}
variable "s3_terraform_pipeline"{
    type = string
        default = null
}

////////front
variable "S3FrontEnd"{
    type = string
        default = null
}
variable "name_frontend"{
    type = string
        default = null
}
//// serverless
variable "name_serverless_node"{
    type = string
    default = null
}
variable "name_serverless_python"{
    type = string
    default = null
}
variable "dockerhub_credentials"{
    type = string
    default = null
}
variable "name_flyaway"{
    type = string
    default = null
}
variable "name_micro"{
    type = string
    default = null
}
