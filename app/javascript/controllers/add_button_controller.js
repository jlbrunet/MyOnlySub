import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-button"
export default class extends Controller {
  static values = {
    url1: String,
    url2: String,
    url3: String,
    url4: String
   }

  insert(event) {
    event.preventDefault()
    fetch(this.url1Value)
    this.element.remove()
    // this.element.innerHTML = "coucou" --> message pour indiquer que ajouté à la liste
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
