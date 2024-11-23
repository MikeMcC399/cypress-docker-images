const { defineConfig } = require('cypress')

module.exports = defineConfig({
  experimentalWebKitSupport: true,
  fixturesFolder: false,
  e2e: {
    supportFile: false,
  },
})
