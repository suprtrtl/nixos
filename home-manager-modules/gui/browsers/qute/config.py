# Use :set to see config options

# Sets Autoconfig Loading to false
config.load_autoconfig(False)

# Source Onedark Colors
config.source('onedark.py')

# Tab management
c.tabs.position = "left"
c.tabs.favicons.scale = 1.2
c.tabs.max_width = 48
c.tabs.min_width = 32

# Ad Blocking
c.content.blocking.enabled = True
c.content.blocking.method = "both"

# Cookies
c.content.cookies.accept = "never"
c.content.cookies.store = True

# Dark Mode
c.colors.webpage.preferred_color_scheme = "dark"
