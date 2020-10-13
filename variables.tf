variable "aws" {
    type = object({
        region  = string
        profile = string
    })
}

variable "assumeRoles" {
    type = map(object({
        description         = string
        trusted_arns        = list(string)
        attach_policy_arns  = list(string)
        inline_policies     = map(string)
    }))
}