import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["content", "expandButton", "collapseButton"]

    connect() {
        this.checkTruncation()
    }

    checkTruncation() {
        // Determine if the content is actually truncated
        const isTruncated = this.contentTarget.scrollHeight > this.contentTarget.clientHeight

        if (isTruncated) {
            this.expandButtonTarget.classList.remove("hidden")
            this.collapseButtonTarget.classList.add("hidden")
        } else {
            this.expandButtonTarget.classList.add("hidden")
            this.collapseButtonTarget.classList.add("hidden")
        }
    }

    expand(event) {
        event.preventDefault()
        this.contentTarget.classList.remove("line-clamp-3")
        this.expandButtonTarget.classList.add("hidden")
        this.collapseButtonTarget.classList.remove("hidden")
    }

    collapse(event) {
        event.preventDefault()
        this.contentTarget.classList.add("line-clamp-3")
        this.expandButtonTarget.classList.remove("hidden")
        this.collapseButtonTarget.classList.add("hidden")
    }
}
