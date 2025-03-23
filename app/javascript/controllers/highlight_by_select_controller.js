import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-by-select"
export default class extends Controller {
  static targets = ["select", "highlightItem"]

  connect() {
    this.highlightItems();
  }
  highlight(e) {
    const target_id = e.target.value
    this.highlightItems();
  }
  highlightItems() {
    let selectedIds = this.selectTargets.reduce((idList, select) => {
      if (select?.value ) { idList.push(select.value) }

      return idList;
    }, [])

    this.highlightItemTargets.forEach(highlightItem => {
      highlightItem.classList.toggle("bg-yellow-200", selectedIds.includes(highlightItem.dataset.highlightItemId))
    })
  }
}
