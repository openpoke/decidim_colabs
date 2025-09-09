/**
 * Animated search with opacity control
 */
export default class AnimatedSearch {
  constructor() {
    this.form = document.getElementById("form-search_topbar");
    this.input = this.form?.querySelector("#input-search");
    this.searchButton = this.form?.querySelector('button[type="submit"][aria-label="Search"]');
    this.menuWrapper = document.querySelector(".main-bar__links-desktop__item-wrapper");
    this.isSearchActive = false;
    
    if (this.form && this.searchButton && this.input) {
      this.init();
    }
  }

  init() {
    this.searchButton.addEventListener("click", (event) => {
      event.preventDefault();
      event.stopPropagation();
      this.toggleSearch();
    });

    document.addEventListener("click", (event) => {
      if (!this.form.contains(event.target)) {
        this.hideSearch();
      }
    });

    this.form.addEventListener("click", (event) => {
      event.stopPropagation();
    });
  }

  toggleSearch() {
    if (this.isSearchActive) {
      this.form.submit();
    } else {
      this.showSearch();
    }
  }

  showSearch() {
    this.isSearchActive = true;
    this.form.classList.add("search-active");
    if (this.menuWrapper) {
      this.menuWrapper.style.display = "none";
    }
    this.input.focus();
  }

  hideSearch() {
    this.isSearchActive = false;
    this.form.classList.remove("search-active");
    if (this.menuWrapper) {
      this.menuWrapper.style.display = "block";
    }
  }
}
