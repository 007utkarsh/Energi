# Define the IAM role
resource "aws_iam_role" "prod-ci-role" {
  name               = "prod-ci-role"
  prod-ci-policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Define the IAM policy
resource "aws_iam_policy" "prod-ci-policy" {
  name        = "prod-ci-policy"
  description = "Policy allowing users/entities to assume the prod-ci-role"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole",
        "Resource" : aws_iam_role.prod-ci-role.arn
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.prod-ci-role.name
  policy_arn = aws_iam_policy.prod-ci-policy.arn
}

# Define the IAM group
resource "aws_iam_group" "my_group" {
  name = "my-group"
}

# Attach the policy to the group
resource "aws_iam_group_policy_attachment" "attach_group_policy" {
  group      = aws_iam_group.my_group.name
  policy_arn = aws_iam_policy.prod-ci-policy.arn
}

# Define the IAM user
resource "aws_iam_user" "my_user" {
  name = "my-user"
}

# Add the user to the group
resource "aws_iam_group_membership" "add_user_to_group" {
  name  = aws_iam_group.my_group.name
  users = [aws_iam_user.my_user.name]
}
