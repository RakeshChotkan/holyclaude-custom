# holyclaude-custom

`coderluii/holyclaude:latest` plus subversion, less, pyte and vermin.
Built by GitHub Actions on every push and every Monday, published to
`ghcr.io/rakeshchotkan/holyclaude-custom:latest`.

CloudCLI patch: a terminal stays alive for 14 days after the browser
disconnects instead of 30 minutes (`CLOUDCLI_PTY_TIMEOUT_MIN`, max ~24 days),
so Claude Code sessions and their Remote Control connection stay open.
The build fails if CloudCLI changes that line.

Portainer stack: set `image: ghcr.io/rakeshchotkan/holyclaude-custom:latest`,
then update the stack with "Re-pull image" enabled.
