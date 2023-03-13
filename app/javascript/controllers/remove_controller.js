import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove"
export default class extends Controller {

  static values = {
    url5: String,
  }

  exit(event) {
    event.preventDefault()
    console.log(this.url5Value)
    fetch(this.url5Value)
    this.element.remove()
  }
}
