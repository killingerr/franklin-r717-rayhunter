# Known issues

## Diag: `DIAG_IOCTL_SWITCH_LOGGING failed`

Usually **two `rayhunter-daemon` processes** or a **suspended** instance (`Ctrl+Z`) still holding `/dev/diag`.

Fix:

```sh
killall rayhunter-daemon
kill -9 $(pidof rayhunter-daemon) 2>/dev/null
sleep 5
```

Start **one** foreground instance. Use `Ctrl+C` to stop — never `Ctrl+Z`.

## Battery errors in logs

`device = "orbic"` reads Orbic sysfs paths that do not exist on the T9. Harmless; recording still works. Use `RUST_LOG=warn` to reduce noise.

## Wrong directory

Binary and config live in `/cache/rayhunter`, not `~`.

## SSH on Windows

```powershell
ssh -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa root@192.168.0.1
```

## SSH password resets every reboot

`root.sh` from the root-only exploit runs on boot and can force root back to `frk9x07`. After `passwd`, edit `/data/configs/root.sh` and remove or update the `passwd` lines so your chosen SSH password persists.

## Web UI login fails but Wi‑Fi works

Web admin password (`/data/configs/authkeys` and `ITAdminPassword` in `mobileap_cfg.xml`) is separate from the **Wi‑Fi** password (`WPAKey`). The LCD may display the Wi‑Fi key. Try factory-style web passwords (`admin`, `password`) or reset the web password from SSH (update both `authkeys` and `ITAdminPassword`, then reboot).

## Disk space

Recordings use `/cache` (~60 MB free). Monitor with `df -h /cache`.

## RAM

~170 MB total RAM. If the daemon is OOM-killed, avoid other heavy processes.

## Not official

Not supported by EFF. Track upstream: [rayhunter#708](https://github.com/EFForg/rayhunter/discussions/708).
