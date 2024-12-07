:whale: [`edbrxyz/chrome-kasa`](https://hub.docker.com/r/edbrxyz/chrome-kasa)

**Silly little script that turns on a TP-Link smart plug when you are connected to a Chromecast Audio.**

Turn an amplifier on and off automatically! (or set mood lighting?)

Uses [python-kasa](https://github.com/python-kasa/python-kasa) and [go-chromecast](https://github.com/vishen/go-chromecast). I should make it use [pychromecast](https://github.com/home-assistant-libs/pychromecast), but I haven't yet.

## Requirements:

### Hardware:

 - :sound:  Chromecast Audio
 - :electric_plug:  TP-Link Kasa or Tapo smart plug from [this list](https://github.com/python-kasa/python-kasa?tab=readme-ov-file#supported-kasa-devices), configured with a static IP address.

### Software:

- [Docker](https://docs.docker.com/engine/install/) and the [Docker Compose plugin](https://docs.docker.com/compose/install/linux/#install-using-the-repository). :exclamation: **Image currently built for ARM64 only.**

*OR*

- [python-kasa](https://github.com/python-kasa/python-kasa) and [go-chromecast](https://github.com/vishen/go-chromecast), with their requirements.

## Usage:

### With Docker (Recommended):

1. Make a docker-compose.yml in a folder of your choosing, and paste in:

```yaml
services:
  # Duplicate for as many smart plug + Chromecast Audios as you have
  example:
    image: edbrxyz/chrome-kasa
    network_mode: 'host'
    environment:
      chromecast: '<Chromecast Friendly Name>' #replace with the friendly name of your Chromecast Audio
      plug: <smart.plug.ip> #replace with the IP of your smart plug
      idle: <timeout in seconds> #set how long the smart plug should stay on for, or remove line for default 60
```

2. Customise the environment as described in the comments.
3. Run `docker compose up` and test it out.
4. Run in the background with `docker compose up -d`.

### Without Docker:

1. Install [python-kasa](https://github.com/python-kasa/python-kasa) and [go-chromecast](https://github.com/vishen/go-chromecast).

2. Run the [python script](src/chrome-kasa.py) with the command:
```bash
python3 chrome-kasa.py '<Chromecast Friendly Name>' '<smart.plug.ip>' '<timeout in seconds>'
```

## Running on non-ARM64 systems:

1. Download the [Dockerfile](Dockerfile) and edit the install for [go-chromecast](https://github.com/vishen/go-chromecast) to use your [architecture's relevant release](https://github.com/vishen/go-chromecast/releases).
2. Replace `image: edbrxyz/chrome-kasa` with `build: .` in your docker-compose.yml
