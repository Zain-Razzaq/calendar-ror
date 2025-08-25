import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["submit"];

  connect() {
    console.log("Form controller connected");
  }

  submitForm(event) {
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = true;
      this.submitTarget.textContent = "Creating Event...";
    }
  }

  resetForm() {
    if (this.hasSubmitTarget) {
      this.submitTarget.disabled = false;
      this.submitTarget.textContent = "Create Event";
    }
  }
}
