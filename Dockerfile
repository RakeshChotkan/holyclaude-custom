# HolyClaude + extra tools that must survive image updates.
# The base image already runs as root, so no USER switch is needed.
FROM coderluii/holyclaude:latest

RUN apt-get update \
 && apt-get install -y --no-install-recommends subversion less \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --break-system-packages pyte vermin
