# Node Docker Image

Docker image explosing Node as a REPL (Read-Eval-Print-Loop), ideal to play with JavaScript in a sandbox.

# Usage

## Install

The Docker image is created via an automated build and is hosted on DockerHub: https://hub.docker.com/r/andreburgaud/node.

To install it on your system, execute the following command:

```
$ docker pull andreburgaud/node
```

## Display Help

```
$ docker run --rm -it andreburgaud/node help
Usage:
  docker run --rm -it andreburgaud/node [<options>] [<arguments]: Node.js REPL
  docker run --rm -it andreburgaud/node [<command>] [<options>] [<arguments]:
  Commands
    shell [options] [arguments] : starts a Node shell with rlwrap
                                  (with all harmony features enabled)
    bash                        : starts a Bash shell
    help                        : displays this help
    version                     : displays Node.js version
```

## Start Node REPL

```
$ docker run --rm -it andreburgaud/node
Welcome to Node.js v13.10.1.
Type ".help" for more information.
> for (const[k, v] of Object.entries(process.versions)) { console.log(`${k} = ${v}`); }
node = 13.10.1
v8 = 7.9.317.25-node.29
uv = 1.34.2
zlib = 1.2.11
brotli = 1.0.7
ares = 1.15.0
modules = 79
nghttp2 = 1.40.0
napi = 5
llhttp = 2.0.4
openssl = 1.1.1d
cldr = 36.0
icu = 65.1
tz = 2019c
unicode = 12.1
undefined
> .help
.break    Sometimes you get stuck, this gets you out
.clear    Alias for .break
.editor   Enter editor mode
.exit     Exit the repl
.help     Print this help message
.load     Load JS from a file into the REPL session
.save     Save all evaluated commands in this REPL session to a file
> .exit
$
```

## Execute a JavaScript File

Without any parameters, it lauches the Node REPL. To access files, like JavaScript files, you need to bind a [volume](https://docs.docker.com/storage/volumes/) when starting the container. For example, with the file `js/hello.js` in the repo, execute the following:

```
$ docker run --rm -it -v`pwd`/js:/js andreburgaud/node /js/hello.js
Hello, world!
```

A `js` directory exists in the container. You map a volume from your local environment to this directory to execute any JavaScript files existing on your drive.

## Start Node with Harmony Options

To enable all `harmony` options, even those that are usually set to `false`, you can start the container with the command `harmony`:

```
$ docker --rm -it andreburgaud/node harmony
All harmony options turned on, including:
--harmony
--harmony-regexp-sequence
--harmony-weak-refs
--harmony-regexp-match-indices
--harmony-top-level-await
--harmony-optional-chaining
--harmony-nullish
--harmony-private-methods
--harmony-intl-add-calendar-numbering-system
--harmony-intl-dateformat-day-period
--harmony-intl-dateformat-fractional-second-digits
--harmony-intl-other-calendars
--harmony-intl-segmenter

Welcome to Node.js v13.10.1.
Type ".help" for more information.
> .exit
$
```

List of explicitely enabled harmony options when sarting the container:

* `--harmony`:                                          enable all completed harmony features
* `--harmony-regexp-sequence`:                          enable "RegExp Unicode sequence properties" (in progress)
* `--harmony-weak-refs`:                                enable "harmony weak references" (in progress)
* `--harmony-regexp-match-indices`:                     enable "harmony regexp match indices" (in progress))
* `--harmony-top-level-await`:                          enable "harmony top level await" (in progress)
* `--harmony-optional-chaining`:                        enable "harmony optional chaining syntax"
* `--harmony-nullish`:                                  enable "harmony nullish operator"
* `--harmony-private-methods`:                          enable "harmony private methods in class literals"
* `--harmony-intl-add-calendar-numbering-system`:       enable "Add calendar and numberingSystem to DateTimeFormat"
* `--harmony-intl-dateformat-day-period`:               enable "Add dayPeriod option to DateTimeFormat"
* `--harmony-intl-dateformat-fractional-second-digits`: enable "Add fractionalSecondDigits option to DateTimeFormat"
* `--harmony-intl-other-calendars`:                     enable "DateTimeFormat other calendars"
* `--harmony-intl-segmenter`:                           enable "Intl.Segmenter"

# Releases

## 13.10.1

* Removed `rlwrap` and `vim`, as the editor mode via `.editor` works well
* Moved to Alpine alpine 3.10
* Added an command `harmony` to explicitely start Node with harmony options that are turned off by default

## 13.1.0

* Initial release
* Debian Buster Slim
* `rlwrap` and `vim` used to help editing files in the Node REPL

# Resources

* https://nodejs.org
* https://hub.docker.com/_/node/
* https://alpinelinux.org/