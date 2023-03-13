import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="enable-submit"
export default class extends Controller {

  connect() {
    console.log("hey")
  }
  const formInput = document.querySelector(".input-login-sub");
  const formButton = document.querySelector(".btn-sub2");
  formButton.disabled = true;
  formInput.addEventListener("keyup", enable);

  enable() {
    if (document.querySelector(".input-login-sub").value === "" || document.querySelector(".input-login-sub").value < 1) {
      formButton.disabled = true;
  } else {
      formButton.disabled = false;
  }
  }
}
