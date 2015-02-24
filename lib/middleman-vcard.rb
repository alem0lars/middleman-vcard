# Require - Core {{{

require "logger"

# }}}

# Require - External {{{

require "middleman-core"

# }}}

# Require - Project {{{

require "middleman-vcard/version"
require "middleman-vcard/generator"

Middleman::Extensions.register(:vcard) do
  require "middleman-vcard/extension"
  Middleman::VCard::VCardExtension
end

# }}}
