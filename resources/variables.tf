variable "instance_type" {
    description = "Instance type for backend app"
    default = "t4g.nano"
}

variable "tags" {
    description = "Tags for backend app"
    type = map(string)
    default = {
        Name = "tf-web-arm"
        Environment = "dev"
    }
}