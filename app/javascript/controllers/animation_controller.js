import { Controller } from "@hotwired/stimulus"

let a = null
// Connects to data-controller="animation"
export default class extends Controller {
  static targets = ["platform", "info", "moviesseries", "ibutton"]

  connect() {
    a = setInterval(() => this.animation(), 2000)
  }

  animation() {
    this.platformTarget.animate([
      {transform: 'scale(0.4)' },
     ], {
      duration: 1000,
    })

    this.platformTarget.animate( [
      {transform: 'scale(1)' },
    ], {
      duration: 1000,
    })
  }

  display() {
    clearInterval(a)
    this.moviesseriesTarget.classList.remove("d-none")
    this.ibuttonTarget.classList.remove("d-none")
  }
}
