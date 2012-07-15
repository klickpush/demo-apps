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
    @$el.append(Mustache.to_html(template))

    this

  # Event handlers
  messageDispatcher: (event) ->
    if(event.origin == "http://api.klickpush.com")     # Don't want any cross-domain tomfoolery
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
    # Navigate to claim view
    window.location.hash = "claim"

  # Action methods
  singleOfferResponseHandler: (singleArray) ->
    if singleArray.length > 0
      # Should factor more view logic into offer model
      @model.set(singleArray[0])
      virtualGood = @getRandomVirtualGood()

      @$el.children('.offer_text').empty().html("Purchase the #{virtualGood['name']} and " +
        "get #{@model.get('track').track_name} by #{@model.get('artist')} for free")
      @$el.children('.vgood_offer').empty().html("<img src='virtual_good_images/#{virtualGood["path"]}' />")
      @$el.children('.song_offer').empty().html("<img src='#{@model.get('artwork')}' />")
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
