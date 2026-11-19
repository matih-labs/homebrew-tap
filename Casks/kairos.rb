# Kairos for Mac, for Homebrew (2.0.47): `brew install --cask matih-labs/tap/kairos`.
# The Release workflow writes it into matih-labs/homebrew-tap as Casks/kairos.rb
# (public/build-cask.sh fills in the version and the disk image's SHA-256).
# Kairos updates itself, so Homebrew leaves updates to it (auto_updates).
# Uninstalling runs what Kairos's Settings > Remove Kairos… runs: its
# background items and files go, accounts and their sign-ins stay.
# Homebrew runs the same step for `brew upgrade`, `brew reinstall` and `brew
# install` over an installed cask (an uninstall stanza is not told which it is:
# docs.brew.sh/Cask-Cookbook), so the engine reads the process table and, under
# those, removes nothing (2.0.81, claude-rotation homebrew_replacing_kairos).
cask "kairos" do
  version "2.0.83"
  sha256 "14b0ed1b0951f32b89bbf71aa07c3538b597ddd7ba74f958beb64f03f739556e"

  url "https://github.com/matih-labs/kairos/releases/download/v#{version}/Kairos-#{version}-macOS.dmg"
  name "Kairos"
  desc "Air traffic control for your coding agents"
  homepage "https://kairos.matihlabs.com/"

  livecheck do
    url "https://kairos.matihlabs.com/update.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: :sequoia

  app "Kairos.app"

  uninstall quit:   "com.matihlabs.kairos",
            script: {
              executable:   "#{appdir}/Kairos.app/Contents/Resources/Engine/bin/claude-rotation",
              args:         ["uninstall"],
              must_succeed: false,
            }

  zap trash: [
    "~/Library/Caches/com.matihlabs.kairos",
    "~/Library/HTTPStorages/com.matihlabs.kairos",
    "~/Library/Preferences/com.matihlabs.kairos.plist",
  ]
end
