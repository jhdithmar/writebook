import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

const Direction = {
  EARLIER: -1,
  LATER: 1,
}

export default class extends Controller {
  static targets = ["item", "handle"]
  static values = { url: String }

  #cursorPosition
  #selection
  #moveStartOrder

  // Actions

  connect() {
    this.#reset()
  }

  focus() {
    this.#setSelectionState()
  }

  blur() {
    this.#clearSelectionState()
  }

  click(event) {
    const idx = this.#findHandleIndex(event.target)
    if (idx >= 0) {
      event.preventDefault()
      this.#moveCursorTo(idx, event.shiftKey)
    }
  }

  moveUp(event) {
    this.#move(Direction.EARLIER, event.shiftKey)
  }

  moveRight(event) {
    this.#move(Direction.LATER, event.shiftKey)
  }

  moveDown(event) {
    this.#move(Direction.LATER, event.shiftKey)
  }

  moveLeft(event) {
    this.#move(Direction.EARLIER, event.shiftKey)
  }

  toggleMoveMode() {
    if (this.#moving) {
      this.#submitMove()
    }

    this.#moveStartOrder = this.#moving ? undefined : [...this.itemTargets]
    this.element.classList.toggle("move-mode", this.#moving)
  }

  cancelMoveMode() {
    if (this.#moving) {
      this.#restorePreviousOrder()
      this.#moveStartOrder = undefined
      this.element.classList.toggle("move-mode", false)
    }
  }

  // Private

  #move(direction, keepSelection) {
    if (this.#moving) {
      this.#moveSelection(direction)
    } else {
      this.#moveCursor(direction, keepSelection)
    }
  }

  #moveCursor(direction, keepSelection) {
    const index = direction === Direction.EARLIER
        ? Math.max(0, this.#cursorPosition - 1)
        : Math.min(this.itemTargets.length - 1, this.#cursorPosition + 1)

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

  #moveSelection(direction) {
    if (direction === Direction.EARLIER) {
      this.#moveSelectionEarlier()
    } else {
      this.#moveSelectionLater()
    }
  }

  #moveSelectionEarlier() {
    if (this.#selection[0] > 0) {
      const itemToMove = this.itemTargets[this.#selection[0] - 1]
      this.itemTargets[this.#selection[1]].after(itemToMove)

      this.#selection = [this.#selection[0] - 1, this.#selection[1] - 1]
      this.#cursorPosition--
      this.#setSelectionState()
    }
  }

  #moveSelectionLater() {
    if (this.#selection[1] < this.itemTargets.length - 1) {
      const itemToMove = this.itemTargets[this.#selection[1] + 1]
      this.itemTargets[this.#selection[0]].before(itemToMove)

      this.#selection = [this.#selection[0] + 1, this.#selection[1] + 1]
      this.#cursorPosition++
      this.#setSelectionState()
    }
  }

  #restorePreviousOrder() {
    this.element.append(...this.#moveStartOrder)
    this.#reset()
    this.#setSelectionState()
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

  #submitMove() {
    const position = this.#selection[0]
    const ids = this.itemTargets
      .slice(this.#selection[0], this.#selection[1] + 1)
      .map((item) => item.dataset.id)

    const body = new FormData()
    body.append("position", position)
    ids.forEach((id) => body.append("id[]", id))

    post(this.urlValue, { body })
  }

  #reset() {
    this.#cursorPosition = 0
    this.#selection = [0, 0]
    this.#moveStartOrder = undefined
  }

  #findHandleIndex(target) {
    for (const [i, handle] of this.handleTargets.entries()) {
      if (handle.contains(target)) {
        return i
      }
    }
  }

  get #moving() {
    return this.#moveStartOrder !== undefined
  }
}
