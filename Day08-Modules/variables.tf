variable "ami_id" {
    description = "write ami id here"
    type = string
    default = ""
}

variable "type" {
    description = "give the instance type"
    type = string
    default = ""
}

variable "subnet_id" {
    description = "give subnet id here"
    type = string
    default = "subnet-097b15f1752cc402d"
}