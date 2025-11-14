# Minimal object-style input replacing individual vars.
# Adjust attribute names to exactly match the two variables used in main.tf.

variable "config" {
  type = object({
    subnet_id      = string
    nat_gateway_id = string
  })
  description = "Configuration for subnet public IP association (only the two vars currently used in main.tf)."
}
