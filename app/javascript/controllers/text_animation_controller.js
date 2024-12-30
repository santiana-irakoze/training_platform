import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["text"];

  connect() {
    this.phrases = [
      "training Anytime, Anywhere ...",
      "helping Alex move",
      "attending your niece's dance recital",
      "being at your wife’s delivery",
      "celebrating your great-aunt’s 96th birthday"
    ];
    this.currentIndex = 0;

    this.loopAnimation(); // Start the animation loop
  }

  loopAnimation() {
    this.updateText(this.phrases[this.currentIndex]);

    setInterval(() => {
      this.currentIndex = (this.currentIndex + 1) % this.phrases.length; // Cycle through phrases
      this.updateText(this.phrases[this.currentIndex]);
    }, 3000); // Change text every 3 seconds
  }

  updateText(phrase) {
    const textElement = this.textTarget;
    textElement.style.opacity = 0; // Fade out
    setTimeout(() => {
      textElement.textContent = phrase; // Update text
      textElement.style.opacity = 1; // Fade in
    }, 500); // Wait for fade-out animation to complete
  }
}
