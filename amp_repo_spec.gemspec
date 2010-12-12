# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "amp_repo_spec/version"

Gem::Specification.new do |s|
  s.name        = "amp_repo_spec"
  s.version     = AmpRepoSpec::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Love"]
  s.email       = ["git@JustinLove.name"]
  s.homepage    = "http://wondible.com"
  s.summary     = %q{Generic spec for Amp repos}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "amp_repo_spec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('rspec', '>= 2.0.0')
end
