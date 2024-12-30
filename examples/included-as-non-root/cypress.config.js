const { defineConfig } = require('cypress')

module.exports = defineConfig({
  fixturesFolder: false,
  screenshotsFolder: '/tmp/cypress/screenshots',
  videosFolder: '/tmp/cypress/videos',
  e2e: {
    supportFile: false,
  },
})
