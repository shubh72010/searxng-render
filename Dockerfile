# syntax=docker/dockerfile:1
#
# Official SearXNG image, pinned to an immutable version+commit tag.
# Update policy: bump this tag deliberately (see README "Updating").
FROM ghcr.io/searxng/searxng:2026.11.9-57ff753ad

# Render routes traffic to $PORT on 0.0.0.0; the image defaults to [::]:8080.
ENV GRANIAN_HOST=0.0.0.0

COPY --chown=searxng:searxng searxng/settings.yml /etc/searxng/settings.yml
COPY --chown=searxng:searxng scripts/entrypoint.sh /usr/local/bin/render-entrypoint.sh

# The image ships these paths owned by searxng; re-assert it so the container
# can run fully unprivileged (no chown at runtime, no root).
RUN chmod 0555 /usr/local/bin/render-entrypoint.sh \
 && mkdir -p /var/cache/searxng \
 && chown -R searxng:searxng /etc/searxng /var/cache/searxng

USER searxng

# The server listens on $PORT (injected by Render), 8080 when unset.
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/render-entrypoint.sh"]
