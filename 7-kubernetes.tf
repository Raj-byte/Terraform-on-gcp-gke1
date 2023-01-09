resource "google_container_cluster" "primary" {
  name                     = "primary"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.self_link
  subnetwork               = google_compute_subnetwork.private.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  # Optional, if you want multi-zonal cluster
  node_locations = [
    "us-central1-b"
  ]


  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }

    
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "terraform-gcp-on.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28" 
  } 
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "All"
    }
  }
  
  
}

resource "null_resource" "configure_identity" {    
  triggers = {
        id = google_container_cluster.primary.id
    }    
    provisioner "local-exec" {
        command     = <<-EOT
      cd /home/rajkumar/terraform-on-gcp/
      chmod +x istio.sh
      gcloud container clusters get-credentials primary --zone us-central1-a --project terraform-gcp-on  
      ./istio.sh
      kubectl get nodes
    EOT
       }    
    
    depends_on = [google_container_node_pool.general]
}


