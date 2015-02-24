module MiddlemanVCard

  class VCardExtension < Middleman::Extension
    def initialize(app, options_hash={}, &block)
      super
      @vcard_generator = ::Generator.new(options_hash)
    end

    def after_configuration
      @vcard_generator.generate
    end
  end

  alias :included :registered

end

::Middleman::Extensions.register(:vcard, MiddlemanVCard::VCardExtension)
