# OffersRouter is the backbone.js router for the demo
# Prefiat LLC for Klickpush

class OffersRouter extends Backbone.Router
  initialize: ->
    @offerModel = new OfferModel()

  routes:
    "":       "default"
    "offer":  "offer"
    "claim":  "claim"

  default: ->
    window.location.hash = "offer"

  # Start here
  offer: ->
    $('#content').empty()

    ipc = new InitialPromptView(el: $('#content'), model: @offerModel)
    ipc.render()

  claim: ->
    $('#content').empty()

    claimView = new ClaimView(el: $('#content'), model: @offerModel)
    claimView.render()

(exports ? this).OffersRouter = OffersRouter

