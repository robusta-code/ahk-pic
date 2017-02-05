const chokidar = require('chokidar');
const electron = require('electron');
const Rx = require('rxjs');


/**********************************
 *  Create Electron window        *
 **********************************/

const {app, BrowserWindow} = electron;

app.on('ready', ()=> {
    let win = new BrowserWindow({width: 800, height: 800});
    win.loadURL(`file://${__dirname}/index.html`);
});

console.log(__dirname);


/**********************************
 *  watch Files                   *
 **********************************/
var watcher = chokidar.watch(__dirname+'/**/*.png', {
    //ignored: /(^|[\/\\])\../,
    //persistent: true
});
var watchedPaths = watcher.getWatched();
console.log('watched', watchedPaths);
/**
 * We observe the watcher :) When the watcher will find a
 * new file, the observable will notify observers
 */
var newFileSource = Rx.Observable.create(observer => {
    watcher.on("add", (path)=>{
        console.log('new file :', path);
        observer.next(path);
    });
});



// When close
app.on('window-all-closed', ()=> {
    console.log('quitting');
    watcher.close();
    app.quit();
});


// Will be listened by front.js
exports.watcher = watcher;
exports.newFileSource = newFileSource;