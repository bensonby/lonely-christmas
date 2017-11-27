# Lonely Christmas (Jazz) for Female voice

## Requirements

- Lilypond version 2.18.2+ (for creating pdf score and midi)
- Timidity (for creating mp3 file)

## Compile

- lilypond LonelyChristmas.ly
- timidity --output-24bit -Ow LonelyChristmas.midi # create wav
- ffmpeg -i LonelyChristmas.wav LonelyChristmas.mp3 # create mp3
