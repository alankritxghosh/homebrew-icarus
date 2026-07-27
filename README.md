# Homebrew tap for Icarus

[Icarus](https://icarus-website-kappa.vercel.app/) answers *why* a codebase is
the way it is — with the evidence on screen, or an honest "no one wrote this
down" when the reason was never recorded.

```sh
brew install --cask --no-quarantine alankritxghosh/icarus/icarus
```

## Why `--no-quarantine` is in that command

Icarus is **not notarized by Apple**. Notarization requires a paid Developer ID
this alpha does not have yet, so macOS cannot vouch for the app and will refuse
to open it if it is quarantined.

Homebrew quarantines cask downloads by default, and a cask cannot waive that for
you — only you can, with `--no-quarantine`. Homebrew will print its own warning
when you use it. That warning is correct, and worth reading rather than
dismissing: the flag **skips** Gatekeeper's check rather than passing it. macOS
has not inspected this app.

If you would rather not pass the flag, install normally and clear it afterwards:

```sh
brew install --cask alankritxghosh/icarus/icarus
xattr -dr com.apple.quarantine /Applications/Icarus.app
```

## Verifying what you got

The cask pins the disk image's SHA-256, and Homebrew checks it on download, so a
corrupted or altered image fails the install rather than being installed
quietly. The same hash is published on the [homepage](https://icarus-website-kappa.vercel.app/).

Note what that does and does not prove: it confirms the image matches what was
published. It is not a substitute for Apple's signature and does not pretend to
be.

## Uninstalling

```sh
brew uninstall --cask icarus          # removes the app
brew uninstall --zap --cask icarus    # also removes its caches and preferences
```

The `--zap` form does not remove the GitHub token Icarus stores in your login
Keychain; sign out inside the app first if you want that gone too.

## Requirements

Apple silicon, macOS 14 (Sonoma) or newer.

## Problems

Email <ayushghosh2015@gmail.com>. It is an early beta and reports of what broke
are genuinely useful.
