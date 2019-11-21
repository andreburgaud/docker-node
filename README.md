# Node Docker Image

Docker image explosing Node as a REPL (Read-Eval-Print-Loop), ideal to play with JavaScript in a sandbox.

The repl is wrapped with `rlwrap` https://linux.die.net/man/1/rlwrap allowing for:
* Colored prompt
* Editing code with `vim` invoked with `CTRL`+`^` in the shell

# Usage

## Display Help

```
$ docker --rm -it andreburgaud/node help
Usage:
  docker run --rm -it andreburgaud/node [<options>] [<arguments]: starts Node
  docker run --rm -it andreburgaud/node [<command>] [<options>] [<arguments]:
  Commands
    shell [options] [arguments] : starts a Node shell with rlwrap
                                 (with all harmony features enabled)
    bash                        : starts a Bash shell
    help                        : displays this help
    version                     : displays Node.js version
```

## Start Regular Node Process

```
$ docker --rm -it andreburgaud/node
Welcome to Node.js v13.1.0.
Type ".help" for more information.
>
```

Without any parameters, it lauches the Node shell. To access files, like JavaScript files, you need to bind a [volume](https://docs.docker.com/storage/volumes/) when starting the container.

## Start a REPL with rlwrap

```
$ docker run --rm -it abnode shell
Options: --harmony --harmony-private-methods --harmony-regexp-sequence
--harmony-weak-refs --harmony-optional-chaining --harmony-nullish
--harmony-intl-dateformat-quarter --harmony-intl-add-calendar-numbering-system
--harmony-intl-dateformat-day-period
--harmony-intl-dateformat-fractional-second-digits
--harmony-intl-segmenter

Welcome to Node.js v13.1.0.
Type ".help" for more information.
>
```

[rlwrap](https://linux.die.net/man/1/rlwrap) enables:
* A colored prompt
* Editing code with vim

List of explicitely enabled harmony options when sarting with command `shell`:

* `--harmony`:                                          enable all completed harmony features
* `--harmony-private-methods`:                          enable "harmony private methods in class literals" (in progress)
* `--harmony-regexp-sequence`:                          enable "RegExp Unicode sequence properties" (in progress)
* `--harmony-weak-refs`:                                enable "harmony weak references" (in progress)
* `--harmony-optional-chaining`:                        enable "harmony optional chaining syntax" (in progress)
* `--harmony-nullish`:                                  enable "harmony nullish operator" (in progress)
* `--harmony-intl-dateformat-quarter`:                  enable "Add quarter option to DateTimeFormat" (in progress)
* `--harmony-intl-add-calendar-numbering-system`:       enable "Add calendar and numberingSystem to DateTimeFormat"
* `--harmony-intl-dateformat-day-period`:               enable "Add dayPeriod option to DateTimeFormat"
* `--harmony-intl-dateformat-fractional-second-digits`: enable "Add fractionalSecondDigits option to DateTimeFormat"
* `--harmony-intl-segmenter`:                           enable "Intl.Segmenter"

# Local Development

```
$ make build
$ make run
Welcome to Node.js v13.1.0.
Type ".help" for more information.
> console.log(`Node version ${process.version}`);
Node version v13.1.0
undefined
> .exit
$
```

# Resources

* https://nodejs.org
* https://nodejs.org/api/repl.html#repl_using_the_node_js_repl_with_advanced_line_editors
* https://linux.die.net/man/1/rlwrap
