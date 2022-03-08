# terraform-aws-transit-gateway-route-table

[![Terraform](https://github.com/gooygeek/terraform-aws-transit-gateway-route-table/actions/workflows/terraform.yml/badge.svg)]()
[![Release](https://github.com/gooygeek/terraform-aws-transit-gateway-route-table/actions/workflows/release.yml/badge.svg)]()

Deploy a Transit Gateway Route Table, it's associations, propagations, and routes

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_route.route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.tgw_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.tgw_propagation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the TGW Route Table | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | A list of route maps | `list(map(string))` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags of the TGW Route Table | `map(string)` | <pre>{<br>  "test": "tag"<br>}</pre> | no |
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | The Id of the Transit Gateway to attach this route table to | `string` | n/a | yes |
| <a name="input_vpc_attachments"></a> [vpc\_attachments](#input\_vpc\_attachments) | A list of vpc attachment maps (see below for details) | `map(map(string))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tgw_route_table_id"></a> [tgw\_route\_table\_id](#output\_tgw\_route\_table\_id) | TGW Route Table ID |
<!-- END_TF_DOCS -->

## Appendix

### VPC Attachment Map

```hcl
attach_name = {
  attachment_id = "tgw-attach-xxxxxxxxxxxxxxxx"
  associate     = true
  propagate     = true
},
```

| Name          | Description                                                                                         |  Type  | Default | Required |
| ------------- | --------------------------------------------------------------------------------------------------- | :----: | :-----: | :------: |
| attachment_id | ID of the TGW attachment.                                                                           | string |   n/a   |   yes    |
| associate     | Should the attachment be associated with this RT? (Can only asscoiated with a single RT at a time). |  bool  | `false` |    no    |
| propagate     | Should the attachment be propagated to this RT? (Can only propagated to many RTs at once).          |  bool  | `true`  |    no    |

### Route map

```hcl
{
  destination_cidr_block = "0.0.0.0/0"
  attachment_id          = "tgw-attach-xxxxxxxxxxxxxxxx"
  blackhole              = true
},
```

| Name                   | Description                                                                   |  Type  | Default | Required |
| ---------------------- | ----------------------------------------------------------------------------- | :----: | :-----: | :------: |
| destination_cidr_block | CIDR range of the route's destination.                                        | string |   n/a   |   yes    |
| attachment_id          | ID of the TGW attachment to send traffic to for this route.                   | string |   n/a   |   yes    |
| blackhole              | Blackhole this traffic. If set to true, this will override and attachment_id. |  bool  | `false` |    no    |
