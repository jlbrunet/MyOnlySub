import { Controller } from "@hotwired/stimulus"
import { Modal } from 'bootstrap';

// Connects to data-controller="movie-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    // console.log("coucou");
  }

  display() {
    // console.log(this.modalTarget);
    this.modalTarget.classList.toggle('d-none');
  }

  close() {
    this.modalTarget.classList.add('d-none');
  }
}
