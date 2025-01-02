import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "container"]

  connect() {
    console.log("Timer controller connected")

    if (!this.hasDisplayTarget || !this.hasContainerTarget) {
      console.error("Missing required timer targets")
      return
    }

    const durationInMinutes = this.containerTarget.dataset.duration
    console.log("Duration in minutes:", durationInMinutes)

    if (!durationInMinutes) {
      console.error("No duration specified for timer")
      return
    }

    this.timeLeft = parseInt(durationInMinutes) * 60

    if (isNaN(this.timeLeft) || this.timeLeft <= 0) {
      console.error("Invalid duration value:", durationInMinutes)
      return
    }

    console.log(`Timer initialized with duration: ${this.timeLeft} seconds (${durationInMinutes} minutes)`)

    this.updateTimerDisplay()
    this.startTimer()
  }

  disconnect() {
    console.log("Timer controller disconnected")
    if (this.timerInterval) {
      clearInterval(this.timerInterval)
    }
  }

  startTimer() {
    console.log("Starting timer")
    this.timerInterval = setInterval(() => {
      if (this.timeLeft <= 0) {
        console.log("Timer finished")
        clearInterval(this.timerInterval)
        this.handleTimeUp()
      } else {
        this.timeLeft -= 1
        this.updateTimerDisplay()
      }
    }, 1000)
  }

  updateTimerDisplay() {
    const minutes = Math.floor(this.timeLeft / 60)
    const seconds = this.timeLeft % 60
    const display = `⏳ Time Left: ${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
    console.log("Updating display:", display)
    this.displayTarget.textContent = display
  }

  handleTimeUp() {
    alert('Time is up! Submitting your test...')
    const form = this.element.querySelector('form')
    if (form) {
      form.submit()
    } else {
      console.error("Form not found")
    }
  }
}
