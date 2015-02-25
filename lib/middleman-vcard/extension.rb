require "pathname"


module Middleman
  module VCard
    ##
    # A Middleman extension to generate VCards and provide useful helpers to
    # work with.
    #
    class VCardExtension < Middleman::Extension

      option :name,      nil, "The VCard name", required: true
      option :emails,    [],  "The VCard emails"
      option :phones,    [],  "The VCard telephones"
      option :addresses, [],  "The VCard addresses"
      option :photo,     nil, "The VCard photo"

      option :dst_path, nil, "The destination path for the generated VCard"

      ##
      # Create the VCardExtension.
      #
      def initialize(app, options_hash={}, &block)
        super

        @name      = options_hash[:name]
        @emails    = options_hash[:emails]
        @phones    = options_hash[:phones]
        @addresses = options_hash[:addresses]
        @photo     = options_hash[:photo]

        @dst_path = options_hash[:dst_path]

        source_dir_path = Pathname.new(app.root).join(app.config.source)

        if @dst_path
          unless @dst_path.start_with?(source_dir_path.to_s)
            error("Invalid `dst_path`. It's not inside the source folder.")
          end
          @vcard_dir_path  = Pathname.new(File.dirname(@dst_path))
          @vcard_file_name = File.basename(@dst_path)
        else
          @vcard_dir_path  = source_dir_path
          @vcard_file_name = "#{@name}.vcf"
        end

        @vcard_generator  = Middleman::VCard::Generator.new(
            @name, @emails, @phones, @addresses, @photo, logger)

        # Define some config used later
        #
        # NOTE: We want to be consistent with Middleman conventions, so
        #       `vcard_dir_path` is a `String` because all Middleman paths are
        #       `String`s.
        app.config.define_setting :vcard_name,      @name
        app.config.define_setting :vcard_file_name, @vcard_file_name
        app.config.define_setting :vcard_dir_path,  @vcard_dir_path.to_s
      end

      ##
      # After Middleman has been configured (i.e. build, console, server, etc..)
      # generate the VCard.
      #
      def after_configuration
        @vcard_generator.generate(@vcard_dir_path.join(@vcard_file_name))
      end

      helpers do

        ##
        # Build the path that points to the VCard file.
        #
        # @note The generated path is meant to be used in `href`s or similar
        #       (is relative to the source or build directory). It's not meant
        #       to be directly used for filesystem access.
        #
        # @return The path for the VCard file.
        #
        def vcard_path
          # Find the VCard prefix path, which is relative to the source
          # directory because that's the root path that will be served and built
          # by Middleman.
          prefix = Pathname.new(config.vcard_dir_path).relative_path_from(
              Pathname.new(root).join(config.source))

          "#{prefix}/#{config.vcard_file_name}"
        end

        ##
        # Generate a link tag that points to the VCard.
        #
        # @param title [String|nil] The link title.
        #                           If `nil`, the VCard name will be used.
        # @param kwargs [Hash] The keyword arguments to be passed into `link_to`
        #
        # @return [String] The generated HTML link tag.
        #
        def vcard_link(title=nil, **kwargs)
          link_to(title || config.vcard_name, vcard_path, kwargs)
        end

      end

    end
  end
end
