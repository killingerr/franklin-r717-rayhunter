# franklin-r717-rayhunter

Community port of [EFF Rayhunter](https://github.com/EFForg/rayhunter) to the **Franklin Wireless R717** (T-Mobile T9).

**Status:** Manual install works on rooted 2602-era firmware **without** downgrading to 1311. Diag init, recording, and web UI on port **8080** confirmed. On-device LCD alerts are not implemented yet.

This is **not** an official EFF project. Discuss upstream: [Rayhunter #708](https://github.com/EFForg/rayhunter/discussions/708).

## Related projects

| Repo | Purpose |
|------|---------|
| [riptidewave93/franklin-r717-t9-downgrade](https://github.com/riptidewave93/franklin-r717-t9-downgrade) | Root / downgrade config tooling |
| [EFForg/rayhunter](https://github.com/EFForg/rayhunter) | Upstream Rayhunter |

## Git hooks (optional)

After clone, enable hooks that strip Cursor agent `Co-authored-by` trailers:

```sh
git config core.hooksPath .githooks
```

Also disable **Cursor Settings → Agents → Attribution** on your machine.

## Quick start

1. Root with **root-only** config ([install guide](docs/INSTALL.md))
2. Download [Rayhunter release](https://github.com/EFForg/rayhunter/releases) — use the `rayhunter-daemon` ARM binary from the installer zip
3. Copy `config/t9-config.toml` and the daemon to `/cache/rayhunter/` on the hotspot
4. Run `scripts/start-rayhunter.sh` or `./rayhunter-daemon config.toml`
5. Open **http://192.168.0.1:8080**

## Repository layout

```
config/t9-config.toml   # Device config (device=orbic for diag)
docs/INSTALL.md         # Full install steps
docs/DISPLAY.md         # 128x36 1bpp LCD / guimgrd notes
docs/KNOWN-ISSUES.md    # Diag lock, battery spam, etc.
scripts/start-rayhunter.sh
```

## Verified environment (community)

- Root via `root_2602_only_config.bin`
- Rayhunter **v0.11.2**
- `device = "orbic"`, `ui_level = 0`, `qmdl_store_path = "/cache/rayhunter/qmdl"`
- `/dev/diag` present; Qualcomm MDM9607-class stack

## License

Documentation and scripts in this repo: MIT (or your choice when publishing).

Rayhunter is [CC BY 4.0 / GPL-3.0](https://github.com/EFForg/rayhunter/blob/main/LICENSE) — comply with upstream when distributing `rayhunter-daemon`.
