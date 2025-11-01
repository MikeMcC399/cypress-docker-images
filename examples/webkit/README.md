# examples/webkit

This directory contains a simple example of a Cypress E2E test with one test spec `cypress/e2e/spec.cy.js` running using the WebKit browser.

### Playwright dependencies

- Playwright on Linux requires [additional dependencies](https://docs.cypress.io/app/references/launching-browsers#Linux-Dependencies) installed.

- Playwright on Debian 13 requires a minimum [Playwright 1.55](https://playwright.dev/docs/release-notes#version-155) version.

## Non-Docker demonstration

Use regular [Cypress CLI commands](https://docs.cypress.io/guides/guides/command-line) to run Cypress with WebKit:

```shell
cd examples/webkit
npm ci
npx playwright install-deps webkit      # required for Linux only
npx cypress run --browser webkit        # runs test to completion and exits
```

### Docker interactive

In this example we first run the unchanged image `cypress/base` as a container:

```shell
cd examples/webkit         # Use a pre-configured simple Cypress E2E project
npm ci                     # Install Cypress
docker run -it --rm -v .:/app -w /app cypress/base  # Run image as container
```

At the `bash` prompt `:/app#`, we can then enter the following commands:

```shell
npx playwright install-deps webkit # Install Playwright dependencies for Linux
npx playwright install             # Install cached Playwright executable
unset CI                           # Allows to see installation progress
npx cypress install                # Install Cypress binary into running Docker container
npx cypress run --browser webkit   # Run Cypress test
exit
```

### Docker build and run

In this example we use a customized `Dockerfile` which bases a new image on `cypress/base`, copies the complete Cypress project into the image, including installed dependencies, then installs Playwright and the Cypress binary into the image.

The file is [examples/webkit/Dockerfile](../examples/webkit/Dockerfile) and it has the following contents:

```dockerfile
FROM cypress/base
COPY . /opt/app
WORKDIR /opt/app
RUN npx playwright install-deps webkit # Install Playwright dependencies for Linux
RUN npx playwright install             # Install cached Playwright executable
RUN npx cypress install                # Install Cypress binary into image
```

We build the new image, run the container from the image and execute the Cypress command `npx cypress run --browser webkit` to run the test using WebKit:

```shell
cd examples/webkit             # Use a pre-configured simple Cypress E2E project
npm ci                         # Install all dependencies s
docker build -t test-webkit .  # Build a new image
docker run -it --rm --entrypoint bash test-webkit -c "npx cypress run --browser webkit" # Run Cypress test using WebKit
```

## Reference

Cypress documentation

[Guides > Launching Browsers > WebKit (Experimental)](https://docs.cypress.io/app/references/launching-browsers#WebKit-Experimental)
