data "aws_region" "region_1" {
  provider = aws.region_1
}

data "aws_region" "region_2" {
  provider = aws.region_2
}

output "region_1" {
  value = data.aws_region.region_1.name
}

output "region_2" {
  value = data.aws_region.region_2.name
}
