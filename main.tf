resource "helm_release" "firefly-db" {
  name = "firefly-db"

  repository       = "https://firefly-iii.github.io/kubernetes"
  chart            = "firefly-db"
  create_namespace = true
  namespace        = "firefly"

  values = [
    templatefile("${path.module}/helm-values/firefly-db.yaml", {
    })
  ]
}

resource "helm_release" "firefly" {
  name = "firefly"

  repository       = "https://firefly-iii.github.io/kubernetes"
  chart            = "firefly-iii"
  create_namespace = true
  namespace        = "firefly"

  values = [
    templatefile("${path.module}/helm-values/firefly.yaml", {
      domain : var.domain,
      cpu_request : var.cpu_request,
      memory_request : var.memory_request,
      memory_limit : var.memory_limit
    })
  ]
  set_sensitive {
    name  = "secrets.env.APP_KEY"
    value = var.firefly_app_key
  }
  set_sensitive {
    name  = "cronjob.auth.token"
    value = random_password.token.result
  }

  depends_on = [helm_release.firefly-db]
}

resource "random_password" "token" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+{}<>:?"
}