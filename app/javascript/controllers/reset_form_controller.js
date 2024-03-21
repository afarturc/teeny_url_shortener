import { Controller } from "@hotwired/stimulus"

export default class ResetFormController extends Controller {
	    connect() {
		console.log("hello")
    }
	reset() {
	    this.element.reset()
   }

}
