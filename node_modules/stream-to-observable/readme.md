# stream-to-observable [![Build Status](https://travis-ci.org/jamestalmage/stream-to-observable.svg?branch=master)](https://travis-ci.org/jamestalmage/stream-to-observable) [![Coverage Status](https://coveralls.io/repos/github/jamestalmage/stream-to-observable/badge.svg?branch=master)](https://coveralls.io/github/jamestalmage/stream-to-observable?branch=master)

> Convert Node Streams into ECMAScript-Observables

[`Observables`](https://github.com/zenparsing/es-observable) are rapidly gaining popularity. They have much in common with Streams, in that they both represent data that arrives over time. Most Observable implementations provide expressive methods for filtering and mutating incoming data. Methods like `.map()`, `.filter()`, and `.forEach` behave very similarly to their Array counterparts, so using Observables can be very intuitive.

[Learn more about Observables](#learn-about-observables)

## Install

```
$ npm install --save stream-to-observable

# You also need to install an Observable implementation (pick one):

$ npm install --save zen-observable rxjs

```


## Usage

```js
const fs = require('fs');
const split = require('split');

// You provide the Observable implmentation
const Observable = require('zen-observable')
const streamToObservable = require('stream-to-observable')(Observable);

const readStream = fs
  .createReadStream('./hello-world.txt', {encoding: 'utf8'})
  .pipe(split()); // chunks a stream into individual lines

streamToObservable(readStream)
  .filter(chunk => /hello/i.test(chunk))
  .map(chunk => chunk.toUpperCase())
  .forEach(chunk => {
    console.log(chunk); // only the lines containing "hello" - and they will be capitalized
  });
```

There are convenience imports for [`rxjs` observables](http://reactivex.io/rxjs/class/es6/Observable.js~Observable.html) and [`zen-observables`](https://github.com/zenparsing/zen-observable):

```js
const streamToObservable = require('stream-to-observable/zen'); // zen-observables
// or
const streamToObservable = require('stream-to-observable/rxjs-all'); // full rxjs implementation
// or
const streamToObservable = require('stream-to-observable/rxjs'); // minimal rxjs implementation
// you can patch the minimal rxjs.
require('rxjs/add/operator/map');
```

None of the above implementations are included as dependencies of this package, so you still need to install them yourself using `npm install`. If using the minimal `rxjs` import, be sure to see [the documentation](http://reactivex.io/rxjs/manual/installation.html) regarding patching it with additional convenience methods.


## API

### streamToObservable(stream, [options])

#### stream

Type: [`ReadableStream`](https://nodejs.org/api/stream.html#stream_class_stream_readable)

*Note:*
`stream` can technically be any [`EventEmitter`](https://nodejs.org/api/events.html#events_class_eventemitter) instance. By default the `stream-to-observable` listens to the standard Stream events (`data`, `error`, and `end`), but those are configurable via the `options` parameter. If you are using this with a standard Stream, you likely won't need the `options` parameter.

#### options

##### await

Type: `Promies`<br>

If provided, the Observable will not "complete" until `await` is resolved. If `await` is rejected, the Observable will immediately emit an `error` event and disconnect from the stream. This is mostly useful when attaching to the `stdin` or `stdout` streams of a  [`child_process`](https://nodejs.org/api/child_process.html#child_process_child_stdio). Those streams usually do not emit `error` events, even if the underlying process exits with an error. This provides a means to reject the Observable if the child process exits with an unexpected error code.

##### endEvent

Type: `String` or `false` <br>
Default: `"end"`

If you are using an `EventEmitter` or non-standard Stream, you can change which event signals that the Observable should be completed.

Setting this to `false` will avoid listening for any end events.

Setting this to `false` and providing an `await` Promise will cause the Observable to resolve immediately with the `await` Promise (the Observable will remove all it's `data` event listeners from the stream once the Promise is resolved).

##### errorEvent

Type: `String` or `false` <br>
Default: `"error"`

If you are using an `EventEmitter` or non-standard Stream, you can change which event signals that the Observable should be closed with an error.

Setting this to `false` will avoid listening for any error events.

##### dataEvent

Type: `String`<br>
Default: `"data"`

If you are using an `EventEmitter` or non-standard Stream, you can change which event causes data to be emitted to the Observable.

## Learn about Observables

 - Overview: https://github.com/zenparsing/es-observable
 - Formal Spec: https://zenparsing.github.io/es-observable/
 - [egghead.io lesson](https://egghead.io/lessons/javascript-introducing-the-observable) - Video
 - [`rxjs` observables](http://reactivex.io/rxjs/class/es6/Observable.js~Observable.html) - Observables Implementation
 - [`zen-observables`](https://github.com/zenparsing/zen-observable) - Observables Implementation

## Transform Streams

`data` events on the stream will be emitted as events in the Observable. Since most native streams emit `chunks` of binary data, you will likely want to use a `TransformStream` to convert those chunks of binary data into an object stream. [`split`](https://github.com/dominictarr/split) is just one popular TransformStream that splits streams into individual lines of text.

## Caveats

It is important Note that using this module disables back-pressure controls on the stream. As such it should not be used where back-pressure throttling is required (i.e. high volume web servers). It still has value for larger projects, as it can make unit testing streams much cleaner.

## License

MIT © [James Talmage](http://github.com/jamestalmage)
