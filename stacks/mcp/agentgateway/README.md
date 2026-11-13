# agentgateway

Standalone [agentgateway](https://agentgateway.dev/) MCP gateway for the Blaskielab Unraid / Komodo stack.

## Endpoints

- Dashboard: `https://agentgateway.theblaskies.com/ui/` -> Traefik -> container port **4001**, protected by the existing `pocketid-auth@file` ForwardAuth middleware.
- MCP traffic: container port **4000**, **not publicly routed**. Do not add `mcp.theblaskies.com` until you have configured and tested OAuth/JWT validation for Pocket ID tokens.

The dashboard's ForwardAuth session cookie is **not** a substitute for OAuth bearer-token validation on an MCP endpoint. Pocket ID OIDC/JWT integration for MCP clients is a separate configuration task.

## First deployment

Run on Unraid after the repo is available at `/mnt/user/appdata/komodo/repos/Blaskielab`:

```bash
REPO=/mnt/user/appdata/komodo/repos/Blaskielab
DATA=/mnt/user/appdata/agentgateway

mkdir -p "$DATA"
if [ ! -f "$DATA/config.yaml" ]; then
  cp "$REPO/stacks/mcp/agentgateway/config.yaml" "$DATA/config.yaml"
fi
chown -R 1002:281 "$DATA"
```

This one-time copy is intentional: the Git file is a seed; the writable copy under appdata persists UI changes and SQLite data. Do not overwrite an existing appdata config when redeploying.

If you use the Compose CLI, also run:

```bash
cd /mnt/user/appdata/komodo/repos/Blaskielab/stacks/mcp/agentgateway
cp example.env .env
docker compose config
docker compose up -d
```

For **Komodo**, select this directory as the stack's working directory and `docker-compose.yaml` as the Compose file. Its variables have defaults, or you can set them in Komodo without committing an actual `.env` file. Ensure the external Docker network `proxy_net` exists.

## Security and configuration

- Use the existing Pocket ID ForwardAuth middleware defined in `stacks/infra/traefik/dynamic/middlewares-auth.yml`. Do not define a second ForwardAuth service.
- Only the dashboard is routed publicly. No `ports:` are published on the Unraid host.
- The `mcp-gateway` listener exists on the Docker network but has no MCP upstream configured initially.
- Before exposing MCP to remote clients, configure protected-resource metadata, authorization-server discovery, Pocket ID JWT validation (signature, issuer, audience, expiry, and scopes), and the actual upstream MCP servers.
- The UI changes are persisted in `/mnt/user/appdata/agentgateway/config.yaml`, not automatically committed to Git. Back up the appdata directory.
- The image is version-pinned. Renovate may propose a digest pin or subsequent updates.

Reference: [official Docker installation](https://agentgateway.dev/docs/standalone/latest/documentation/setup/install/docker/) and [separate UI gateway](https://agentgateway.dev/docs/standalone/latest/documentation/setup/ui/gateway-ui/).
