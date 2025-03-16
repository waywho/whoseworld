import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-by-select"
export default class extends Controller {
  connect() {
    console.log("connect test")
  }
  submit() {
    this.element.submit();
  }
}
