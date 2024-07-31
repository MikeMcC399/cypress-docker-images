FROM cypress/base
COPY . /opt/app
WORKDIR /opt/app
RUN npx playwright install-deps webkit # Install Playwright dependencies for Linux
RUN npx playwright install             # Install cached Playwright executable
RUN npx cypress install                # Install Cypress binary into image
