import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chatroom-loader"
export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["message"];

  initialize() {
    // Attendez que la page soit chargée
    document.addEventListener("DOMContentLoaded", () => {
      console.log("initialize() a été exécutée.");
    });
  }

  loadChatroom(event) {
    event.preventDefault();
    const chatroomId = this.data.get("chatroomId");
    console.log(`Chatroom ID: ${chatroomId}`);

    if (chatroomId) {
      fetch(`/chatrooms/${chatroomId}/chatroom_partial`)
        .then((response) => response.text())
        .then((data) => {
          const targetElement = document.querySelector(".tentative");

          if (targetElement) {
            targetElement.innerHTML = data;
          }
          // this.messageTarget.innerHTML = data;
        });
    } else {
      console.error("Chatroom ID is null or undefined.");
    }
  }
}
