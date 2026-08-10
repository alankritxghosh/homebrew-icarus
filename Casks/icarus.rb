cask "icarus" do
  version "0.1.6"
  sha256 "c6cdc32b886a81e263dfde9c25035c97cfd8d829d412ff9ea91777256ed5b080"

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

    Homebrew quarantines cask downloads, and a cask cannot waive that for you.
    So macOS will refuse to open Icarus until you clear the flag yourself:

        xattr -dr com.apple.quarantine /Applications/Icarus.app

    (Older guides say to pass --no-quarantine. Current Homebrew rejects it as an
    invalid option, and setting HOMEBREW_CASK_OPTS=--no-quarantine was measured
    to leave the app quarantined anyway. Clearing it afterwards is what actually
    works -- verified, not copied from a README.)

    Be clear-eyed about what that command does: it removes the flag that makes
    macOS check the app, rather than making the app pass a check. macOS has not
    inspected this app either way. The sha256 above is the one published on the
    homepage, so you can confirm the download matches what was published -- that
    detects a corrupted or altered download, and is not a substitute for Apple's
    signature.

    First run: sign in with GitHub, connect a repo, then press Cmd-Shift-I
    anywhere and ask a question.

    Problems, or anything that behaved oddly: ayushghosh2015@gmail.com
  CAVEATS
end
