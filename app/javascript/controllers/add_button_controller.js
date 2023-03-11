import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-button"
export default class extends Controller {
  static targets = ["addlink"]

  static values = {
    url1: String,
    url2: String,
    url3: String,
    url4: String
   }

  insert(event) {
    event.preventDefault()
    fetch(this.url1Value)
    this.element.classList.add("border-add-wishlist")
    this.element.insertAdjacentHTML("afterbegin", "<i></i>")
    this.element.firstElementChild.classList.add('fa-solid', 'fa-check', 'ticked-add-wishlist')
    this.addlinkTarget.classList.remove('fa-plus')
    this.addlinkTarget.classList.add('fa-trash', 'buttons-footer-card')
  }

  exit(event) {
    event.preventDefault()
    fetch(this.url1Value)
    this.element.remove()
  }

  seen(event) {
    event.preventDefault()
    fetch(this.url2Value)
  }

  liked(event) {
    event.preventDefault()
    fetch(this.url3Value)
  }

  unliked(event) {
    event.preventDefault()
    fetch(this.url4Value)
  }
}
