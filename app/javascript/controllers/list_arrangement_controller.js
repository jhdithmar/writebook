import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  #cursorPosition = 0
  #selections = { 0: true }

  connect() {
  }

  disconnect() {
  }

  focus() {
    this.#setSelectionState()
  }

  blur() {
    this.#clearSelectionState()
  }

  moveCursorUp(event) {
    const index = Math.max(0, this.#cursorPosition - 1)
    this.#moveCursorTo(index, event.shiftKey)
  }

  moveCursorRight() {
    const index = Math.min(this.itemTargets.length - 1, this.#cursorPosition + 1)
    this.#moveCursorTo(index, event.shiftKey)
  }

  moveCursorDown(event) {
    const index = Math.min(this.itemTargets.length - 1, this.#cursorPosition + 1)
    this.#moveCursorTo(index, event.shiftKey)
  }

  moveCursorLeft() {
    const index = Math.max(0, this.#cursorPosition - 1)
    this.#moveCursorTo(index, event.shiftKey)
  }

  #moveCursorTo(index, keepSelection) {
    if (!keepSelection) {
      this.#selections = {}
    }
    this.#cursorPosition = index
    this.#selections[this.#cursorPosition] = true
    this.#setSelectionState()
  }

  #setSelectionState() {
    for (const [index, item] of this.itemTargets.entries()) {
      item.classList.toggle("cursor", index === this.#cursorPosition)
      item.classList.toggle("selected", this.#selections[index] === true)
    }
  }

  #clearSelectionState() {
    for (const item of this.itemTargets) {
      item.classList.remove("cursor", "selected")
    }
  }
}
