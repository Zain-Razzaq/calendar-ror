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
      const dateInput = newEventPanel.querySelector("input[name='date']");
      dateInput.value = cell.dataset.date;
      hidePanels();
      newEventPanel.classList.remove("hidden");
    });
  });

  document.querySelectorAll(".event").forEach(eventEl => {
    eventEl.addEventListener("click", (e) => {
      e.stopPropagation();
      const title = eventEl.dataset.title;
      const description = eventEl.dataset.description;

      document.getElementById("event-title").textContent = title;
      document.getElementById("event-description").textContent = description;

      hidePanels();
      eventDetailsPanel.classList.remove("hidden");
    });
  });

  document.querySelectorAll(".close-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      hidePanels();
    });
  });

  document.getElementsByClassName("close-btn").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.stopPropagation();
      hidePanels();
    });
  });
});
