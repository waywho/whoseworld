import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
	static targets = ['nav', 'menu']

	connect() {
		console.log("found")
	}

	toggle() {
		if (this.navTarget.dataset.position === "top") {
			this.menuTarget.classList.toggle('hidden');
		} else if (this.navTarget.dataset.position === "left") {
			this.navTarget.classList.toggle('-translate-x-[250px]')
		} else if (this.navTarget.dataset.position === "right") {
			this.navTarget.classList.toggle('translate-x-[250px]')
		}
	}
}