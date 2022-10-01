// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
// import "./controllers"

import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import Sortable from 'stimulus-sortable'
import Flowbite from 'flowbite'

const application = Application.start()
application.register('sortable', Sortable)
application.register('flowbite', Flowbite)

const context = require.context("./controllers", true, /\.js$/)
const contextComponents = require.context("../components", true, /_controller\.js$/)

function getComponentControllerDefinitions(context) {
	return context.keys().map((key) => {
		const identifier = key
			.split('/')
			[key.split('/').length - 1].replace('controller.js', '')
			.replace(/[\W_]/g, '-')
			.replace(/^-+/, '')
			.replace(/-+$/, '');
		return { identifier, controllerConstructor: context(key).default };
	});
}
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

window.Stimulus.load(
	definitionsFromContext(context).concat(
		getComponentControllerDefinitions(contextComponents)
	)
);

export { application }
