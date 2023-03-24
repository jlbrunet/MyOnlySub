import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
    static targets = ["line", "lines"]

  connect() {
    setTimeout(() => {
      setTimeout(() => {
        new Typed(this.linesTarget, {
          strings: ["to watch them all."],
          typeSpeed: 90,
          loop: false,
          showCursor: false,
        });
      }, 1600);{
        new Typed(this.lineTarget, {
        strings: ["One Sub..."],
        typeSpeed: 90,
        loop: false,
        showCursor: false,
        });
      }
    }, 600);
  }
}
