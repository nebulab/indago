require_relative 'lib/indago/version'

Gem::Specification.new do |spec|
  spec.name          = "indago"
  spec.version       = Indago::VERSION
  spec.authors       = ["Elia Schito", "Filippo Liverani"]
  spec.email         = ["eliaschito@nebulab.it", "filippoliverani@nebulab.it"]

  spec.summary       = %q{Lightweight drop-in Ransack replacement without the ActiveRecord hackery.}
  spec.homepage      = "https://github.com/nebulab/indago#readme"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nebulab/indago"
  spec.metadata["changelog_uri"] = "https://github.com/nebulab/indago/releases"
  spec.metadata["copyright"] = "Nebulab SRLs"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(File.expand_path('..', __FILE__)) { `git ls-files -z`.split("\x0") }

  spec.files         = files.reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
