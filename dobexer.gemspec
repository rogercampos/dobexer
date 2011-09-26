# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dobexer/version"

Gem::Specification.new do |s|
  s.name        = "dobexer"
  s.version     = Dobexer::VERSION
  s.authors     = ["Roger Campos"]
  s.email       = ["roger@itnig.net"]
  s.homepage    = ""
  s.summary     = %q{Integrates DelayedJob with Exception Notifier}
  s.description = %q{Integrates DelayedJob with Exception Notifier}

  s.rubyforge_project = "dobexer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "delayed_job", ">= 2.1.0"
  s.add_dependency "exception_notification", ">= 2.4.1"
  s.add_dependency "rails", "~> 3.0.0"
end
