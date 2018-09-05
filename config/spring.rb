%w[
  .ruby-version
  .rbenv-vars
  config/projects.yml
  tmp/restart.txt
  tmp/caching-dev.txt
].each { |path| Spring.watch(path) }
