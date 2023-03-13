import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["One Sub...", "to watch them all"],
      typeSpeed: 30,
      loop: true,
    })
  }
}
