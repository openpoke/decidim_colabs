export default class AnimatedSearch {
  constructor() {
    this.form = document.getElementById("form-search_topbar");
    this.input = this.form?.querySelector("#input-search");
    this.searchButton = this.form?.querySelector('button[type="submit"]');
    this.menuLinks = document.querySelectorAll(".menu-link");
    this.isSearchActive = false;
    
    if (this.form && this.searchButton && this.input) {
      this.init();
    }
  }

  init() {
    this.searchButton.addEventListener("click", this.handleSearchClick.bind(this));
    document.addEventListener("click", this.handleDocumentClick.bind(this));
    this.form.addEventListener("click", (event) => event.stopPropagation());
  }

  handleSearchClick(event) {
    event.preventDefault();
    event.stopPropagation();
    this.toggleSearch();
  }

  handleDocumentClick(event) {
    if (!this.form.contains(event.target)) {
      this.hideSearch();
    }
  }

  toggleSearch() {
    this.isSearchActive ? this.form.submit() : this.showSearch();
  }

  showSearch() {
    this.isSearchActive = true;
    this.form.classList.add("search-active");
    this.menuLinks.forEach(link => link.style.display = "none");
    this.input.focus();
  }

  hideSearch() {
    this.isSearchActive = false;
    this.form.classList.remove("search-active");
    this.menuLinks.forEach(link => link.style.display = "inline");
  }
}
