# terraform-aws-transit-gateway-route-table

[![Terraform](https://github.com/gooygeek/terraform-aws-transit-gateway-route-table/actions/workflows/terraform.yml/badge.svg)]()
[![Release](https://github.com/gooygeek/terraform-aws-transit-gateway-route-table/actions/workflows/release.yml/badge.svg)]()

Deploy a Transit Gateway Route Table, it's associations, propagations, and routes

<!-- BEGIN_TF_DOCS -->
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
