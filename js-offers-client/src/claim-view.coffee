# claim-view.coffee lets the user "claim" the offer
# Prefiat LLC for Klickpush

class ClaimView extends Backbone.View
  events:
    'click .btn.cancel':    'cancelClicked'

  render: ->
    templateData =
      singleImgSrc:   @model.get('artwork')
      singleImgName:  @model.get('artist')

    template = $('#claimViewTemplate').html()
    @$el.append(Mustache.to_html(template, templateData))

    this

  cancelClicked: ->
    window.location.hash = "offer"

(exports ? this).ClaimView = ClaimView
