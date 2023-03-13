import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sub-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
  }

  display() {
    this.modalTarget.classList.toggle('d-none');
  }

  close() {
    this.modalTarget.classList.add('d-none');
  }
}
