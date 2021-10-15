output "aws_instance_e_ssh" {
  value = [
    # for key, item in aws_instance.web :
    "ec2  ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.web.public_dns} ",
    "ec2  ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.web2.public_dns} "

  ]
}
