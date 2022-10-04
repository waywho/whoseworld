import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['navigation', 'trigger', 'open', 'close', 'logo']
  connect() {

  }

  toggle() {
    let position = this.element.dataset.placement
    if (position == null && position == undefined) return

    const position_classes = {
      'left': '-translate-x-64',
      'right': 'translate-x-64'
    };

    this.navigationTarget.classList.toggle(position_classes[position]);
    this.triggerTarget.classList.toggle('bg-gray-100');
    this.openTarget.classList.toggle('hidden');
    this.closeTarget.classList.toggle('hidden');
    this.logoTarget.classList.toggle('hidden');
  }
}
