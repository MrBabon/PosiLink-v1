import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chatroom-loader"
export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages"];

  loadChatroom(event) {
    event.preventDefault();
    const chatroomId = this.data.get("chatroomId");
    console.log(`Chatroom ID: ${chatroomId}`);

    if (chatroomId) {
      fetch(`/chatrooms/${chatroomId}/messages`)
        .then((response) => response.text())
        .then((data) => {
          this.messagesTarget.innerHTML = data;
        });
    } else {
      console.error("Chatroom ID is null or undefined.");
    }
  }
}
