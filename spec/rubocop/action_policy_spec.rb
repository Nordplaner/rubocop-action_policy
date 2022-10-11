# frozen_string_literal: true

RSpec.describe Rubocop::ActionPolicy do
  it "has a version number" do
    expect(Rubocop::ActionPolicy::Version::STRING).not_to be nil
  end
end
