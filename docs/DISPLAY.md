# Display (Franklin R717 LCD)

Rayhunter does **not** drive the T9 text LCD yet. Warnings appear on the web UI (`:8080`) only.

## Hardware

| Property | Value |
|----------|-------|
| Framebuffer | `/dev/fb0` |
| Resolution | **128 × 36** |
| Depth | **1 bpp** (monochrome) |
| Stride | 16 bytes |

```sh
cat /sys/class/graphics/fb0/virtual_size   # 128,36
cat /sys/class/graphics/fb0/bits_per_pixel # 1
```

## Software stack

| Process | Role |
|---------|------|
| `/usr/bin/guimgrd` | GUI manager, message queue, LCD timeouts |
| `/usr/franklin/mwin/bin/mmi_gui_app` | Franklin UI (text/icons on the panel) |

`guimgrd` references paths such as `/system/UICfg/LCD/...` and events like `SW_UPDATE_REQ_EVENT`.

## Rayhunter today

- Config uses `device = "orbic"` for **diag** compatibility.
- `ui_level = 0` (invisible) — no on-device Rayhunter UI.
- Orbic draws **RGB565** to a color framebuffer — **wrong format** for this 1-bit panel.

Closest upstream reference for a future port: Rayhunter `tplink_onebit` display code.

## Future: on-screen alert

Goal: map `WarningDetected` → short text (e.g. `ALERT`) via `guimgrd` IPC and/or controlled `fb0` writes. Requires a new `franklin` / `r717` device profile in Rayhunter.
