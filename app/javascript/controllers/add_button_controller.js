import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-button"
export default class extends Controller {
  static targets = ["addlink", "checkbutton", "removelink", "like", "unlike"]

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
      this.removelinkTarget.classList.toggle('fa-plus')
      this.removelinkTarget.classList.toggle('fa-trash')

      this.checkbuttonTarget.classList.toggle('d-none')
    }
  }

  seen(event) {
    event.preventDefault()
    fetch(this.url2Value)
  }

  liked(event) {
    event.preventDefault()
    fetch(this.url3Value)
    // console.log(this.likeTarget)
    if (this.likeTarget.classList.contains('active')) {
      this.likeTarget.classList.remove('active')
      this.unlikeTarget.classList.remove('unactive')
    } else if (this.likeTarget.classList.contains('unactive')) {
      this.likeTarget.classList.remove('unactive')
      this.likeTarget.classList.add('active')
      this.unlikeTarget.classList.remove('active')
      this.unlikeTarget.classList.add('unactive')
    } else {
      this.likeTarget.classList.toggle('active')
      this.unlikeTarget.classList.toggle('unactive')
    }
  }

  unliked(event) {
    event.preventDefault()
    fetch(this.url4Value)
    if (this.unlikeTarget.classList.contains('active')) {
      this.unlikeTarget.classList.remove('active')
      this.likeTarget.classList.remove('unactive')
    } else if (this.unlikeTarget.classList.contains('unactive')) {
      this.unlikeTarget.classList.remove('unactive')
      this.unlikeTarget.classList.add('active')
      this.likeTarget.classList.remove('active')
      this.likeTarget.classList.add('unactive')
    } else {
      this.unlikeTarget.classList.toggle('active')
      this.likeTarget.classList.toggle('unactive')
    }
  }
}
