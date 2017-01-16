{exec} = require "child_process"

start = () ->
  task = exec "git commit -a -m 'Precompile f2e assets.'"
  task.stdout.on "data", (data) -> console.log data.toString()
  task.stderr.on "data", (data) -> console.log data.toString()

start()
