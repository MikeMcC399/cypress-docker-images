ARG BASE_TEST_IMAGE='cypress/factory'

FROM ${BASE_TEST_IMAGE}
RUN echo "current user: $(whoami)"
ENV CI=1
COPY --chown=node . /opt/app
WORKDIR /opt/app
