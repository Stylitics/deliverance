# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deliverance/version"

Gem::Specification.new do |s|
  s.name        = "deliverance"
  s.version     = Deliverance::VERSION
  s.authors     = ["Jeremy Raines"]
  s.email       = ["jraines@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{server for Heroku post-deploy webhook to deliver Pivotal Tracker stories}
  s.description = %q{server for Heroku post-deploy webhook to deliver Pivotal Tracker stories}

  s.rubyforge_project = "deliverance"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rack-test"
  s.add_runtime_dependency "sinatra"
  s.add_runtime_dependency "rest-client"
end
