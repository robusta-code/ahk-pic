const remote = require('electron').remote;
const main = remote.require('./main.js')
const newFileSource = main.newFileSource;

console.log('hello from front');


console.log('newFileSource', newFileSource);

var fileSubscription = newFileSource.subscribe(
    (path)=>{
        console.log('I have seen a new path');
        alert('new file :'+ path);
    }
);

