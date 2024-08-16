# Traefik

Installs and configures Traefik container + Lets Encrypt certificates.

Traefik reverse proxy configuration is done via templating the file locally on the control server, then sftp copying the file to the host.

## Service Mapping

Service mappings need to be passed in the following format as part of the parameter `router_service_mapping`:

```yaml
router_service_mapping:
  service1:
    port: 1234
  service2:
    port: 1235
  service3:
    port: 1236
```