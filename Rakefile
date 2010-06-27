desc "Run rspec tests everytime a file changes (depends on 'inotify-tools')"
task :rspec_loop do
  system %{while true; do inotifywait . -e modify -r -qq; spec -fn spec; echo ---------------------; done}
end
