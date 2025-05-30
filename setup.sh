#!/bin/bash
set -e

# To run:
# $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/jessie-ross/dot-files/main/setup.sh)"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'


### Homebrew and Cask Apps ###

if ! which brew > /dev/null
then
	echo "Homebrew is required:"
	echo "https://brew.sh/"
	exit 1
fi

# Install via app store as much as possible:

# brew install --cask --quiet \
# 	1password \
# 	alfred \
# 	dash \
# 	docker \
# 	firefox \
# 	flux \
# 	slack \
# 	texts \
# 	textual \
# 	zoom \
# 	zotero

# Install dropbox for alfred + dash preferences

brew install --quiet \
	clojure/tools/clojure \
	coreutils \
	findutils \
	fzf \
	gh \
	gnu-tar \
	gnu-sed \
	gawk \
	grep \
	git \
	ripgrep \
	rsync \
	lua-language-server \
	neovim \
	nvm \
	parallel \
	poetry \
	pyenv \
	python@3.10 \
	python@3.11 \
	python@3.12 \
	pipx \
	rustup \
	swi-prolog \
	tree-sitter \
	universal-ctags \
	volta \
	weechat

# NPM
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

volta install --quiet \
  node \
  npm \
  yarn

volta run npm install --quiet -g \
  typescript \
  typescript-language-server \
  diagnostic-languageserver \
  eslint_d \
  pyright

# Java as recommended by Clojure:
# brew install --cask temurin@21

# Rust
rustup-init -y

### Apple Settings ###

# Disable “Press and Hold Keys”: 
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# faster key repetition: https://twitter.com/rauchg/status/863451302348468225
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# System Preferences > Mission Control > Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remap CapsLock to Ctrl
if [ ! -f ~/Library/LaunchAgents/me.scjr.CapslockToCtrl.plist ]
then
	mkdir -p ~/Library/LaunchAgents
	cat <<EOF > ~/Library/LaunchAgents/me.scjr.CapslockToCtrl.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>me.scjr.CapslockToCtrl</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/bin/hidutil</string>
      <string>property</string>
      <string>--set</string>
      <string>{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
EOF
	launchctl load me.scjr.CapslockBackspace.plist
fi

# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw \
  --setglobalstate on \
  --setstealthmode on

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the screenshots folder
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# Disable app reopen after restart
defaults write -g ApplePersistence -bool no

# Disable asking for dictation
defaults write com.apple.HIToolbox AppleDictationAutoEnable -int 0

echo
echo '######################################################'
echo To wipe the Dock clean:
echo '$ defaults write com.apple.dock persistent-apps -array'
echo '######################################################'
echo


#### Activity Monitor ####

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


#### Finder ####

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Finder > Preferences > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder > Preferences > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library 2> /dev/null || true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Enable text selection in quick view
defaults write com.apple.finder QLEnableTextSelection -bool TRUE


#### Safari ####

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# # Enable the Develop menu and the Web Inspector in Safari
# sudo defaults write com.apple.Safari IncludeDevelopMenu -bool true
# sudo defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# # Enable Safari’s debug menu
# sudo defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# # Press Tab to highlight each item on a web page
# sudo defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
# sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# # Make Safari’s search banners default to Contains instead of Starts With
# sudo defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# # Show the full URL in the address bar (note: this still hides the scheme)
# sudo defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true


#### Mac App Store ####

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true


### Add dotfiles in ###

mkdir -p ~/code-personal

if [ ! -d ~/code-personal/dot-files ] ; then
  (
    cd ~/code-personal
    git clone https://github.com/jessie-ross/dot-files.git
    cd dot-files
    git remote set-url origin git@github.com:jessie-ross/dot-files.git
  )
fi

(
  cd ~/code-personal/dot-files
  ./links.sh
)

echo Some of these changes require a reboot to take effect.
