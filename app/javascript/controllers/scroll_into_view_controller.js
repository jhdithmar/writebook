import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { animation: String }

  #scrolled = false

  async connect() {
    if (!this.#scrolled) {
      this.element.scrollIntoView({ behavior: "smooth", block: "center" })
      this.element.classList.add(this.animationValue)

      this.#scrolled = true
    }
  }

  animationEnd() {
    this.element.classList.remove(this.animationValue)
  }
}
