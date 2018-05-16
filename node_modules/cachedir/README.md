# node-cachedir

Provides a directory where the OS wants you to store cached files.

## Installation

```sh
npm install cachedir
```

## Usage

```javascript
var cachedir = require('cachedir')
var path = cachedir('linusu')

// `path` now contains the path under which you should store cached files
```
