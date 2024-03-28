resource "aiven_dragonfly" "example_dragonfly" {
    project      = "example-project"
    plan         = "startup-4"
    cloud_name   = "google-europe-west1"
    service_name = "example-dragonfly-service" 

    dragonfly_user_config {
        cache_mode = true
    }
}