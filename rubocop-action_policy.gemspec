# frozen_string_literal: true

require_relative "lib/rubocop/action_policy/version"

Gem::Specification.new do |spec|
  spec.name = "rubocop-action_policy"
  spec.version = Rubocop::ActionPolicy::Version::STRING
  spec.authors = ["Thorsten Kohpeiss"]
  spec.email = ["thk@nordplaner.dk"]

  spec.summary = "Automatic ActionPolicy code style checking tool."
  spec.homepage = "https://github.com/Nordplaner/rubocop-action_policy"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rubocop"
  spec.add_runtime_dependency "rubocop-rails"
  spec.add_runtime_dependency "rubocop-rspec"
end
