import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "panel",
    "title",
    "description",
    "date",
    "startTime",
    "endTime",
    "eventType",
    "price",
    "registrations",
    "registrationSection",
  ];

  connect() {
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

    this.eventTypeTarget.textContent = `Type: ${
      eventData.type.charAt(0).toUpperCase() + eventData.type.slice(1)
    }`;

    if (eventData.type === "paid") {
      this.priceTarget.textContent = `Price: $${parseFloat(
        eventData.price
      ).toFixed(2)}`;
      this.priceTarget.style.display = "block";
    } else {
      this.priceTarget.textContent = "Price: Free";
      this.priceTarget.style.display = "block";
    }

    this.registrationsTarget.textContent = `Registered: ${eventData.registeredCount} users`;

    this.setupRegistrationButton(eventData);
    this.panelTarget.classList.remove("hidden");
  }

  setupRegistrationButton(eventData) {
    const registrationSection = this.registrationSectionTarget;

    if (eventData.userRegistered) {
      registrationSection.innerHTML = `<div class="registration-status registered">✓ You are registered for this event</div>`;
    } else {
      if (eventData.type === "free") {
        registrationSection.innerHTML = `
          <form action="/registrations" method="post" data-turbo="false">
            <input type="hidden" name="authenticity_token" value="${document
              .querySelector('[name="csrf-token"]')
              .getAttribute("content")}">
            <input type="hidden" name="registration[event_id]" value="${
              eventData.id
            }">
            <button type="submit" class="btn btn-primary">Register for Free</button>
          </form>
        `;
      } else {
        registrationSection.innerHTML = `
          <button class="btn btn-primary" data-action="click->event-details#redirectToPaidRegistration" data-event-id="${
            eventData.id
          }">
            Register ($${parseFloat(eventData.price).toFixed(2)})
          </button>
        `;
      }
    }
  }

  redirectToPaidRegistration(event) {
    const eventId = event.target.dataset.eventId;
    window.Turbo.visit(`/events/${eventId}/register`);
  }

  close() {
    this.panelTarget.classList.add("hidden");
  }
}
