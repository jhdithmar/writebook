import { Controller } from "@hotwired/stimulus"

const SWIPE_THRESHOLD = 50

export default class extends Controller {
  static targets = ["button"]

  connect() {
    this.element.addEventListener("touchstart", this.#handleTouchStart.bind(this), false)
    this.element.addEventListener("touchend", this.#handleTouchEnd.bind(this), false)
  }

  #handleTouchStart(event) {
    this.startX = event.touches[0].clientX
    this.startY = event.touches[0].clientY
  }

  #handleTouchEnd(event) {
    const endX = event.changedTouches[0].clientX
    const endY = event.changedTouches[0].clientY
    const deltaX = Math.abs(endX - this.startX)
    const deltaY = Math.abs(endY - this.startY)

    if (deltaX > SWIPE_THRESHOLD && deltaY < SWIPE_THRESHOLD) {
      if (this.startX > endX) {
        this.#swipedForward()
      }
    }
  }

  #swipedForward() {
    this.buttonTarget.click()
  }
}
