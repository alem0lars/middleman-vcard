module MiddlemanVCard
  ##
  # A Middleman extension to generate VCards.
  #
  class VCardExtension < Middleman::Extension
    option :name,           "The VCard name", required: true
    option :emails,    [],  "The VCard emails"
    option :phones,    [],  "The VCard telephones"
    option :addresses, [],  "The VCard addresses"
    option :photo,     nil, "The VCard photo"

    def initialize(app, options_hash={}, &block)
      super

      @vcard_generator = ::Generator.new(options_hash[:name],
                                         options_hash[:emails],
                                         options_hash[:phones],
                                         options_hash[:addresses],
                                         options_hash[:photo],
                                         logger)
    end

    def after_configuration
      @vcard_generator.generate
    end

  end

end

::Middleman::Extensions.register(:vcard, MiddlemanVCard::VCardExtension)
