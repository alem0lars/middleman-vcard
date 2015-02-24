module MiddlemanVCard
  class Generator

    include Contracts

    Contract( # {{{
      # 1: name
      String,
      # 2: emails
      ArrayOf[{
        email:     String,
        preferred: Or[Bool, nil],
        location:  Or[String, nil]
      }],
      # 3: phones
      ArrayOf[{
        number:     String,
        preferred:  Or[Bool, nil],
        location:   Or[String, nil],
        capability: Or[ArrayOf[String], nil]
      }],
      # 4: addresses
      ArrayOf[{
        preferred:  Or[Bool, nil],
        location:   Or[String, nil],
        street:     Or[String, nil],
        postalcode: Or[String, nil],
        locality:   Or[String, nil],
        region:     Or[String, nil],
        country:    Or[String, nil]
      }],
      # 5: photo
      Or[{
        path: String,
        type: String
      }, nil],
      # 6: logger
      Or[Logger, nil] => Any
    ) # }}}
    ##
    # Create a new VCard generator.
    #
    def initialize(name,         # 1
                   emails=[],    # 2
                   phones=[],    # 3
                   addresses=[], # 4
                   photo=nil,    # 5
                   logger=nil)   # 6

      @logger = logger || Logger.new($stdout)

      @card = Vpim::Vcard::Maker.make2 do |maker|

        maker.add_name do |n|
          n.given = name
        end

        emails.each do |email|
          maker.add_email(email[:email]) do |e|
            e.preferred = email[:preferred] || false
            e.location  = email[:location]  if email[:location]
          end
        end

        phones.each do |phone|
          maker.add_tel(phone[:number]) do |t|
            t.preferred  = phone[:preferred]  || false
            t.location   = phone[:location]   if phone[:location]
            t.capability = phone[:capability] if phone[:capability]
          end
        end

        addresses.each do |address|
          maker.add_addr do |a|
            a.preferred  = address[:preferred]  || false
            a.location   = address[:location]   if address[:location]
            a.street     = address[:street]     if address[:street]
            a.postalcode = address[:postalcode] if address[:postalcode]
            a.locality   = address[:locality]   if address[:locality]
            a.region     = address[:region]     if address[:region]
            a.country    = address[:country]    if address[:country]
          end
        end

        if photo
          # Normalize `photo[:path]`.
          photo[:path] = File.expand_path(photo[:path])
          # Check correctness of `photo[:path]`.
          unless File.file?(photo[:path])
            error("Invalid photo path: `#{photo[:path]}`.")
          end
          # Add photo informations to the VCard `maker`.
          maker.add_photo do |p|
            p.image = File.read(photo[:path])
            p.type  = photo[:type]
          end
        end

      end
    end # }}}

    Contract String => Any
    ##
    # Generate the VCard, storing the result in `destination_path`.
    #
    def generate(destination_path)
      begin
        File.open(destination_path, "w") { |file| file.write(@card) }
      rescue StandardError => err
        error(err.msg)
      else
        info("Successfully generated VCard to `#{destination_path}`.")
      end
    end

    protected

    def error(msg)
      @logger.error(format_msg(msg))
      # TODO: Raise error.
    end

    def info(msg)
      @logger.info(format_msg(msg))
    end

    def format_msg(msg)
      "[VCard] #{msg}"
    end

  end
end
