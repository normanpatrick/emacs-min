FROM alpine:latest

# Install Emacs (no X11), plus basic dependencies
RUN apk add --no-cache emacs-nox
