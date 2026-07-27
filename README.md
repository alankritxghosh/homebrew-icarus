# Homebrew tap for Icarus

[Icarus](https://icarus-website-kappa.vercel.app/) answers *why* a codebase is
the way it is — with the evidence on screen, or an honest "no one wrote this
down" when the reason was never recorded.

```sh
brew install --cask alankritxghosh/icarus/icarus
xattr -dr com.apple.quarantine /Applications/Icarus.app
```

Both lines are needed. The second one is not boilerplate — without it macOS
refuses to open the app.

## Why the second line exists

Icarus is **not notarized by Apple**. Notarization requires a paid Developer ID
this alpha does not have yet, so macOS cannot vouch for the app and blocks it
whenever it carries the quarantine flag.

Homebrew applies that flag to cask downloads, and a cask has no way to waive it
on your behalf — which is the correct design, and not something a tap should be
able to switch off for you.

Older guides tell you to pass `--no-quarantine`. That advice is stale: current
Homebrew rejects the flag outright (`Error: invalid option: --no-quarantine`),
and setting `HOMEBREW_CASK_OPTS=--no-quarantine` was measured here to leave the
app quarantined regardless. Clearing the flag after installing is what actually
works, which is why that is what this README says.

Be clear-eyed about what `xattr -dr` does: it removes the flag that makes macOS
check the app, rather than making the app pass a check. **macOS has not
inspected this app.** You are extending trust to a stranger's binary — the
honest framing, rather than one that makes it sound safer than it is.

## What the tap does give you

- Homebrew verifies the disk image's **SHA-256** on download, so a corrupted or
  altered image fails the install rather than being installed quietly. The same
  hash is published on the [homepage](https://icarus-website-kappa.vercel.app/).
- `brew upgrade` picks up new versions.
- `brew uninstall` removes it cleanly.
- The formula is public and versioned, so you can read
  [every change ever made to it](../../commits/main/Casks/icarus.rb).

It does **not** make an unsigned app trustworthy, and does not claim to.

## Uninstalling

```sh
brew uninstall --cask icarus          # removes the app
brew uninstall --zap --cask icarus    # also removes its caches and preferences
```

`--zap` does not remove the GitHub token Icarus stores in your login Keychain;
sign out inside the app first if you want that gone too.

## Requirements

Apple silicon, macOS 14 (Sonoma) or newer.

## Problems

Email <ayushghosh2015@gmail.com>. It is an early beta and reports of what broke
are genuinely useful.
