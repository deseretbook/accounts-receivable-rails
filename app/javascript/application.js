// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"

document.addEventListener("turbo:load", () => {
  console.log("Javascript working!")
})
