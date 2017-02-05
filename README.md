Tesseract files stream
======

* Clone from github
* `cd tesseract-stream`
* Install nodejs wich includes npm
* Type `npm install`





Starting with Electron
=====

https://www.youtube.com/watch?v=jKzBJAowmGg

The interesting feature is about communications between main.js and index.js


File Watching:
===

### Watch files with chokidar

https://github.com/paulmillr/chokidar
https://davidwalsh.name/node-watch-file


### RxJS subscription

We will pull file changes and contents into streams.


        var newFileSource = Rx.Observable.create(observer => {
            console.log('observer', observer);
            watcher.on("add", (path)=>{
                console.log('new file :', path);
                observer.next(path);
            });
        });
        
        
        var fileSubscription = newFileSource.subscribe(
            (path)=>{
                console.log('I have seen a new path');
                alert('new file :'+ path);
            }
        );





