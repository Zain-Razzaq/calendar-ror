import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["price"];

  connect() {
    console.log("Event type controller connected");
  }

  togglePrice(event) {
    const eventType = event.target.value;
    const priceField = document.getElementById("price-field");
    const priceInput = this.priceTarget;

    if (eventType === "paid") {
      priceField.style.display = "block";
      priceInput.required = true;
    } else {
      priceField.style.display = "none";
      priceInput.required = false;
      priceInput.value = "0";
    }
  }
}
