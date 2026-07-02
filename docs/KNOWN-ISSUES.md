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

## Disk space

Recordings use `/cache` (~60 MB free). Monitor with `df -h /cache`.

## RAM

~170 MB total RAM. If the daemon is OOM-killed, avoid other heavy processes.

## Not official

Not supported by EFF. Track upstream: [rayhunter#708](https://github.com/EFForg/rayhunter/discussions/708).
