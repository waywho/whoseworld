import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
  }
  smoothScroll(event) {
    event.preventDefault();
    const id = event.target.href.split("#")[1]
    console.log(document.getElementById(id))
    document.getElementById(id).scrollIntoView({
      behavior: 'smooth'
    });
  }
}
