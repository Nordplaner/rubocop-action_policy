# frozen_string_literal: true

RSpec.describe Rubocop::Cop::ActionPolicy::ApplicationPolicy do
  let(:cop) do
    described_class.new
  end

  it "allows `ApplicationPolicy` to be defined" do
    expect_no_offenses(<<~RUBY)
      class ApplicationPolicy < ActionPolicy::Base; end
    RUBY
  end

  it "allows `ApplicationPolicy` to be defined using Class.new" do
    expect_no_offenses(<<~RUBY)
      ApplicationPolicy = Class.new(ActionPolicy::Base)
    RUBY
  end

  it "corrects controllers that subclass `ActionPolicy::Base`" do
    expect_offense(<<~RUBY)
      class MyPolicy < ActionPolicy::Base; end
                       ^^^^^^^^^^^^^^^^^^ Policies should subclass `ApplicationPolicy`.
    RUBY

    expect_correction(<<~RUBY)
      class MyPolicy < ApplicationPolicy; end
    RUBY
  end

  it "corrects controllers defined in module namespaces" do
    expect_offense(<<~RUBY)
      module Nested
        class MyPolicy < ActionPolicy::Base; end
                         ^^^^^^^^^^^^^^^^^^ Policies should subclass `ApplicationPolicy`.
      end
    RUBY

    expect_correction(<<~RUBY)
      module Nested
        class MyPolicy < ApplicationPolicy; end
      end
    RUBY
  end

  it "corrects controllers defined in inline namespaces" do
    expect_offense(<<~RUBY)
      class Nested::MyPolicy < ActionPolicy::Base; end
                               ^^^^^^^^^^^^^^^^^^ Policies should subclass `ApplicationPolicy`.
    RUBY

    expect_correction(<<~RUBY)
      class Nested::MyPolicy < ApplicationPolicy; end
    RUBY
  end

  it "corrects controllers defined using Class.new" do
    expect_offense(<<~RUBY)
      MyPolicy = Class.new(ActionPolicy::Base)
                           ^^^^^^^^^^^^^^^^^^ Policies should subclass `ApplicationPolicy`.
    RUBY

    expect_correction(<<~RUBY)
      MyPolicy = Class.new(ApplicationPolicy)
    RUBY
  end

  it "corrects nested controllers defined using Class.new" do
    expect_offense(<<~RUBY)
      Nested::MyPolicy = Class.new(ActionPolicy::Base)
                                   ^^^^^^^^^^^^^^^^^^ Policies should subclass `ApplicationPolicy`.
    RUBY

    expect_correction(<<~RUBY)
      Nested::MyPolicy = Class.new(ApplicationPolicy)
    RUBY
  end

  it "corrects anonymous controllers" do
    expect_offense(<<~RUBY)
      Class.new(ActionPolicy::Base) {}
                ^^^^^^^^^^^^^^^^^^ Policies should subclass `ApplicationPolicy`.
    RUBY

    expect_correction(<<~RUBY)
      Class.new(ApplicationPolicy) {}
    RUBY
  end
end
