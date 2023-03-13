import { Controller } from "@hotwired/stimulus"
import { Modal } from 'bootstrap';

// Connects to data-controller="info-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
  }

  display() {
    this.modalTarget.classList.toggle('d-none')
  }

  // close() {
  //   this.modalTarget.classList.add('d-none');
  // }
}
