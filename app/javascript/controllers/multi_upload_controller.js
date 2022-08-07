import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["files"]

	addFile(event) {
		const originalInput = event.target;
		const originalParent = originalInput.parentNode;
		const newInput = originalInput.cloneNode();

		const selectedFile = document.createElement('li');
		selectedFile.className = "list-disc list-inside";
		originalInput.className = "hidden";
		selectedFile.append(originalInput);

		var labelNode = document.createElement('label');
		var textElement = document.createTextNode(originalInput.files[0].name);
		labelNode.appendChild(textElement);
		selectedFile.appendChild(labelNode);

		this.filesTarget.append(selectedFile);

		newInput.value = '';
		originalParent.append(newInput);
	}
}
