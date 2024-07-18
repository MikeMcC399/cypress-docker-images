# cypress/included

[![Docker Pulls](https://img.shields.io/docker/pulls/cypress/included.svg?maxAge=604800)](https://hub.docker.com/r/cypress/included/)

> Docker images with all operating system dependencies, Cypress, and some pre-installed browsers.

## Platforms

`cypress/included` images are available for `Linux/amd64` and `Linux/arm64` platforms.
`Linux/arm64` images do **not** currently contain additional browsers.

## Tags

[cypress/included](https://hub.docker.com/r/cypress/included/tags) images on [Cypress on Docker Hub](https://hub.docker.com/u/cypress) use image tags in the form:

- `<cypress version>`-node-`<node version>`-chrome-`<chrome version>`-ff-`<firefox version>`-edge-`<edge version>`-
- `<cypress version>`<br>This is a short-form convenience tag,  equivalent to the above full tag.
- `latest`

for example:

- `cypress/included:cypress-13.11.0-node-20.14.0-chrome-125.0.6422.141-1-ff-126.0.1-edge-125.0.2535.85-1`
- `cypress/included:13.11.0`
- `cypress/included:latest`

 To avoid unplanned breaking changes, specify a fixed `<cypress version>`, `<node version>` & `<browser version>` combination tag or use the short-form `<cypress version>` tag, not the `latest` tag.  The `latest` tag is linked to the latest released `cypress/included` image and is updated without notice.

## ENTRYPOINT

When running a container from a `cypress/included` image, `cypress run` is executed, as defined by the [ENTRYPOINT](https://docs.docker.com/reference/dockerfile/#entrypoint) parameter of the image.

## Examples

Clone this repository and change your working directory to the provided example Cypress project [examples/basic-mini](../examples/basic-mini/). The example project includes Cypress test specs and is configured without a specific Cypress version. We will use the Cypress version installed in the `cypress/included` Docker image instead. Cypress tests are run using the default Electron browser bundled with Cypress.

```shell
git clone https://github.com/cypress-io/cypress-docker-images
cd cypress-docker-images/examples/basic-mini
docker run -it --rm -v .:/e2e -w /e2e cypress/included
```

To run any other Cypress command, except `cypress run` with no options, you need to specify the Docker command line option `--entrypoint cypress` and add any additional Cypress command line options to the end of the line.

The examples below assume that your working directory is set to `cypress-docker-images/examples/basic-mini`.

### `cypress run` command options

If you want to add Cypress CLI [run options](https://docs.cypress.io/guides/guides/command-line#Options) then use `--entrypoint cypress` in the Docker command and append `run` to the end of the command line. For example, to run tests using the Chrome browser:

```shell
docker run -it --rm -v .:/e2e -w /e2e --entrypoint cypress cypress/included run --browser chrome
```

### Cypress CLI commands

You can use [Cypress CLI info commands](https://on.cypress.io/guides/guides/command-line) to display what is installed in the `cypress/included` image without mounting a volume (`-v`) or setting a working directory (`-w`).

#### `cypress version`

```shell
docker run --rm --entrypoint cypress cypress/included version # show Cypress version installed
```

See [cypress version](https://on.cypress.io/guides/guides/command-line#cypress-version) for example output.

#### `cypress info`

```shell
docker run --rm --entrypoint cypress cypress/included info # show browsers installed and other information
```

See [cypress info](https://on.cypress.io/guides/guides/command-line#cypress-info) for example output.

#### `cypress cache`

```shell
docker run --rm --entrypoint cypress cypress/included cache list # show Cypress binary cache
```

See [cypress cache \[command\]](https://on.cypress.io/guides/guides/command-line#cypress-cache-list) for list of cache command options and example output.

### Debug

To see the [Cypress debug logs](https://on.cypress.io/troubleshooting#Print-DEBUG-logs) during the run, pass the environment variable setting `DEBUG=cypress:*`:

```shell
docker run -it -v .:/e2e -w /e2e -e DEBUG=cypress:* cypress/included
```
