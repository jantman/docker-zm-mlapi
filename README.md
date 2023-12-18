# docker-zm-mlapi

A proper and uncomplicated Docker container for https://github.com/ZoneMinder/mlapi

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

**IMPORTANT:** This is a personal project only. PRs are accepted, but this is not supported and "issues" will likely not be fixed or responded to. This is only for people who understand the details of everything invovled.

## Prerequisites

You must mount a data path in to the container at `/var/lib/zmeventnotification` and that path **must** already have a writable `images` directory in it.

## Testing

The docker-compose file and `mlapiconfig.EXAMPLE.ini` should provide a sane configuration for initial testing of the container, e.g.:

1. Set up an API username and password; you can either create the `data/db` directory and copy `db.EXAMPLE.json` to it for a single API user `zmuser` with password `zmpass`, or create your own user with something like:  `docker run -it --rm -v ./data:/var/lib/zmeventnotification --entrypoint /bin/bash jantman/docker-zm-mlapi:<TAG>` and then (assuming a username of `zmuser` and password of `zmpass`): `mkdir /var/lib/zmeventnotification/db && python3 /mlapi/mlapi_dbuser.py -u zmuser -p zmpass -d /var/lib/zmeventnotification/db && exit`
2. `docker-compose up` in another shell/terminal/screen
3. Download the [test video](https://www.pexels.com/video/people-walking-by-on-a-sidewalk-854100/) to `testvideo.mp4`
4. `python3 -mvenv venv && source venv/bin/activate && pip install opencv-python requests imutils`
5. `python3 stream.py testvideo.mp4` - this should display the test video with objects identified
