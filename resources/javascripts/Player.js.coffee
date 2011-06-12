class Player
  play: (song) ->
    @currentlyPlayingSong = song
    @isPlaying = true

  pause: ->
    @isPlaying = false

  resume: ->
    throw new Error("song is already playing") if @isPlaying
    @isPlaying = true

  makeFavorite: ->
    @currentlyPlayingSong.persistFavoriteStatus(true)
