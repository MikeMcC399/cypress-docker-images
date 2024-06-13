# cypress/included

[![Docker Pulls](https://img.shields.io/docker/pulls/cypress/included.svg?maxAge=604800)](https://hub.docker.com/r/cypress/included/)

> Docker images with all operating system dependencies, Cypress, and some pre-installed browsers.

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

`cypress/included` images have their Docker [ENTRYPOINT](https://docs.docker.com/reference/dockerfile/#entrypoint) set to `"cypress" "run"`.

To run a `cypress/included` image using `cypress run`, for instance to run all test specs in the default Electron browser, no additional [docker run](https://docs.docker.com/reference/cli/docker/container/run/) CLI options are needed.

To use [`cypress run` options](https://docs.cypress.io/guides/guides/command-line#cypress-run), such as `-b chrome`, use the [docker run](https://docs.docker.com/reference/cli/docker/container/run/) command with `--entrypoint cypress` to overwrite the default `ENTRYPOINT` of the `cypress/included` image.

To run `bash` commands interactively in the image, for instance to inspect files, directories or to run Cypress interactively, use the [docker run](https://docs.docker.com/reference/cli/docker/container/run/) command with `--entrypoint bash`.

See below for examples.

## Examples

> [!TIP]
> Remove `cypress` from your project's `package.json` to avoid version mismatch between your project and the `cypress/included` Docker image.

The directory [examples/basic-mini](../examples/basic-mini/) in this repo provides an example project which includes a Cypress E2E test spec and has no Cypress version included in its [package.json](../examples/basic-mini/package.json).

### Docker interactive

In this example we first run the image `cypress/included` as a container, overriding the default command of `cypress run` using `--entrypoint bash` to enter the interactive `bash` shell.

```shell
cd examples/basic-mini         # Use a pre-configured simple Cypress E2E project
docker run -it --rm -v .:/e2e -w /e2e --entrypoint bash cypress/included  # Run image as container
```

At the `bash` prompt `:/e2e#`, we can then enter the following commands:

```shell
ls -al                    # Check the contents of our working directory
npx cypress run -b chrome # Run Cypress test in Chrome
```

### Docker default

In this example we let the Docker image handle running Cypress automatically through the pre-defined `cypress run` command. This runs Cypress with the default Electron browser:

```shell
cd examples/basic-mini         # Use a pre-configured simple Cypress E2E project
docker run -it --rm -v .:/e2e -w /e2e cypress/included  # Run image as container and execute cypress run
```

### Browser

To run `cypress/included` using one of the installed browsers (Chrome, Edge or Firefox), we change to `--entrypoint cypress` and add the command `run -b chrome`, for instance, to test against the Chrome browser:

```shell
cd examples/basic-mini
docker run -it --rm -v .:/e2e -w /e2e --entrypoint cypress cypress/included run -b chrome
```

### Debug

To see [Cypress debug logs](https://on.cypress.io/troubleshooting#Print-DEBUG-logs) during the run, pass the environment variable setting with `-e DEBUG=cypress:*`:

```shell
cd examples/basic-mini
docker run -it --rm -v .:/e2e -w /e2e -e DEBUG=cypress:* cypress/included
```

### Single test spec

To run a single test spec using the Chrome browser:

```shell
cd examples/basic-mini
docker run -it -v .:/e2e -w /e2e --entrypoint cypress cypress/included run --spec cypress/e2e/spec.cy.js -b chrome
```

### Info

To get Cypress to show all version information:

```shell
cd examples/basic-mini
docker run -it --entrypoint cypress cypress/included info
```

```text
$ docker run -it --entrypoint=cypress cypress/included info

DevTools listening on ws://127.0.0.1:41043/devtools/browser/7da6e086-a4eb-4408-acab-e22f3cb6c076
Displaying Cypress info...

Detected 3 browsers installed:

1. Chrome
  - Name: chrome
  - Channel: stable
  - Version: 125.0.6422.60
  - Executable: google-chrome

2. Edge
  - Name: edge
  - Channel: stable
  - Version: 125.0.2535.51
  - Executable: edge

3. Firefox
  - Name: firefox
  - Channel: stable
  - Version: 126.0
  - Executable: firefox

Note: to run these browsers, pass <name>:<channel> to the '--browser' field

Examples:
- cypress run --browser firefox
- cypress run --browser edge

Learn More: https://on.cypress.io/launching-browsers

Proxy Settings: none detected
Environment Variables:
CYPRESS_CACHE_FOLDER: /root/.cache/Cypress
CYPRESS_FACTORY_DEFAULT_NODE_VERSION: 20.13.1

Application Data: /root/.config/cypress/cy/development
Browser Profiles: /root/.config/cypress/cy/development/browsers
Binary Caches: /root/.cache/Cypress

Cypress Version: 13.10.0 (stable)
System Platform: linux (Debian - 11.9)
System Memory: 5.16 GB free 4.09 GB
```

## Default user

By default, `cypress/included` images run as `root` user. You can switch to the non-root user `node` in the image or to a custom-mapped user, see the [Alternate users](#alternate-users) section below.

## GitHub Action

You can quickly run your tests in GitHub Actions using these images, see [GitHub Action example](https://github.com/cypress-io/github-action#docker-image) repository.

## Alternate users

The following examples are built on `cypress/included:3.8.0` and have not yet been updated to demonstrate current Cypress versions:

- [examples/included-as-non-root](../examples/included-as-non-root) shows how to build a new Docker image on top of `cypress/included` image and run the tests as non-root user `node`.
- [examples/included-as-non-root-alternative](../examples/included-as-non-root-alternative) shows another approach to allow built-in non-root user `node` to run tests using `cypress/included` image.
- [examples/included-as-non-root-mapped](../examples/included-as-non-root-mapped) shows how to build a Docker image on top of `cypress/included` that runs with a non-root user that matches the id of the user on the host machine. This way, the permissions on any files created during the test run match the user's permissions on the host machine.

## Using plugins

The following example is built on `cypress/included:3.8.0` and has not yet been updated to demonstrate current Cypress versions:

- [examples/included-with-plugins](../examples/included-with-plugins) shows how to use locally installed [Cypress plugins](https://on.cypress.io/plugins) while running `cypress/included` image.
