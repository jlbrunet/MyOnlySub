import { Controller } from "@hotwired/stimulus"

let a = null
// Connects to data-controller="animation"
export default class extends Controller {
  static targets = ["platform", "moviesseries", "infos"]

  connect() {
    a = setInterval(() => this.animation(), 1000)
  }

  animation() {
    this.platformTarget.animate([
      {transform: 'scale(0.3)' },
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
    this.infosTarget.classList.remove("d-none")
    this.platformTarget.classList.remove("image_hover")
  }
}
