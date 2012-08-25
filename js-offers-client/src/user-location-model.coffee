# user-location-model.coffee
# Keeps track of the user's location

class UserLocationModel extends Backbone.Model
  initialize: ->
    @userHasDenied = false

  # Try to get the location; abort if we've been denied permission, or browser lacks support
  getLocation: (callback) ->
    if @browserSupport() and @havePermission() and @hasLocation() == false
      geolocationCallback = (position) =>
        @set('latitude',  position.coords.latitude)
        @set('longitude', position.coords.longitude)

        callback()

      navigator.geolocation.getCurrentPosition(geolocationCallback)

  # Check whether the browser supports location queries
  browserSupport: ->
    if navigator.geolocation then true else false

  # have permission until user explicitly denies
  havePermission: ->
    if @userHasDenied then false else true

  # Check whether we have a location
  hasLocation: ->
    if @get('latitude') and @get('longitude') then true else false

(exports ? this).UserLocationModel = UserLocationModel

