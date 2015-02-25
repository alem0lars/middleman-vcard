# Require - Core {{{

require "logger"

# }}}

# Require - External {{{

# Be a good citizen with Middleman.
require("contracts") unless Kernel::const_defined?(:Contracts)

require "vpim/vcard"

require "middleman-core"

# }}}

# Require - Project {{{

require "middleman-vcard/version"
require "middleman-vcard/generator"

# Register the extension with name: `:vcard` and lazily require the related
# module (the module containing the Middleman extension).
Middleman::Extensions.register(:vcard) do
  require "middleman-vcard/extension"
  Middleman::VCard::VCardExtension
end

# }}}
