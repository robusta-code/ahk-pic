var Tesseract = require('tesseract.js')

console.log('dir:', __dirname);
const myImage = __dirname + "/capture.png";


Tesseract.recognize(myImage, {
        lang: 'eng'
    })
    .progress(message => console.log(message))
    .then(function (result) {
        console.log(result.text)
    })
    .catch(function (result) {
        console.log(result)
    })