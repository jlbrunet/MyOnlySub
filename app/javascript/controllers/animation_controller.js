import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {
  static targets = ["platform", "info", "moviesseries", "ibutton"]

  connect() {
    this.platformTarget.animate([
      {transform: 'scale(0.4)' },
     ], {
      duration: 2000,
      iteration: Infinity,
    })

    this.platformTarget.animate( [
      {transform: 'scale(1)' },
    ], {
      duration: 2000,
      iteration: Infinity,
    })
  }

  display() {
    this.moviesseriesTarget.classList.remove("d-none")
    this.ibuttonTarget.classList.remove("d-none")
  }
}
