import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  static targets = ["cell", "eventDetails"];
  static values = { selectedDate: String };

  connect() {
    console.log("Calendar controller connected");
  }

  cellClicked(event) {
    const cell = event.currentTarget;
    const date = cell.dataset.date;

    if (!date) return;
    this.selectedDateValue = date;
    Turbo.visit(`/events/new?date=${date}`);
  }

  eventClicked(event) {
    event.stopPropagation();

    const eventElement = event.currentTarget;
    const eventData = {
      id: eventElement.dataset.id,
      title: eventElement.dataset.title,
      desc: eventElement.dataset.desc,
      date: eventElement.dataset.date,
      startTime: eventElement.dataset.startTime,
      endTime: eventElement.dataset.endTime,
      type: eventElement.dataset.eventType,
      price: eventElement.dataset.price,
      registeredCount: eventElement.dataset.registeredCount,
      userRegistered: eventElement.dataset.userRegistered === "true",
    };

    this.dispatch("eventSelected", {
      detail: eventData,
    });
  }
}
