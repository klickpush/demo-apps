# View that asks the user to generate an offer initially
# Prefiat LLC for Klickpush

that = null   # Kind of a dumb hack, clean up later
              # Can't control execution context on postMessage handler

class InitialPromptView extends Backbone.View
  events:
    'click .btn.generate':    'generateClicked'
    'click .btn.claim':       'claimClicked'

  initialize: ->
    window.addEventListener("message", @messageDispatcher, false)
    that = this

  render: ->
    template  = $("#initialPromptTemplate").html()
    @$el.addClass('center').append(Mustache.to_html(template))

    this

  # Event handlers
  messageDispatcher: (event) ->
    # TODO: ADD SECURITY CHECKS HERE
    # event.data contains our offer

    switch event.data.type
      when 'initComplete'
        that.requestOffer()
      when 'singleOfferRequestComplete'
        that.singleOfferResponseHandler(event.data.response)

  generateClicked: ->
    console.log("Generate called")
    
    # Configure the library
    $('#apiframe')[0].contentWindow.postMessage
      type:                   'init'
      oauthConsumerKey:       'demo'
      oauthConsumerSecret:    'demo-secret'
      oauthAccessTokenKey:    'demo-access-token'
      oauthAccessTokenSecret: 'demo-access-token-secret'
    , "http://api.klickpush.com"

  requestOffer: ->
    # Send a message to the iframe handler requesting an offer
    # Pass a callback that renders the offer when we return
    $('#apiframe')[0].contentWindow.postMessage(type: "singleOfferRequest", genre: "rock",
      "http://api.klickpush.com")

  claimClicked: ->
    console.log("Claim called")

  # Action methods
  singleOfferResponseHandler: (singleArray) ->
    if singleArray.length > 0
      artist  = singleArray[0].artist_name
      song    = singleArray[0].track.track_name
      artUrl  = singleArray[0].artwork

      virtualGood = @getRandomVirtualGood()

      @$el.children('.offer_text').empty().html("Purchase the #{virtualGood['name']} and " +
        "get #{song} by #{artist} for free")
      @$el.children('.vgood_offer').empty().html("<img src='virtual_good_images/#{virtualGood["path"]}' />")
      @$el.children('.song_offer').empty().html("<img src='#{artUrl}' />")
    else
      console.log("Empty response from server")


  getRandomVirtualGood: (goodIndex) ->
    goods = [ { name: "bomb", path: "bomb.png"  },
      { name: "gold suit",      path: "gold-suit.png"     },
      { name: "scepter",        path: "septor.png"        },
      { name: "fast forward",   path: "fast-forward.png"  },
      { name: "kingly crown",   path: "kingly-crown.png"  }
      { name: "shark jetpack",  path: "shark-jetpack.png" },
      { name: "gold stomper",   path: "gold-stomper.png"  },
      { name: "revive",         path: "revive.png"        } ]

    goodIndex = Math.floor(Math.random() * goods.length)

    goods[goodIndex]

(exports ? this).InitialPromptView = InitialPromptView
