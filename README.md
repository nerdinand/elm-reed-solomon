# elm-reed-solomon
This is a wrapper around [erc-js](https://github.com/louismullie/erc-js) using Elm ports.

This is a prerequisite for my other project, [a QR code library written in Elm](https://github.com/nerdinand/elm-qr-code).

## Usage

There's a little demo app bundled with this project. To compile, run:

```
elm-make src/ReedSolomon/**/*.elm --output=lib/ReedSolomon.js
```

Then open `index.html` with your browser.
