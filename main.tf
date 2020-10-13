locals {
    policy_arns = flatten([
        for role_name, role in var.assumeRoles: [
            for policy_key, policy_arns in role.attach_policy_arns: {
                role_name = role_name
                policy_key = policy_key
                policy_arns = policy_arns
            }
        ]
    ])

    inline_policies = flatten([
        for role_name, role in var.assumeRoles: [
            for policy_key, inline_policy in role.inline_policies: {
                role_name = role_name
                policy_key = policy_key
                inline_policy = inline_policy
            }
        ]
    ])
}

data "aws_iam_policy_document" "role-document" {    
    for_each = var.assumeRoles
    policy_id = each.key
    statement {
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        principals {
            type = "AWS"
            identifiers = each.value.trusted_arns
        }
    }
}

resource aws_iam_role assume_role {
    for_each = var.assumeRoles
    name = each.key
    description = each.value.description
    assume_role_policy = data.aws_iam_policy_document.role-document[each.key].json
}

resource aws_iam_role_policy_attachment "administrator-full-access" {
    for_each = {
        for policy in local.policy_arns : "${policy.role_name}.${policy.policy_key}" => policy
    }
    role = aws_iam_role.assume_role[each.value.role_name].name
    policy_arn = each.value.policy_arns
}

resource "aws_iam_role_policy" "inline_policy" {
    for_each = {
          for policy in local.inline_policies : "${policy.role_name}.${policy.policy_key}" => policy
    }
    name = each.value.policy_key
    role = aws_iam_role.assume_role[each.value.role_name].name
    policy = each.value.inline_policy
}