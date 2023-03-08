import { Application } from "@hotwired/stimulus"
// # pour sortable
import Sortable from 'stimulus-sortable'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application


// # pour sortable
application.register('sortable', Sortable)


export { application }
