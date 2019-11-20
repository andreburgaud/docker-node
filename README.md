# Node Docker Image

Docker image explosing Node as a REPL (Read-Eval-Print-Loop), ideal to play with JavaScript in a sandbox.

The repl is wrapped with `rlwrap` https://linux.die.net/man/1/rlwrap allowing for:
* Colored prompt
* Editing code with `vim` invoke with `CTRL`+`^` in the shell

# Usage

```
$ docker --rm -it andreburgaud/node
Welcome to Node.js v13.1.0.
Type ".help" for more information.
>
```

# Local Development

```
$ make build
$ docker run --rm -it andreburgaud/node
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
