# Lightweight Alpine Linux + Chromium GUI Container

A lightweight Docker container running **Alpine Linux**, **Chromium browser**, and accessible through any web browser via **noVNC** (HTML5 Web GUI) without needing any local VNC or RDP client.

---

## Architecture

- **OS Base**: Alpine Linux (~5MB base)
- **Display Server**: Xvfb (Virtual Framebuffer)
- **Window Manager**: Openbox (ultra-lightweight window manager)
- **Browser**: Chromium (configured with `--no-sandbox` for container safety)
- **VNC Server**: x11vnc
- **Web Gateway**: noVNC + websockify (exposing HTML5 GUI on port `9999`)
- **Process Manager**: Supervisord

---

## Getting Started

### 1. Build and Run with Docker Compose

```bash
docker compose up -d --build
```

### 2. Access the Browser GUI

Open your browser and navigate to:
```
http://localhost:9999
```
or directly:
```
http://localhost:9999/vnc.html
```

Click **Connect** (no password required by default). You will see the Chromium browser running inside the lightweight Alpine desktop.

---

## Quick-Copy Credentials Pad (`notes.html`)

When Chromium starts, it automatically opens two tabs:
1. **Quick-Copy Pad (`file:///root/notes.html`)**: Contains your username, password, phone, referral code, and link with 1-click **Copy** buttons. Clicking "Copy" copies the text directly to your container clipboard so you can switch to the other tab and paste with `Ctrl+V` or Right-Click ➔ Paste.
2. **Target Website**: `https://nexorapaybd.com/register?ref=MB1NHRXN`.

You can edit [notes.html](file:///Users/solaman/bbp/fake-account/notes.html) on your Mac anytime; it is volume-mounted directly into the container.

### Mac Terminal Clipboard Helper (`clip.sh`)
To sync any text or your current Mac clipboard into the container:
```bash
# Sync whatever you just copied on your Mac:
pbpaste | ./clip.sh

# Or send specific text:
./clip.sh "your text here"
```

---

## Managing the Container

* **Stop the container**:
  ```bash
  docker compose down
  ```
* **View logs**:
  ```bash
  docker compose logs -f
  ```
* **Restart the container**:
  ```bash
  docker compose restart
  ```
