import { Controller } from "@hotwired/stimulus"

export default class ResetFormController extends Controller {
	reset() {
	    this.element.reset()
       }

}
