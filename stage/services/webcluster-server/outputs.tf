output "alb_dns_name" {
	value		= "module.webserver_cluster.alb.dns_name"
	description	= "Domain name of the load balancer"
}
