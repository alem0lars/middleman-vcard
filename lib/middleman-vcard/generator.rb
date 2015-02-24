module MiddlemanVCard
  class Generator

    include Contracts

    Contract [
      String,                        # 1: name
      ArrayOf[{                      # 2: emails
        email:     String,
        preferred: Or[Bool, nil]
        location:  Or[String, nil]
      }],
      ArrayOf[{                      # 3: phones
        number:     String,
        preferred:  Or[Bool, nil]
        location:   Or[String, nil],
        capability: Or[ArrayOf[String], nil]
      }],
      ArrayOf[{                      # 4: addresses
        preferred:  Or[Bool, nil]
        location:   Or[String, nil],
        street:     Or[String, nil],
        postalcode: Or[String, nil],
        locality:   Or[String, nil],
        region:     Or[String, nil],
        country:    Or[String, nil],
      }],
      Or[{                           # 5: photo
        path: String,
        type: String
      }, nil]
    ] => Any
    def initialize(name, emails: [], phones: [], addresses: [], photo: {})
      @card = Vpim::Vcard::Maker.make2 do |maker|

        maker.add_name do |name|
          name.given = name
        end

        emails.each do |email|
          maker.add_email(email[:email]) do |e|
            e.preferred = email[:preferred] || false
            e.location  = phone[:location] unless phone[:location].nil?
          end
        end

        phones.each do |phone|
          maker.add_tel(phone[:number]) do |t|
            t.preferred  = phone[:preferred] || false
            t.location   = phone[:location] unless phone[:location].nil?
            t.capability = phone[:capability] unless phone[:capability].nil?
          end
        end

        addresses.each do |address|
          maker.add_addr do |a|
            a.preferred  = address[:preferred] || false
            a.location   = address[:location] unless address[:location].nil?
            a.street     = address[:street] unless address[:street].nil?
            a.postalcode = address[:postalcode] unless address[:postalcode].nil?
            a.locality   = address[:locality] unless address[:locality].nil?
            a.region     = address[:region] unless address[:region].nil?
            a.country    = address[:country] unless address[:country].nil?
          end
        end

        maker.add_photo do |photo|
          photo.image = File.read(photo[:path])
          photo.type  = photo[:type]
        end

      end
    end

    Contract String => Bool
    def generate(destination_path)
      begin
        File.open(destination_path, "w") { |file| file.write(@card) }
      rescue
        # TODO: log error
        false
      else
        true
      end
    end

  end
end
