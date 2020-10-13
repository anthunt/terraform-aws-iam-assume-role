data "aws_caller_identity" "current" {}

output "caller_info" {
    value = {
        account_id = data.aws_caller_identity.current.account_id
        arn = data.aws_caller_identity.current.arn
        user_id = data.aws_caller_identity.current.user_id
    }
}

output "assume_role_info" {
    value = {for k, v in aws_iam_role.assume_role : k => {
            id = v.id
            path = v.path
            arn = v.arn
    }}
}