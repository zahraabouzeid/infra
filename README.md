# infra

Shared setup for the services on my server.

## Proxy

`proxy/` runs one Caddy for all services. It owns ports 80 and 443, gets the HTTPS
certificates and forwards each domain to its service on the Docker network `web`:

- The `transit.`, `canteen.`, `ical.`, `webdav.` and `moodle.` subdomains of `MCP_DOMAIN` go to the server of that name.

A service joins the proxy by attaching its container to the external network `web` under the
name the `Caddyfile` uses. To add a service, add a site block to `proxy/Caddyfile` and a
variable for its domain.

## Deploy

Every push to `main` validates the `Caddyfile` and deploys the proxy over SSH into
`DEPLOY_FOLDER/proxy`. The deploy creates the network `web` if it is missing, starts Caddy
and reloads its configuration.

The deploy needs these repository settings:

- Variables: `SSH_TARGET`, `DEPLOY_FOLDER` and `MCP_DOMAIN`.
- Secrets: `SSH_KEY` and `SSH_KNOWN_HOSTS`.

Without `SSH_TARGET` the deploy step is skipped.
