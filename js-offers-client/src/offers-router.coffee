# OffersRouter is the backbone.js router for the demo
# Prefiat LLC for Klickpush

class OffersRouter extends Backbone.Router
  initialize: ->
    @offerModel       = new OfferModel()
    @virtualGoodModel = new VirtualGoodModel()

  routes:
    "":       "default"
    "offer":  "offer"
    "claim":  "claim"
    "thanks": "thanks"

  default: ->
    window.location.hash = "offer"

  # Start here
  offer: ->
    $('#content').empty()

    ipv = new InitialPromptView
      el: $('#content'),
      offerModel: @offerModel,
      virtualGoodModel: @virtualGoodModel
    ipv.render()

  claim: ->
    $('#content').empty()

    claimView = new ClaimView
      el: $('#content'),
      offerModel: @offerModel,
      virtualGoodModel: @virtualGoodModel
    claimView.render()

  thanks: ->
    $('#content').empty()

    thanksView = new ThanksView(el: $('#content'))
    thanksView.render()

(exports ? this).OffersRouter = OffersRouter

