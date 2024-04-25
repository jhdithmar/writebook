import { Controller } from "@hotwired/stimulus"
import { getCookie, setCookie } from "lib/cookie"

export default class extends Controller {
  static targets = [ "switch" ]
  static values = { id: String }

  connect() {
    this.#restoreViewPref(this.idValue)
  }

  saveViewPref(event) {
    const viewType = event.target.dataset.tocViewTypeValue
    setCookie(this.idValue, viewType)
  }

  #restoreViewPref(id) {
    const viewType = getCookie(id) || "list"
    this.switchTargets.forEach((switchTarget) => {
      switchTarget.checked = switchTarget.dataset.tocViewTypeValue === viewType
    }
  )}
}
