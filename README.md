# Joomla Drone System Tests Clone

[Joomla system tests](https://github.com/joomla/joomla-cms/tree/4.4-dev/tests/System) uses [Drone](https://www.drone.io/) for Continuous Integration (CI). These three [Docker](https://www.docker.com/) containers gives the possibility to run the Joomla system tests local, from local Joomla source code folder and as far as possible as with Drone.

Simple dirty use of all what was found in [.drone.yml](https://github.com/joomla/joomla-cms/blob/4.4-dev/.drone.yml) and [joomla-projects/docker-images](https://github.com/joomla-projects/docker-images).

## Installation

[Git](https://git-scm.com/), [Docker](https://www.docker.com/) and a bash scripting environment are required and must be installed.

```
git clone https://github.com/muhme/joomla-drone-system-tests
cd joomla-drone-system-tests
# put your Joomla source code in folder www, e.g.
git clone --depth 1 https://github.com/joomla/joomla-cms www
scripts/create.sh
```

## Containers

|Name               |Port                                 |Comment                                    |
|-------------------|-------------------------------------|-------------------------------------------|
|mysql              |                                     |                                           |
|phpmin-system-mysql|[1080](http://localhost:1080/cmysql/)        | user ci-admin / password: joomla-17082005<br />(see www/cypress.config.js) |
|mysqladmin         |[1081](http://localhost:1081/)| user joomla_ut / password joomla_ut       |

## Tests

Running the complete system test suite:
```
scripts/tests.sh
```

Running one system test specification by example:
```
scripts/test.sh tests/System/integration/site/components/com_contact/Categories.cy.js
```

## Scripts

The bash scripts are for macOS, Linux or Windows WSL 2:

| Script | Description | Additional Info |
| --- | --- | --- |
| [scripts/create.sh](scripts/create.sh) | Create the three Docker containers | and running `composer update` and `npm ci` |
| [scripts/test.sh](scripts/test.sh) | Running system test | without argument all system tests or give one test specification as argument |
| [scripts/clean.sh](scripts/clean.sh) | Removes docker compose containers | with argument `all` also folders `cypress-cache` and `www` and also docker compose volumes, images and networks |

## License

MIT License, Copyright (c) 2024 Heiko Lübbe, see [LICENSE](LICENSE)

## Contact

Don't hesitate to ask if you have any questions or comments. If you encounter any problems or have suggestions for enhancements, please feel free to [open an issue](../../issues).
