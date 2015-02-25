require "pathname"


module Middleman
  module VCard
    ##
    # A Middleman extension to generate VCards.
    #
    class VCardExtension < Middleman::Extension

      option :name,      nil, "The VCard name", required: true
      option :emails,    [],  "The VCard emails"
      option :phones,    [],  "The VCard telephones"
      option :addresses, [],  "The VCard addresses"
      option :photo,     nil, "The VCard photo"

      option :dst_path, nil, "The destination path for the generated VCard"

      def initialize(app, options_hash={}, &block)
        super

        @name = options_hash[:name]

        source_dir_path = Pathname.new(app.root).join(app.config.source)

        if options_hash[:dst_path]
          unless options_hash[:dst_path].start_with?(source_dir_path.to_s)
            error("Invalid `dst_path`. It's not inside the source folder.")
          end

          @base_dir_path   = Pathname.new(File.dirname(options_hash[:dst_path]))
          @vcard_file_name = File.basename(options_hash[:dst_path])
        else
          @base_dir_path   = source_dir_path
          @vcard_file_name = "#{@name}.vcf"
        end

        @vcard_generator  = Middleman::VCard::Generator.new(
            options_hash[:name], options_hash[:emails],
            options_hash[:phones], options_hash[:addresses],
            options_hash[:photo], logger)
      end

      def after_configuration
        @vcard_generator.generate(@base_dir_path.join(@vcard_file_name))
      end

      helpers do

        def vcard_link(title=nil, **kwargs)
          prefix = @base_dir_path.relative_path_from(
              Pathname.new(app.root, app.config.source))

          link_to(title || @name, "#{prefix}/#{@vcard_file_name}", kwargs)
        end

      end

    end
  end
end
