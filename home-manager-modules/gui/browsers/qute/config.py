# Use :set to see config options

# Sets Autoconfig Loading to false
config.load_autoconfig(False)

# Source Onedark Colors
config.source('onedark.py')

# Tab management
c.tabs.position = 'left'
c.tabs.width = "10%"

# Ad Blocking
c.content.blocking.enabled = True
c.content.blocking.method = 'both'

# Cookies
c.content.cookies.accept = 'never'
c.content.cookies.store = True

# Dark Mode
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.enabled = False

# Keybindings
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('td', 'config-cycle colors.webpage.darkmode.enabled')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')

# Aliases
c.aliases['sdm'] = 'set colors.webpage.darkmode.enabled true'
c.aliases['slm'] = 'set colors.webpage.darkmode.enabled false'
c.aliases['ytd'] = 'hint links spawn ghostty -e yt-dlp {hint-url}'
c.aliases['pass'] = 'spawn --userscript qute-bitwarden'

# Completion
c.completion.shrink = True

# Font
c.fonts.default_size = "11pt"
c.fonts.default_family = "Cousine Nerd Font"

# PDF's
c.content.pdfjs = True
