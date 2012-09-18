# View that asks the user to generate an offer initially
# Prefiat LLC for Klickpush

that = null   # Kind of a dumb hack, clean up later
              # Can't control execution context on postMessage handler

class InitialPromptView extends Backbone.View
  events:
    'click .btn.claim':       'claimClicked'

  initialize: (params) ->
    that = this

    @offerModel         = params.offerModel
    @virtualGoodModel   = params.virtualGoodModel
    @userLocationModel  = params.userLocationModel

    window.addEventListener("message", @messageDispatcher, false)

    # Configure the library
    $('#apiframe')[0].contentWindow.postMessage
      type:                   'init'
      oauthConsumerKey:       'mOXeIFqH27ynJcq68WSYbIDabno4clNnWgwS3WXA'
      oauthConsumerSecret:    'miGEx9kJjMA2UOtwjR0Qay9zrANuSYC1gCJO15HO'
      oauthAccessTokenKey:    'EYolXAeRIRMcjeyXr4Ha634vq9aiZIshlpZHY7NN'
      oauthAccessTokenSecret: '3wvZJxVCsuZqd4a6yRpLHj7VmEImULrKA0yjE9C5'
    , "http://api.klickpush.com"

    this

  render: ->
    @userLocationModel.getLocation =>
      template  = $("#gettingOfferTemplate").html()
      @$el.append(Mustache.to_html(template))
      console.log("latitude: #{@userLocationModel.get('latitude')}, longitude: #{@userLocationModel.get('longitude')}")

    this

  # Event handlers
  messageDispatcher: (event) ->
    #if(event.origin == "http://api.klickpush.com")     # Don't want any cross-domain tomfoolery
    switch event.data.type
      when 'initComplete'
        that.requestOffer()
      when 'singleOfferRequestComplete'
        that.singleOfferResponseHandler(event.data.response)

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
      @$el.empty()
      template  = $("#initialPromptTemplate").html()
      @$el.append(Mustache.to_html(template))

      # Should factor more view logic into offer model
      @offerModel.set(singleArray[0])
      @getRandomVirtualGood()

      @$el.children('.offer_text').empty().html("Purchase the " +
        "#{@virtualGoodModel.get('name')} and " +
        "get #{@offerModel.get('track').track_name} by " +
        "#{@offerModel.get('artist_name')} for free")
      @$el.children('.vgood_offer').empty().html(
        "<img src='virtual_good_images/#{@virtualGoodModel.get('path')}' />")
      @$el.children('.song_offer').empty().html("<img src='#{@offerModel.get('artwork')}' />")
      @$el.children('.song_player').empty().html("<audio controls='controls' style='margin-top:10px;'>" +
        "<source src='#{@offerModel.get('track').urls.preview}' type='audio/mpeg'></audio>")
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
    @virtualGoodModel.set(goods[goodIndex])

(exports ? this).InitialPromptView = InitialPromptView
