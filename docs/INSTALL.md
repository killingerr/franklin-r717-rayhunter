# Install Rayhunter on Franklin R717 (T9)

Unofficial manual install. EFF does not ship an R717 installer.

## Prerequisites

- Franklin R717 on firmware **2602-era** build (e.g. `R717F21.FR.M2602` / `R717F21.FR.A2661` after root-only restore)
- **Root** via [config-restore exploit](https://snt.sh/2021/09/rooting-the-t-mobile-t9-franklin-wireless-r717-again/) — use **Root only**, not the 1311 downgrade config
- Tooling: [franklin-r717-t9-downgrade](https://github.com/riptidewave93/franklin-r717-t9-downgrade) or prebuilt `root_2602_only_config.bin`
- SSH access from a PC on the hotspot Wi‑Fi
- **Stock config backup** saved before modifying the device

1311 downgrade is **not required** for this path.

## 1. Root the hotspot

1. Download [root_2602_only_config.bin](https://snt.sh/uploads/t9/configs/root_2602_only_config.bin)
2. Restore at `http://192.168.0.1/settings/device-backup_and_restore.html`
3. Verify SSH (Windows may need legacy RSA):

   ```powershell
   ssh -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa root@192.168.0.1
   ```

   Default root password after exploit: `frk9x07` — change with `passwd`, then edit `/data/configs/root.sh` and **remove or replace** the lines that reset root to `frk9x07` on every boot (otherwise your `passwd` change is lost after reboot).

### Passwords (three different things)

| Login | Typical use |
|-------|-------------|
| **Web UI** (`http://192.168.0.1`) | Admin settings — factory default is often `admin` or `password` after restore, not your Wi‑Fi password |
| **SSH** (`root@192.168.0.1`) | Shell / Rayhunter — starts as `frk9x07` until you `passwd` and fix `root.sh` |
| **Wi‑Fi** | Joining the hotspot from phone/PC — shown on the LCD if display password is on |

The LCD may show your **Wi‑Fi** password (e.g. `FrankT9!`); that will **not** work on the web login page.

## 2. Download Rayhunter

Get the latest release from [EFForg/rayhunter](https://github.com/EFForg/rayhunter/releases).

From the Windows zip, you need:

`rayhunter-vX.X.X-windows-x86_64/rayhunter-vX.X.X-windows-x86_64/rayhunter-daemon/rayhunter-daemon`

That file is a **static ARMv7** binary for the hotspot (not for your PC).

## 3. Copy files to the T9

On the device:

```sh
mkdir -p /cache/rayhunter/qmdl
```

Copy from your PC (paths vary; adjust):

```powershell
$ssh = "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa"
scp $ssh.Split(" ") path\to\rayhunter-daemon path\to\config\t9-config.toml root@192.168.0.1:/cache/rayhunter/
```

If `scp` fails on Windows, serve files from the PC with `python -m http.server` and `wget` from the T9 (see README).

On the T9:

```sh
cd /cache/rayhunter
mv t9-config.toml config.toml
chmod +x rayhunter-daemon
```

## 4. Run

**Only one instance** at a time.

```sh
cd /cache/rayhunter
killall rayhunter-daemon 2>/dev/null
sleep 5
RUST_LOG=warn ./rayhunter-daemon config.toml
```

Web UI: **http://192.168.0.1:8080** (stock admin UI remains on port 80).

## 5. SIM / field use

Insert a working data SIM, confirm LTE in the stock UI, then run Rayhunter while the hotspot is on and moving. Recordings land in `/cache/rayhunter/qmdl/`.

See [KNOWN-ISSUES.md](KNOWN-ISSUES.md) for operational pitfalls.
