# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-vipercontrol"
  s.version     = "0.0.1" 
  s.authors     = ["fiquett"]
  s.email       = [""]
  s.homepage    = "http://fiquett.com"
  s.summary     = %q{Viper SmartStart Control Plugin}
  s.description = %q{This plugin accepts commands and send them to car via Viper SmartStart network}

  s.rubyforge_project = "siriproxy-vipercontrol"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "json"
end
