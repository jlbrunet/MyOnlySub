import { Controller } from "@hotwired/stimulus"
import { Modal } from 'bootstrap';

// Connects to data-controller="movie-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log("coucou")
  }

  display(event) {
    const modal = new Modal(this.modalTarget);
    modal.show();
  }
}
