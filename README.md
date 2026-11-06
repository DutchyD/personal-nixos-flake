# NixOS configurations

NixOS and Home Manager configurations for several machines, built from one flake.

## Layout

| Path | Purpose |
|---|---|
| `flake.nix` | Inputs, and the outputs: hosts, formatter and checks |
| `lib/` | Host discovery and flake checks |
| `shells/` | Shared development shells, loaded per project with direnv |
| `hosts/<name>/` | One folder per machine: hardware, feature toggles, specialisations. The folder name is the host name |
| `modules/base/` | Settings every machine gets: boot, file systems, snapshots, nix, networking, locale, packages, user |
| `modules/desktop/` | Desktop selection via `custom.desktop` |
| `modules/features/` | Opt-in features toggled per host |
| `home/<user>/` | Home Manager configuration for the primary user, including git and Plasma settings |

## Rebuilding

The flake path is preconfigured for nh, so commands run from anywhere.

- `nh os build` builds the configuration for the current host and shows a package diff.
- `nh os switch` builds and activates it immediately.
- `nh os boot` builds it and makes it the default for the next boot.

Use `boot` and reboot instead of `switch` when a change adds or removes the desktop or display manager, so the running session is not restarted underneath you.

`nix flake update` updates the inputs. Run `nh os build` afterwards before switching.

Old generations are cleaned weekly. The five newest, and anything from the last seven days, are always kept and stay selectable in the boot menu. The Nix store is deduplicated weekly.

## Features

Each host enables what it needs in its `default.nix` under `custom`:

| Option | Effect |
|---|---|
| `custom.development.enable` | direnv with nix-direnv, for loading the shared development shells |
| `custom.docker.enable` | Docker daemon, `docker` group for the primary user, and firewall trust for the Docker bridges |
| `custom.gaming.enable` | Steam with Proton-GE, GameMode, gamescope and game launchers, on boot entries with a desktop |
| `custom.nixLd.enable` | nix-ld with its default libraries, for binaries not built by Nix |

Other options:

| Option | Default |
|---|---|
| `custom.user.name` | `dutchy` |
| `custom.flakePath` | `Projects/personal-nixos-flake` in the primary user's home |

## Desktop and specialisations

The default boot entry runs KDE Plasma 6 behind SDDM. A specialisation drops Plasma by selecting another desktop. Desktop applications in Home Manager follow the same choice.

mini-driver has an `umbriel` specialisation that runs the [Umbriel](https://github.com/noctalia-dev/umbriel) Wayland compositor behind Noctalia Greeter on greetd. Pick it in the boot menu.

To add a console-only boot entry to a host, set `custom.desktop` to `"none"` inside `specialisation.<name>.configuration` in that host's `default.nix`. Never set `custom.desktop` outside a specialisation. Doing so conflicts with any specialisation that sets it.

Plasma settings that should be the same on every machine are declared with plasma-manager in `home/<user>/plasma.nix`: global theme, virtual desktops, screen locking, mouse acceleration and default applications. Only the declared settings are managed; anything changed in System Settings that is also declared there is reset on the next rebuild. To capture new settings, run `nix run github:nix-community/plasma-manager#rc2nix` and copy the relevant lines.

To support another desktop environment, add its name to the `custom.desktop` option in `modules/desktop/default.nix`, and add a module next to it that is active only for that value and brings its own display manager.

## Development shells

Native libraries that projects need at runtime live in shared shells under `shells/`, not in the system configuration. A project opts in with a one-line `.envrc`:

| Shell | For |
|---|---|
| `dotnet-desktop` | Avalonia and SkiaSharp desktop apps on .NET 10, including OpenAL audio |

In the project folder, create `.envrc` containing `use flake ~/Projects/personal-nixos-flake#dotnet-desktop`, then run `direnv allow` once. Entering the folder loads the shell; leaving it unloads it. `.envrc` and `.direnv/` are ignored globally by git, so they stay out of project repositories.

Projects that need nothing beyond the plain SDK, such as web APIs, need no shell; `dotnet` is installed for the user.

Rider started from the desktop does not see direnv. Either install a direnv plugin from the JetBrains marketplace, or start Rider from a terminal inside the project.

To add a shell, create a file in `shells/` and list it in `shells/default.nix`. To give a project extra libraries, add a new shell rather than growing an existing one.

## Adding a host

1. Create `hosts/<name>/`. The folder name becomes the configuration name. Only host folders belong in `hosts/`.
2. On the machine, run `nixos-generate-config --show-hardware-config > hosts/<name>/hardware-configuration.nix`. Remove the generated header comment.
3. Add `hosts/<name>/default.nix`. It imports the hardware file and sets the `custom` feature toggles and `system.stateVersion`. The host name comes from the folder name. Copy an existing host as a starting point.
4. Run `git add` on the new folder. Flakes only see files tracked by git.
5. For the first install, run `sudo nixos-rebuild boot --flake .#<name>`. After that, use nh.

Every host is expected to use btrfs with `/`, `/home` and `/nix` as separate mounts, as `nixos-generate-config` produces for the existing machines. Compression and snapshots depend on that layout.

## File systems and snapshots

All btrfs mounts use zstd compression. Existing files stay uncompressed until rewritten; `sudo btrfs filesystem defragment -r -czstd /` compresses them once. The file system is scrubbed monthly.

`/home` is snapshotted hourly with snapper, keeping 24 hourly, 7 daily and 4 weekly snapshots. Snapshots are browsable at `/home/.snapshots/<number>/snapshot`. To list them, run `snapper -c home list`. To restore a file, copy it back from the snapshot folder. Deleted files keep using disk space until the snapshots that contain them expire.

## Formatting and checks

- `nix fmt` formats every Nix file.
- `nix flake check` evaluates every host, verifies formatting, and verifies that Plasma is present by default and absent when another desktop is selected.

## Notes

- The source files contain no comments by convention.
- Git is configured through Home Manager. `~/.gitconfig` is read after it and overrides it, so that file should not exist.
- OpenSSH runs with its default settings, which permit password authentication.
