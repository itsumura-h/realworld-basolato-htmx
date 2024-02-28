# Package
version       = "0.1.0"
author        = "Anonymous"
description   = "A new awesome basolato package"
license       = "MIT"
srcDir        = "."
bin           = @["main"]
backend       = "c"
# Dependencies
requires "nim >= 2.0.2"
# requires "https://github.com/itsumura-h/nim-basolato == 0.15.0"
# requires "https://github.com/itsumura-h/nim-basolato#head"
requires "https://github.com/itsumura-h/nim-basolato#9a97e43"
# requires "allographer == 0.29.1"
requires "allographer#head"
requires "interface_implements >= 0.2.4"
requires "bcrypt >= 0.2.1"
requires "cligen >= 1.5.9"
requires "faker >= 0.14.0"
requires "redis >= 0.3.0"
requires "sass >= 0.1.0"
requires "jwt >= 0.2"

task test, "run testament":
  echo staticExec("testament p \"./tests/test_*.nim\"")
  discard staticExec("find tests/ -type f ! -name \"*.*\" -delete 2> /dev/null")
