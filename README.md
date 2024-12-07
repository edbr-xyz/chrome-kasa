:accordion: Silly little script that turns on a TP-Link smart plug when you connect to a Chromecast Audio. :accordion:

Turn an amplifier on and off automatically! (or set mood lighting?)

Uses [python-kasa](https://github.com/python-kasa/python-kasa) and [go-chromecast](https://github.com/vishen/go-chromecast).

I should make it use [pychromecast](https://github.com/home-assistant-libs/pychromecast), but I haven't yet.

## Requirements:

### Hardware:

 - :sound:  Chromecast Audio
 - :electric_plug:  TP-Link Kasa or Tapo Smart Plug from [this list](https://github.com/python-kasa/python-kasa?tab=readme-ov-file#supported-kasa-devices), configured with a static IP address.

### Software:

- [Docker](https://docs.docker.com/engine/install/) and the [Docker Compose plugin](https://docs.docker.com/compose/install/linux/#install-using-the-repository). :exclamation: **Image currently only built for ARM64.**

*OR*

- [python-kasa](https://github.com/python-kasa/python-kasa) and [go-chromecast](https://github.com/vishen/go-chromecast), with their requirements.

## Usage:

### With Docker (Recommended):

1. Copy the contents of the [example docker-compose.yml file](example-docker-compose.yml) into a folder of your choosing.
2. Customise the environment, putting in the name of your Chromecast Audio and the IP of your smart plug.
3. Duplicate the service for as many plugs you need to control. (Optional)
4. Run `docker compose up` and test it out.
5. Run in the background with `docker compose up -d`.

### Without Docker

1. Install [python-kasa](https://github.com/python-kasa/python-kasa) and [go-chromecast](https://github.com/vishen/go-chromecast).

2. Run the [python script](src/chrome-kasa.py) with the command: `python3 chrome-kasa.py 'chromecast-friendly-name' xxx.xxx.xxx.xxx`, replacing 'chromecast-friendly-name' with your Chromecast Audio's friendly name, and xxx.xxx.xxx.xxx with the IP of your smart plug.
