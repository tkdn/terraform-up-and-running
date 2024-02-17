variable "hero_thousand_faces" {
  type = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}

variable "names" {
  type    = list(string)
  default = ["neo", "trinity", "mopheus"]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "uppper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}

output "for_directive" {
  value = "%{for i, name in var.names}(${i})-${name}, %{endfor}"
}
