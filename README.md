# mlh-aws-portfolio

## Testing nginx on localhost

- set `USE_LOCAL_CA=1` in `nginx.env`

In `docker-compose.yaml`:

- set `nginx:image: jonasal/nginx-certbot:dev`
- set `nginx:volumes: ./nginx-dev/user_conf.d:/etc/nginx/user_conf.d` (leave `nginx-secrets:` as is)
