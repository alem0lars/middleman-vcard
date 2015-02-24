require 'rspec'
require 'pry-byebug'

require 'middleman-vcard'


module Middleman
  module VCard
    module Helpers

      def wait_for
        unless block_given?
          raise 'a block must be given!'
        end

        # Another possible implementation can use sleep instead of spin-locking..
        # In practice, in tests, this is way more efficient than sleeping o_O
        loop { break if yield }
      end

    end
  end
end


RSpec.configure do |config|
  config.include Middleman::VCard::Helpers
end
