# docker-zm-mlapi

A proper and uncomplicated Docker container for https://github.com/ZoneMinder/mlapi

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

**IMPORTANT:** This is a personal project only. PRs are accepted, but this is not supported and "issues" will likely not be fixed or responded to. This is only for people who understand the details of everything invovled.

The docker-compose file and `mlapiconfig.EXAMPLE.ini` should provide a sane configuration for initial testing of the container, e.g.:

1. `docker-compose up` in another shell/terminal/screen
2. Download the [test video](https://www.pexels.com/video/people-walking-by-on-a-sidewalk-854100/) to `testvideo.mp4`
3. 