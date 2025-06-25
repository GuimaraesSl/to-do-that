// app/javascript/controllers/tag_editor_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "button", "input"]

  connect() {
    this.taggableType = this.element.dataset.taggableType || "Task"
    this.taggableId = this.element.dataset.taggableId
  }

  showForm() {
    this.formTarget.classList.remove("hidden")
    this.buttonTarget.classList.add("hidden")
    this.inputTarget.focus()
  }

  cancelForm() {
    this.resetForm()
  }

  resetForm() {
    this.formTarget.classList.add("hidden")
    this.buttonTarget.classList.remove("hidden")
    this.inputTarget.value = ""
  }

  addTag() {
    const tagName = this.inputTarget.value.trim()
    if (tagName) {
      const formData = new FormData()
      formData.append("tagging[taggable_type]", this.taggableType)
      formData.append("tagging[taggable_id]", this.taggableId)
      formData.append("tag[title]", tagName)
      formData.append("tag[color]", this.generateColor())

      const submitButton = this.formTarget.querySelector('[data-action="click->tag-editor#addTag"]')
      submitButton.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>'
      submitButton.disabled = true

      fetch("/taggings", {
        method: "POST",
        body: formData,
        headers: {
          "Accept": "text/vnd.turbo-stream.html",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))
      .finally(() => {
        this.resetForm()
      })
    }
  }



  removeTag(event) {
    event.stopPropagation()
    const taggingId = event.currentTarget.dataset.taggingId

      fetch(`/taggings/${taggingId}`, {
        method: "DELETE",
        headers: {
          "Accept": "text/vnd.turbo-stream.html",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))
    
  }

  generateColor() {
    const hue = Math.floor(Math.random() * 360)    
    const saturation = Math.floor(Math.random() * 30) + 60
    const lightness = Math.floor(Math.random() * 20) + 30

    return this.hslToHex(hue, saturation, lightness)
  }

  hslToHex(h, s, l) {
    s /= 100
    l /= 100

    const k = n => (n + h / 30) % 12
    const a = s * Math.min(l, 1 - l)
    const f = n => {
      const color = l - a * Math.max(-1, Math.min(k(n) - 3, Math.min(9 - k(n), 1)))
      return Math.round(255 * color).toString(16).padStart(2, '0')
    }

    return `#${f(0)}${f(8)}${f(4)}`
  }


}