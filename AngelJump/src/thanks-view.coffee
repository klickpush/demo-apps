# thanks-view.coffee
# Thanks the user for accepting the offer

class ThanksView extends Backbone.View
  events:
    'click .btn.getmore':   'getMoreClicked'

  render: ->
    template = $('#thanksViewTemplate').html()
    @$el.append(Mustache.to_html(template))

    this

  getMoreClicked: ->
    window.location.hash = "offer"

(exports ? this).ThanksView = ThanksView

