
output "tgw_route_table_id" {
  description = "TGW Route Table ID"
  value = aws_ec2_transit_gateway_route_table.this.id
}
