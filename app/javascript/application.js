// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
  const newEventPanel = document.getElementById("new-event-panel");
  const eventDetailsPanel = document.getElementById("event-details-panel");

  function hidePanels() {
    newEventPanel.classList.add("hidden");
    eventDetailsPanel.classList.add("hidden");
  }

  document.querySelectorAll(".calendar-cell").forEach(cell => {
    cell.addEventListener("click", () => {
      if (!cell.dataset.date) return;
      const dateInput = newEventPanel.querySelector("#event_date");
      if (dateInput) {
        dateInput.value = cell.dataset.date;
      }
      hidePanels();
      newEventPanel.classList.remove("hidden");
    });
  });

  document.querySelectorAll(".event").forEach(eventEl => {
    eventEl.addEventListener("click", (e) => {
      e.stopPropagation();
      const title = eventEl.dataset.title;
      const description = eventEl.dataset.desc;
      const date = eventEl.dataset.date;
      const start_time = new Date(eventEl.dataset.startTime);
      const end_time = new Date(eventEl.dataset.endTime);

      document.getElementById("event-title").textContent = title;
      document.getElementById("event-description").textContent = description;
      document.getElementById("event-date").textContent = "Date: " + date;
      document.getElementById("event-start-time").textContent = "Start Time: " +
        start_time.toLocaleTimeString("en-US", {
          hour: "numeric",
          minute: "2-digit",
          hour12: true,
        });
      document.getElementById("event-end-time").textContent = "End Time: " +
        end_time.toLocaleTimeString("en-US", {
          hour: "numeric",
          minute: "2-digit",
          hour12: true,
        });

      hidePanels();
      eventDetailsPanel.classList.remove("hidden");
    });
  });

  document.querySelectorAll(".close-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      hidePanels();
    });
  });

});
