# OffersRouter is the backbone.js router for the demo
# Prefiat LLC for Klickpush

class OffersRouter extends Backbone.Router
  routes:
    "":     "initialPrompt"

  # Start here
  initialPrompt: ->
    ipc = new InitialPromptView(el: $('#content'))
    ipc.render()

(exports ? this).OffersRouter = OffersRouter

