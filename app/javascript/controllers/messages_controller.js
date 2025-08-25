import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static targets = ["input", "list"];

  connect() {
    this.consumer = createConsumer();
    this.subscription = this.consumer.subscriptions.create("MessagesChannel", {
      received: (data) => {
        this.appendMessage(data);
      },
    });
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
    if (this.consumer) {
      this.consumer.disconnect();
    }
  }

  messageCreated() {
    this.inputTarget.value = "";
  }

  appendMessage(data) {
    const messageDiv = document.createElement("div");
    messageDiv.className = "message";

    const headerDiv = document.createElement("div");
    headerDiv.className = "message-header";

    const userSpan = document.createElement("span");
    userSpan.className = "message-user";
    userSpan.textContent = data.user_name;

    const timeSpan = document.createElement("span");
    timeSpan.className = "message-time";
    timeSpan.textContent = data.created_at;

    headerDiv.appendChild(userSpan);
    headerDiv.appendChild(timeSpan);

    const contentDiv = document.createElement("div");
    contentDiv.className = "message-content";
    contentDiv.textContent = data.content;

    messageDiv.appendChild(headerDiv);
    messageDiv.appendChild(contentDiv);

    this.listTarget.appendChild(messageDiv);
    this.scrollToBottom();
  }

  scrollToBottom() {
    this.listTarget.scrollTop = this.listTarget.scrollHeight;
  }
}
