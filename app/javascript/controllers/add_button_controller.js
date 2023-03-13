import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-button"
export default class extends Controller {
  static targets = ["addlink", "checkbutton", "removelink"]

  static values = {
    url1: String,
    url2: String,
    url3: String,
    url4: String
   }

  connect() {
    if (document.URL.includes("wishlist") || document.URL.includes("/sub")) {
      this.checkbuttonTarget.classList.add('d-none')
    }
  }

  insert(event) {
    event.preventDefault()
    console.log(this.url1Value)
    fetch(this.url1Value)

    // this.element.classList.toggle('border-add-wishlist')

    this.addlinkTarget.classList.toggle('fa-plus')
    this.addlinkTarget.classList.toggle('fa-trash')

    this.checkbuttonTarget.classList.toggle('d-none')
  }

  exit(event) {
    event.preventDefault()
    fetch(this.url1Value)
    if (document.URL.includes("wishlist") || document.URL.includes("/sub")) {
      this.element.remove()
    }
    else {
      this.element.classList.toggle('border-add-wishlist')
      this.removelinkTarget.classList.toggle('fa-plus')
      this.removelinkTarget.classList.toggle('fa-trash')
      this.checkbuttonTarget.classList.toggle('fa-solid')
      this.checkbuttonTarget.classList.toggle('fa-check')
      this.checkbuttonTarget.classList.toggle('ticked-add-wishlist')
    }
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
