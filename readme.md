# urequire-rc-import-keys

## Introduction

[uRequire](http://urequire.org) [ResourceConverter](http://urequire.org/resourceconverters.coffee) that imports a module's *exported keys* as *variables* in all other modules.

The module whose keys are imported can both be part of your bundle (eg `models/Person') or a local dependency (eg `lodash`).

## Install

You 'll need uRequire >= '0.7.0' in your project, then:

```
$ npm install urequire-rc-import-keys --save
```

## Usage

Assume the module defined in `'helpers/specHelpers.js'` exports some keys, eg:

```javascript
    module.exports = {
        equals: function(a, b){..}
        deepEquals: function(a, b){..}
        notEquals: function(a, b){..}
        someProp: 'yeah'
    }
```

and is available in your modules either manually (i.e `var spH = require('../helpers/specHelpers')`) or declaratively in your uRequire config, eg

```
  dependencies: imports : 'helpers/specHelpers': 'spH'
```

and you just want to **import** some of its **exported keys** (eg `equals`, `someProp` etc) as **local variables** to all other modules, without having to :

```
    var equals = spH.equals, deepEquals = spH.deepEquals, someProp = spH.someProp;
```

in each module, then you should use this :


```
    [ 'import-keys', {
        'helpers/specHelpers': ['equals', 'deepEquals', 'someProp']
       }]
```

that looks up and loads the urequire-rc-`import-keys` RC and passes the options `{}` which has:

    * each *module* you want to import from, eg `'helpers/specHelpers'`

    * the names of the exported keys (and corresponding local variables) you want to import.

The variables will be imported to all bundle modules, except the one exporting (if its part of your bundle).

## Different variable names

If you want to change the name of the variables in the importing modules, for example use `eq` instead of `equals`, the use this syntax:

```
    [ 'import-keys', {
        'helpers/specHelpers': [ ['equals', 'eq'], 'deepEquals', 'someProp'] } ]
```

or the equivalent **(but more verbose cause you need corresponding variable for all keys, unless you're in coffee-script :-)** :

```
    [ 'import-keys', {
        'helpers/specHelpers': {
            equals:'eq',
            deepEquals: 'deepEquals',
            someProp: 'someProp' } } ];
```

## Controlling which modules have these imports

If you want to control which modules get the imported vars, use the `filez` RC lookup syntax :

    [ 'import-keys', ['only/these/modules/*'],
        {'helpers/specHelpers': [ 'equals', 'deepEquals', 'someProp'] } ]

## License

The MIT License

Copyright (c) 2014 Agelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
