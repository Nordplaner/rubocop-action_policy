# frozen_string_literal: true

require "rubocop-action_policy"
require "rubocop/cop/action_policy/application_policy"
require "rubocop/rspec/support"
Dir["#{Gem::Specification.find_by_name("rubocop-rails").gem_dir}/spec/support/**/*.rb"].sort.each do |file|
  require file
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ::RuboCop::RSpec::ExpectOffense
end
