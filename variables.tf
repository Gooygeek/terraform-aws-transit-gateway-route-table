
variable "name" {
  type        = string
  description = "The name of the TGW Route Table"
}

variable "description" {
  type        = string
  description = "A Description of the TGW Route Table"
  default     = ""
}

variable "tgw_id" {
  type        = string
  description = "The Id of the Transit Gateway to attach this route table to"
}

variable "vpc_attachments" {
  type        = map(map(string))
  description = "A list of vpc attachment maps (see below for details)"
  default     = {}
}

variable "routes" {
  type        = list(map(string))
  description = "A list of route maps"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "The tags of the TGW Route Table"
  default     = { test = "tag" }
}