resource "azurerm_policy_definition" "tag_policy" {
  display_name = "require-tags-policy"
  name         = "require-tags-policy"
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Ensure all required tags are present"
  policy_rule  = file("${path.module}/templates/tag_policy_rule.json")
  parameters   = file("${path.module}/templates/policy_parameters.json")
}

resource "azurerm_policy_assignment" "tag_policy_assignment" {
  name                 = "require-tags-assignment"
  scope                = ""
  policy_definition_id = azurerm_policy_definition.tag_policy.id
  description          = "Policy Assignment for requiring specific tags"
  display_name         = "Require Specific Tags Assignment"
  parameters = {
    tag_env         = "env"
    tag_demo        = "demo"
    tag_tempo       = "tempo"
  }
}