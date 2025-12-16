resource "aws_iam_role" "ec2_codedeploy_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# 1. Allow EC2 to work with CodeDeploy
resource "aws_iam_role_policy_attachment" "ec2_codedeploy_policy" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

# 2. Allow EC2 to download artifacts from S3 (The "GetBucket" permission)
resource "aws_iam_role_policy" "s3_access_policy" {
  name = "${var.project_name}-ec2-s3-policy"
  role = aws_iam_role.ec2_codedeploy_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:Get*",
          "s3:List*"
        ]
        Resource = "*" # In production, restrict this to your specific artifact bucket
      }
    ]
  })
}

# 3. Create the Instance Profile (This attaches the role to the server)
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_codedeploy_role.name
}