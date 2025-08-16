import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["counter", "input"]

  connect() {
    this.quantity = parseInt(this.inputTarget.value) || 1;
    this.updateCounter();
  }

  increase() {
    this.quantity++;
    this.updateCounter();
  }

  decrease() {
    if (this.quantity > 1) {
      this.quantity--;
      this.updateCounter();
    }
  }

  updateCounter() {
    this.counterTarget.textContent = this.quantity;
    this.inputTarget.value = this.quantity;
  }
}
