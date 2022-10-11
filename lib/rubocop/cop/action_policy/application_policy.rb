# frozen_string_literal: true

require "rubocop-rails"

module Rubocop
  module Cop
    module ActionPolicy
      # Checks that your policies are subclasses of `ApplicationPolicy`.
      #
      # @safety
      #   This cop's autocorrection is unsafe because it may let the logic from `ApplicationPolicy`
      #   sneak into a policy that is not purposed to inherit logic common among other policies.
      #
      # @example
      #
      #  # good
      #  class MyPolicy < ApplicationPolicy
      #    # ...
      #  end
      #
      #  # bad
      #  class MyPolicy < ActionPolicy::Base
      #    # ...
      #  end
      class ApplicationPolicy < RuboCop::Cop::Base
        extend RuboCop::Cop::AutoCorrector

        MSG = "Policies should subclass `ApplicationPolicy`."
        SUPERCLASS = "ApplicationPolicy"
        BASE_PATTERN = "(const (const nil? :ActionPolicy) :Base)"

        include RuboCop::Cop::EnforceSuperclass
      end
    end
  end
end
