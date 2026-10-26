# Kairos for Mac, for Homebrew (2.0.47): `brew install --cask matih-labs/tap/kairos`.
# The Release workflow writes it into matih-labs/homebrew-tap as Casks/kairos.rb
# (public/build-cask.sh fills in the version and the disk image's SHA-256).
# Kairos updates itself, so Homebrew leaves updates to it (auto_updates).
# Uninstalling runs what Kairos's Settings > Remove Kairos… runs: its
# background items and files go, accounts and their sign-ins stay.
cask "kairos" do
  version "2.0.51"
  sha256 "99990c260371843e6dcdf383ffac497dc26eae48e0a364a10e12681bda46e074"

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
