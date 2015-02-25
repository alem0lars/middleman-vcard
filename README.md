# Middleman VCard

![Status](http://img.shields.io/badge/status-OK-green.svg)

## Project informations

* [Homepage](https://rubygems.org/gems/middleman-vcard)
* [Documentation](http://rubydoc.info/gems/middleman-vcard/frames)
* [Email](mailto:molari.alessandro@gmail.com)

## Description

A Middleman extension to generate VCards and provide useful helpers to work
with.

## Usage

Include the `middleman-vcard` gem in your Gemfile:

```Ruby
gem 'middleman-vcard'
```

Add the following code to your `config.rb` file:

```Ruby
require "middleman-vcard"
activate :vcard,
  name: data.site.vcard.name,
  emails: [{
    email:     data.site.vcard.email,
    preferred: true,
    location:  "work"
  }],
  phones: [{
    number:     data.site.vcard.phone,
    preferred:  true,
    location:   "work",
    capability: ["voice", "video", "msg"]
  }],
  addresses: [{
    preferred:  true,
    location:   "work",
    postalcode: data.site.vcard.postalcode.to_s,
    locality:   data.site.vcard.city,
    region:     data.site.vcard.province,
    country:    data.site.vcard.country
  }],
  photo: {
    path: File.join(root, config.source, config.images_dir, "logo-vcard.jpg"),
    type: "jpeg"
  }
```

Of course you can organize your data as you want and choose what to include 
in your data files or directly in your config file.

Also, *you can pass multiple phones, addresses, emails*.

Now the VCard file will be automatically generated :D

### Helpers:

Usually you need to include your VCard in HTML, so there are some helpers
already defined:

#### `vcard_link`

*Generate a link tag that points to the VCard*.

Details [here](./lib/middleman-vcard/extension).

#### `vcard_path`

*Build the path that points to the VCard file*.

Details [here](./lib/middleman-vcard/extension).

## Contributors

Many thanks to Luca Molari (LMolr)!!

## Install

    $ gem install middleman-vcard

## Copyright

Copyright (c) 2015 Alessandro Molari

See {file:LICENSE} for details.
