import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-by-click"
export default class extends Controller {
  connect() {
  }
  submit() {
    this.element.submit();
  }
}
