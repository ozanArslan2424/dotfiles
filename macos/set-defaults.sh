# Run ./set-defaults.sh and you'll be good to go.

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# SAFARI OPTIONS I'M NOT SURE ABOUT
# # Hide Safari's bookmark bar.
# defaults write com.apple.Safari.plist ShowFavoritesBar -bool false
#
# # Always show Safari's "URL display" tab in the lower left on mouseover. Strangely
# # like, everyone and their LLMs on the internet thinks this is ShowStatusBar, but
# # it's not.
# defaults write com.apple.Safari ShowOverlayStatusBar -bool true
#
# # Set up Safari for development.
# defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
# defaults write com.apple.Safari.plist IncludeDevelopMenu -bool true
# defaults write com.apple.Safari.plist WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari.plist "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
