beforeEach ->
  @addMatchers
    toBePlaying: (expectedSong) ->
      @actual.currentlyPlayingSong == expectedSong && @actual.isPlaying
