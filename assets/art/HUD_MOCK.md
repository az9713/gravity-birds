# HUD Mock — Moss Ledger

Warm parchment / wood-felt UI. Avoid default gray Godot debug chrome.

## Top bar

```
┌──────────────────────────────────────────────────────────────┐
│  ui_panel.png (full width, ~48–56px tall, 9-slice)           │
│                                                              │
│  [Level title — left]              [fruit_icon] 3/5  — right │
│  e.g. "First Steps"                icon 28px + Label         │
│  Font color #2C2418, readable size                           │
└──────────────────────────────────────────────────────────────┘
```

- Panel texture: `ui_panel.png` (`#F3EAD6` fill, `#6B5A3E` border).
- Level name: left padding ~16–24px; one line; ellipsis if needed.
- Fruit count: right side; `fruit_icon.png` then `collected/total` (e.g. `2/3`).
- Optional soft shadow under the bar so it lifts off the sky parchment.

## Action buttons (bottom or lower corners)

```
                    … puzzle grid …

┌──────────┐   ┌──────────┐   ┌──────────┐
│  Undo    │   │ Restart  │   │  Menu    │
│ ui_button│   │          │   │          │
└──────────┘   └──────────┘   └──────────┘
   (or cluster bottom-left / bottom-right)
```

- Texture: `ui_button.png` (96×48), NinePatchRect / TextureButton with ~12px margins.
- Labels centered, `#2C2418`; pressed state = slight darken or 1–2px y-offset.
- Keyboard hints optional (Z / R) in smaller muted text under label — keep uncluttered.
- Hover: tiny brighten of plaque highlight; never neon.

## Menu / level select

- Same plaque language for primary buttons (Play, Back).
- Level select cards: fog-green wash `#C5D4B8` on parchment, moss border when selected.
- Title treatment can reuse moss + bird-head icon; no engine-looking flat gray panels.

## Clear hierarchy

1. Puzzle grid remains the focus (sky `#E8DFC8` behind).
2. Top bar = status only.
3. Buttons = warm, tactile, secondary.

## Do not

- Gray `Button` defaults without theme override.
- High-contrast debug outlines.
- Crowding the grid with floating debug FPS/stats.
