# claim-view.coffee lets the user "claim" the offer
# Prefiat LLC for Klickpush

class ClaimView extends Backbone.View
  initialize: (params) ->
    @offerModel         = params.offerModel
    @virtualGoodModel   = params.virtualGoodModel
    @userLocationModel  = params.userLocationModel
 
  events:
    'click .btn.cancel':    'cancelClicked'
    'click .btn.submit':    'submitClicked'

  render: ->
    templateData =
      singleImgSrc:   @offerModel.get('artwork')
      singleImgName:  @offerModel.get('artist_name')
      vgoodImgSrc:    @virtualGoodModel.get('path')
      vgoodName:      @virtualGoodModel.get('name')

    template = $('#claimViewTemplate').html()
    @$el.append(Mustache.to_html(template, templateData))

    this

  cancelClicked: ->
    window.location.hash = "offer"

  submitClicked: ->
    $('#apiframe')[0].contentWindow.postMessage
      type:       'offerAcceptance'
      track_id:   @offerModel.get('track').id
      recipient:  $('#email_address').val()
      latitude:   @userLocationModel.get('latitude')
      longitude:  @userLocationModel.get('longitude')
    , "http://api.klickpush.com"

    window.location.hash = "thanks"

(exports ? this).ClaimView = ClaimView
