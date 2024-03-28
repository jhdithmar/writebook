import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  #cursorPosition = 0
  #selection = [ 0, 0 ]
  #moveStartOrder = undefined

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
    if (this.#moving) {
      this.#moveSelectionEarlier()
    } else {
      this.#moveCursorEarlier(event.shiftKey)
    }
  }

  moveCursorRight(event) {
    if (this.#moving) {
      this.#moveSelectionLater()
    } else {
      this.#moveCursorLater(event.shiftKey)
    }
  }

  moveCursorDown(event) {
    if (this.#moving) {
      this.#moveSelectionLater()
    } else {
      this.#moveCursorLater(event.shiftKey)
    }
  }

  moveCursorLeft(event) {
    if (this.#moving) {
      this.#moveSelectionEarlier()
    } else {
      this.#moveCursorEarlier(event.shiftKey)
    }
  }

  toggleMoveMode() {
    this.#moveStartOrder = this.#moving ? undefined : [ ...this.itemTargets ]
    this.element.classList.toggle("move-mode", this.#moving)
  }

  cancelMoveMode() {
    if (this.#moving) {
      this.#restorePreviousOrder()
      this.#moveStartOrder = undefined
      this.element.classList.toggle("move-mode", false)
    }
  }

  #moveCursorEarlier(keepSelection) {
    const index = Math.max(0, this.#cursorPosition - 1)
    this.#moveCursorTo(index, keepSelection)
  }

  #moveCursorLater(keepSelection) {
    const index = Math.min(this.itemTargets.length - 1, this.#cursorPosition + 1)
    this.#moveCursorTo(index, keepSelection)
  }

  #moveCursorTo(index, keepSelection) {
    this.#cursorPosition = index
    if (keepSelection) {
      this.#selection = [ Math.min(this.#selection[0], index), Math.max(this.#selection[1], index) ]
    } else {
      this.#selection = [ index, index ]
    }

    this.#setSelectionState()
  }

  #moveSelectionEarlier() {
    if (this.#selection[0] > 0) {
      const itemToMove = this.itemTargets[this.#selection[0] - 1]
      this.itemTargets[this.#selection[1]].after(itemToMove)

      this.#selection = [ this.#selection[0] - 1, this.#selection[1] - 1 ]
      this.#cursorPosition--
      this.#setSelectionState()
    }
  }

  #moveSelectionLater() {
    if (this.#selection[1] < this.itemTargets.length - 1) {
      const itemToMove = this.itemTargets[this.#selection[1] + 1]
      this.itemTargets[this.#selection[0]].before(itemToMove)

      this.#selection = [ this.#selection[0] + 1, this.#selection[1] + 1 ]
      this.#cursorPosition++
      this.#setSelectionState()
    }
  }

  #restorePreviousOrder() {
    for (const el of this.#moveStartOrder) {
    }
    console.log("Order was", this.#moveStartOrder)
  }

  #setSelectionState() {
    for (const [index, item] of this.itemTargets.entries()) {
      item.classList.toggle("cursor", index === this.#cursorPosition)
      item.classList.toggle("selected", this.#isSelected(index))
    }
  }

  #clearSelectionState() {
    for (const item of this.itemTargets) {
      item.classList.remove("cursor", "selected")
    }
    this.element.classList.remove("move-mode")
  }

  #isSelected(index) {
    return index >= this.#selection[0] && index <= this.#selection[1]
  }

  get #moving() {
    return this.#moveStartOrder !== undefined
  }
}
