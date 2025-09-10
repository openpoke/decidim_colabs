// This file is compiled inside Decidim core pack. Code can be added here and will be executed
// as part of that pack

// Load images
require.context("../../images", true)

import AnimatedSearch from "./animated_search";

document.addEventListener("DOMContentLoaded", () => {
  if (document.getElementById("form-search_topbar")) {
    new AnimatedSearch();
  }
});
