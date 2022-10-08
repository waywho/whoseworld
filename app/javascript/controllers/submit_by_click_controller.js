import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-by-click"
export default class extends Controller {
  connect() {
  }
  submit() {
    console.log(this.element)
    this.element.submit();
  }
}
