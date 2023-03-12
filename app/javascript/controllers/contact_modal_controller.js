import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="contact-modal"
export default class extends Controller {

  static target = ["modal"]

  open() {
    fetch(this.data.get("url"))
      .then( response => response.text())
      .then( html => {
        this.modalTarget.innerHTML = html
        M.Modal.init(document.getElementById('contact-modal')).open()
      })
  }

  close() {
    M.Modal.init(document.getElementById('contact-modal')).close()
  }
}
