$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "github_changelog"
  s.version     = '0.0.1'
  s.authors     = ["Yuri Mello"]
  s.email       = ["yuri.mello@sucurilabs.net"]
  s.homepage    = "https://github.com/sucurilabs/github_changelog"
  s.summary     = %q{Generate changlog by specific tag.}
  s.description = %q{Generate changlog by specific tag.}
  
  s.license = 'MIT'
  
  # s.rubyforge_project = "entityjs"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_development_dependency "jasmine"
  
  # s.add_dependency "sinatra"
end