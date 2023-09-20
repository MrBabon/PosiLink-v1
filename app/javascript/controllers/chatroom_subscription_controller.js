import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages", "input"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.messagesTarget.insertAdjacentHTML("beforeend", data) }
    )
    console.log(`Subscrib to the chatroom with the id ${this.chatroomIdValue}.`)
  }

  resetInput() {
    this.inputTarget.value= ""; // Réinitialise la valeur de l'élément de saisie à une chaîne vide
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  async sendMessage() {
    const messageContent = this.inputTarget.value;

    if (messageContent.trim() === "") {
      console.log("Le message est vide. Aucun envoi nécessaire.");
      return;
    }
  
    await fetch(`/chatrooms/${this.chatroomIdValue}/messages`, {
      method: "POST",
      body: JSON.stringify({ message: { content: messageContent } }),
      headers: {
        "Content-Type": "application/json",
      },
    });
    this.scrollToBottom();
  
    this.resetInput();
  }
}