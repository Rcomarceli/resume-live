const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    "retries": 10,
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
