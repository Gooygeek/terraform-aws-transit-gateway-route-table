locals {
  attachments_with_association = {
    for k, v in var.vpc_attachments : k => v if tobool(lookup(v, "associate", false)) == true
  }
  attachments_with_propagation = {
    for k, v in var.vpc_attachments : k => v if tobool(lookup(v, "propagate", true)) == true
  }
}

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = var.tgw_id
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags
  )
}
//comment
resource "aws_ec2_transit_gateway_route_table_association" "tgw_assoc" {
  for_each = local.attachments_with_association

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
  transit_gateway_attachment_id  = each.value.attachment_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_propagation" {
  for_each = local.attachments_with_propagation

  transit_gateway_route_table_id    = aws_ec2_transit_gateway_route_table.this.id
  transit_gateway_attachment_id  = each.value.attachment_id
}

resource "aws_ec2_transit_gateway_route" "route" {
  count = length(var.routes)

  destination_cidr_block = var.routes[count.index].destination_cidr_block
  blackhole              = lookup(var.routes[count.index], "blackhole", null)

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
  transit_gateway_attachment_id  = tobool(lookup(var.routes[count.index], "blackhole", false)) == false ? var.routes[count.index].attachment_id : null
}
