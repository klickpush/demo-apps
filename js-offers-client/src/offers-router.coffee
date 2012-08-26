# OffersRouter is the backbone.js router for the demo
# Prefiat LLC for Klickpush

class OffersRouter extends Backbone.Router
  initialize: ->
    @offerModel         = new OfferModel()
    @virtualGoodModel   = new VirtualGoodModel()
    @userLocationModel  = new UserLocationModel()

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
    offerDiv = $('#content').append($('<div>').attr('id', 'offer'))

    ipv = new InitialPromptView
      el:                 $('#offer'),
      offerModel:         @offerModel,
      virtualGoodModel:   @virtualGoodModel
      userLocationModel:  @userLocationModel
    ipv.render()

  claim: ->
    $('#content').empty()
    claimDiv = $('#content').append($('<div>').attr('id', 'claim'))

    claimView = new ClaimView
      el:                 $('#claim'),
      offerModel:         @offerModel,
      virtualGoodModel:   @virtualGoodModel
      userLocationModel:  @userLocationModel
    claimView.render()

  thanks: ->
    $('#content').empty()
    thanksDiv = $('#content').append($('<div>').attr('id', 'thanks'))

    thanksView = new ThanksView(el: $('#thanks'))
    thanksView.render()

(exports ? this).OffersRouter = OffersRouter

