import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="registration-form"
export default class extends Controller {
  static targets = ["checkbox"];
  
  toggle() {
    const isChecked = this.checkboxTarget.checked;
    const isAssociationField = document.querySelector("#user_is_organization");
    isAssociationField.value = isChecked ? "1" : "0";
  
  }
}
