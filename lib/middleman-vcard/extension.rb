require "middleman-core"
require "middleman-vcard/generator"


module Middleman
  module VCard
    ##
    # A Middleman extension to generate VCards.
    #
    class VCardExtension < Middleman::Extension

      option :name,      nil, "The VCard name" # TODO: It should be required.
      option :emails,    [],  "The VCard emails"
      option :phones,    [],  "The VCard telephones"
      option :addresses, [],  "The VCard addresses"
      option :photo,     nil, "The VCard photo"

      option :destination_path, nil, "Destination path for the generated VCard"

      def initialize(app, options_hash={}, &block)
        super

        @destination_path = options_hash[:destination_path] ||
            File.join(app.root, app.config.source, "#{options_hash[:name]}.vcf")
        @vcard_generator  = ::Generator.new(options_hash[:name],
                                            options_hash[:emails],
                                            options_hash[:phones],
                                            options_hash[:addresses],
                                            options_hash[:photo],
                                            logger)
      end

      def after_configuration
        @vcard_generator.generate(@destination_path)
      end

    end
  end
end
