# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "chartkick", to: "chartkick.js", preload: true
pin "chart.js", to: "chart.min.js", preload: true
pin "turbo", to: "turbo.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
