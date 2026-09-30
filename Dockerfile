FROM alpine:latest

# Install X11, Openbox, Chromium, fonts, websockify, noVNC, and supervisor
RUN apk update && apk add --no-cache \
    chromium \
    font-noto \
    font-noto-cjk \
    font-noto-emoji \
    x11vnc \
    xvfb \
    openbox \
    novnc \
    websockify \
    supervisor \
    autocutsel \
    xclip \
    bash

# Symlink vnc.html to index.html so root path loads directly
RUN ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Supervisord configuration
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY notes.html /root/notes.html

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
