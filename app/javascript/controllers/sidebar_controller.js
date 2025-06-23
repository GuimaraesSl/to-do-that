import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "toggle", "content", "icon"]

  connect() {
    this.isCollapsed = false
    this.update();
  }

  toggle() {
    this.isCollapsed = !this.isCollapsed;
    this.update();
  }

  update() {
    // Alternar largura do sidebar
    this.sidebarTarget.classList.toggle("w-64", !this.isCollapsed);
    this.sidebarTarget.classList.toggle("w-16", this.isCollapsed);

    // Esconder/mostrar conteúdo
    this.contentTarget.classList.toggle("hidden", this.isCollapsed);

    // Alternar ícone
    this.iconTarget.classList.toggle("fa-bars", this.isCollapsed);
    this.iconTarget.classList.toggle("fa-arrow-left", !this.isCollapsed);

    // Atualizar aria-expanded
    this.toggleTarget.setAttribute("aria-expanded", !this.isCollapsed);

    // Ajustar margem do main
    const main = document.querySelector("#main-content");
    if (main) {
      main.classList.toggle("ml-64", !this.isCollapsed);
      main.classList.toggle("ml-16", this.isCollapsed);
    }
  }
}