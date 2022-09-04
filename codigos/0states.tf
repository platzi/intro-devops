terraform{
    backend "s3" {
        bucket = "platzi-mi-repo-para-terraform"
        encrypt = true
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}

provider "aws" {
    region = "us-east-1"
    #access_key = "AKIAYFQTFKR6I4IUOGSY"
    #secret_key = "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"
}
#export AWS_ACCESS_KEY_ID=AKIAYFQTFKR6I4IUOGSY ; 
#export AWS_SECRET_ACCESS_KEY=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