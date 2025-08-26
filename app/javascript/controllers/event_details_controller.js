import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "panel",
    "title",
    "description",
    "date",
    "startTime",
    "endTime",
  ];

  connect() {
    console.log("Event details controller connected");

    document.addEventListener(
      "calendar:eventSelected",
      this.showEventDetails.bind(this)
    );
  }

  disconnect() {
    document.removeEventListener(
      "calendar:eventSelected",
      this.showEventDetails.bind(this)
    );
  }

  showEventDetails(event) {
    const eventData = event.detail;

    this.titleTarget.textContent = eventData.title;
    this.descriptionTarget.textContent = eventData.desc;
    this.dateTarget.textContent = `Date: ${eventData.date}`;

    if (eventData.startTime) {
      const startTime = new Date(eventData.startTime);
      this.startTimeTarget.textContent = `Start Time: ${startTime.toLocaleTimeString(
        "en-US",
        {
          hour: "numeric",
          minute: "2-digit",
          hour12: true,
        }
      )}`;
    }

    if (eventData.endTime) {
      const endTime = new Date(eventData.endTime);
      this.endTimeTarget.textContent = `End Time: ${endTime.toLocaleTimeString(
        "en-US",
        {
          hour: "numeric",
          minute: "2-digit",
          hour12: true,
        }
      )}`;
    }

    this.panelTarget.classList.remove("hidden");
  }

  close() {
    this.panelTarget.classList.add("hidden");
  }
}
