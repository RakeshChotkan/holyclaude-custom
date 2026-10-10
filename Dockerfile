# HolyClaude + extra tools that must survive image updates.
# The base image already runs as root, so no USER switch is needed.
FROM coderluii/holyclaude:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends subversion less \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --break-system-packages pyte vermin

# CloudCLI kills a terminal (and the claude inside it) 30 minutes after the
# browser disconnects, which also ends Remote Control sessions. Raise it.
# Max ~24 days: setTimeout overflows above 2^31 ms and fires immediately.
# If the build fails here, CloudCLI changed this line: check the new code.
ARG CLOUDCLI_PTY_TIMEOUT_MIN=20160
RUN f=/usr/local/lib/node_modules/@cloudcli-ai/cloudcli/dist-server/server/modules/websocket/services/shell-websocket.service.js \
 && grep -q '^const PTY_SESSION_TIMEOUT = 30 \* 60 \* 1000;' "$f" \
 && sed -i "s/^const PTY_SESSION_TIMEOUT = 30 \* 60 \* 1000;/const PTY_SESSION_TIMEOUT = ${CLOUDCLI_PTY_TIMEOUT_MIN} * 60 * 1000;/" "$f" \
 && grep -q "^const PTY_SESSION_TIMEOUT = ${CLOUDCLI_PTY_TIMEOUT_MIN} \* 60 \* 1000;" "$f"
