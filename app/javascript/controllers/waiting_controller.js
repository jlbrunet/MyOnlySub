import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="waiting"
export default class extends Controller {
  static targets = ["waiter", "modal"]


  waiting(event) {
    event.preventDefault()
    this.modalTarget.classList.add('d-none');

    this.waiterTarget.classList.toggle('d-none')

    const form = event.target.closest(".my-form")


    setTimeout(() => {
      form.submit()
      this.waiterTarget.classList.add('d-none')
    }, 2800)

  }
}
