/**
 * Animated search with opacity control
 */
export default class AnimatedSearch {
  constructor() {
    this.form = document.getElementById("form-search_topbar");
    this.input = this.form?.querySelector("input");
    
    if (this.form) {
      this.init();
    }
  }

  init() {
    this.form.addEventListener("click", () => {
      this.form.classList.add("search-active");
      if (this.input) {
        this.input.focus();
      }
    });

    document.addEventListener("click", (event) => {
      if (!this.form.contains(event.target)) {
        this.form.classList.remove("search-active");
      }
    });
  }
}
