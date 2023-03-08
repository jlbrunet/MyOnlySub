import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log("coucou")
  }

  display() {
    console.log("ici")
  }
}
