// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "chartkick/chart.js";
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

document.addEventListener("turbo:load", function () {
  console.log("Turbo carregado!");
});
