Tesseract files stream
======

* Install nodejs wich includes npm
* Type `npm install` in project directory
* `npm run start` launch an Electron application that detect new files
    - while started, create a png file in `electron/captures` folder
* `npm run tesseract` launches a first test of tesseract ocr
    - it will first download `eng.traineddata.gz`file


Starting with Electron
=====

https://www.youtube.com/watch?v=jKzBJAowmGg

The interesting feature is about communications between main.js and index.js


File Watching:
===

### Watch files with chokidar

https://github.com/paulmillr/chokidar
https://davidwalsh.name/node-watch-file

Unfortunately, it's not that easy to watch any folder. I have opened an issue 
(https://github.com/paulmillr/chokidar/issues/576) 

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





