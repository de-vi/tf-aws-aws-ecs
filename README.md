## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_target\_group\_arn | n/a | `any` | n/a | yes |
| container\_definitions | n/a | `any` | n/a | yes |
| container\_name | n/a | `any` | n/a | yes |
| container\_port | n/a | `any` | n/a | yes |
| desired\_task\_count | n/a | `any` | n/a | yes |
| name | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_service\_role\_id | n/a |
