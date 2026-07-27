cask "icarus" do
  version "0.1.0"
  sha256 "a899cf2e338660cf02d661c06348117e456cbc7196d95414613f1c7081e2f795"

  url "https://icarus-website-kappa.vercel.app/Icarus.dmg"
  name "Icarus"
  desc "Answers why a codebase is the way it is, with citations or an honest unknown"
  homepage "https://icarus-website-kappa.vercel.app/"

  # The app is built for Apple silicon only and targets macOS 14+. Declaring
  # both means brew refuses the install up front on a machine that cannot run
  # it, rather than installing something that dies at launch.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Icarus.app"

  zap trash: [
    "~/Library/Caches/com.alankrit.icarus",
    "~/Library/HTTPStorages/com.alankrit.icarus",
    "~/Library/Preferences/com.alankrit.icarus.plist",
  ]

  caveats <<~CAVEATS
    Icarus is NOT notarized by Apple. Notarization requires a paid Developer ID
    this alpha does not have yet, so macOS cannot vouch for this app.

    Homebrew quarantines downloads by default, so unless you passed
    --no-quarantine, macOS will refuse to open Icarus. Either reinstall with:

        brew install --cask --no-quarantine alankritxghosh/icarus/icarus

    or clear the flag on what you just installed:

        xattr -dr com.apple.quarantine "$(brew --prefix)/../Applications/Icarus.app"

    Be clear-eyed about what --no-quarantine does: it skips Gatekeeper's check
    rather than passing it. macOS has not inspected this app either way. The
    sha256 above is the one published on the homepage, so you can verify the
    download matches what was published -- that detects a corrupted or altered
    download, and is not a substitute for Apple's signature.

    First run: sign in with GitHub, connect a repo, then press Cmd-Shift-I
    anywhere and ask a question.

    Problems, or anything that behaved oddly: ayushghosh2015@gmail.com
  CAVEATS
end
