# Gravity Birds — Art Brief (**Moss Ledger**)

**Scope lock:** polish visuals/UI only. Same rules, same 5 levels. Original art — no ripped sprites, no Snakebird names/levels/shapes.

**Style name:** **Moss Ledger** — cozy painted puzzle tiles. Soft edge shading, light texture grain, rounded soft corners (not perfect cubes). Chubby readable silhouettes at 64px. **Not** flat vectors, cyber neon, or any copyrighted puzzle-bird look.

**Grid:** `TILE_SIZE = 64`. Keep existing `TileType` enum: `EMPTY=0`, `SOLID=1`, `VOID=2`, `SPIKE=3`. Fruit, exit (locked/unlocked), and bird head/body/tail are separate sprites, not TileType values.

---

## Palette (named hex)

| Name | Hex | Use |
|------|-----|-----|
| Sky parchment | `#E8DFC8` | ClearColor / sky wash |
| Fog green | `#C5D4B8` | Soft mid-ground mist, empty filler tint |
| Moss solid | `#5F7A4A` | Solid tile body |
| Moss highlight | `#7A9A5E` | Tile top light |
| Moss shadow | `#3E5232` | Tile bottom / rims |
| Bird body | `#4A8FA8` | Head / segments / tail |
| Bird belly | `#D9E8EE` | Underside soft |
| Beak | `#E0A04A` | Head beak (faces **right**) |
| Eye | `#1A1A1A` | Pupil |
| Fruit | `#E07A2A` | Collectible |
| Leaf | `#5F7A4A` | Fruit leaf |
| Exit locked | `#8A8A7A` | Locked portal + padlock cue |
| Exit open | `#6FBF6A` | Unlocked portal + soft glow |
| Spike iron | `#6B3A3A` | Spike base |
| Spike tip | `#C45A4A` | Tip gleam |
| Void | `#2A2E38` | Abyss tiles (faint stars OK) |
| UI plaque | `#F3EAD6` | Button / panel fill |
| UI border | `#6B5A3E` | Warm wood/felt edge |
| UI text | `#2C2418` | Labels |

---

## Tile language

| Asset | Role |
|-------|------|
| `tile_solid.png` | Walkable / support ground. Rounded moss block, top highlight, bottom shadow, speckled grain. |
| `tile_empty.png` | Optional subtle parchment/fog filler with tiny grass tufts. **May be skipped in draw** (leave transparent air); documented for Devin if a soft grid wash is wanted. |
| `tile_void.png` | Soft deadly abyss — dark `#2A2E38`, vignette, faint stars, still readable as a tile. |
| `tile_spike.png` | Three iron spikes pointing up from a base; tip `#C45A4A`. Transparent outside silhouette. |

---

## Actors / props

| Asset | Notes |
|-------|------|
| `bird_head.png` | Chubby head facing **right**; beak + one clear eye. Flip with `flip_h` for left. |
| `bird_body.png` | Round segment with belly; chains read as one creature. |
| `bird_tail.png` | Preferred end segment; feathers taper left (behind when facing right). |
| `fruit.png` | Orange orb + leaf; collectible. |
| `exit_locked.png` | Gray stone arch + padlock. |
| `exit_open.png` | Green arch + soft glow core. |
| `fruit_icon.png` | 28×28 HUD counter icon. |
| `ui_button.png` | 96×48 soft plaque; 9-slice friendly (corner radius ~12). |
| `ui_panel.png` | 256×48 top HUD bar panel. |
| `atlas.png` + `atlas.json` | Optional sheet of 64×64 gameplay tiles (see JSON `frames`). |

All gameplay tiles/actors are **64×64** PNG with transparency where needed. UI sizes as above. Godot may import at native size; downsample only if you author 128×128 later.

---

## Background / sky

- Set puzzle `ClearColor` / ColorRect backdrop to **Sky parchment `#E8DFC8`**, optionally blend toward **Fog green `#C5D4B8`** at the bottom for a soft horizon wash.
- Do not draw a busy parallax; keep focus on the 64px grid.

---

## HUD / menu direction

Warm wooden/felt plaques — **not** gray engine-debug buttons.

- Top: level title (left), fruit count + `fruit_icon` (right), on `ui_panel`.
- Bottom or corners: **Undo**, **Restart**, **Menu** using `ui_button` as TextureButton / NinePatchRect; text `#2C2418`.
- See `HUD_MOCK.md` for layout.

---

## Godot wiring notes (for Devin — do not change rules)

**Keep** `TileType` enum and simulation logic. Only replace procedural `_draw` shapes with textures.

Suggested approach in `puzzle_game.gd` `_draw()` (or child `Sprite2D` / `TextureRect` grid):

```gdscript
# Suggested preloads (example names — adjust to your Autoload/resource layout)
const TEX_SOLID := preload("res://assets/art/tile_solid.png")
const TEX_EMPTY := preload("res://assets/art/tile_empty.png")  # optional
const TEX_VOID := preload("res://assets/art/tile_void.png")
const TEX_SPIKE := preload("res://assets/art/tile_spike.png")
const TEX_FRUIT := preload("res://assets/art/fruit.png")
const TEX_EXIT_L := preload("res://assets/art/exit_locked.png")
const TEX_EXIT_O := preload("res://assets/art/exit_open.png")
const TEX_HEAD := preload("res://assets/art/bird_head.png")
const TEX_BODY := preload("res://assets/art/bird_body.png")
const TEX_TAIL := preload("res://assets/art/bird_tail.png")

# In _draw, for each cell:
#   draw_texture(TEX_SOLID, Vector2(x, y) * TILE_SIZE)
# Head: draw_texture(TEX_HEAD, pos); use draw_set_transform / flip if moving left
# Body mid segments: TEX_BODY; last segment: TEX_TAIL if len > 1
# Exit: TEX_EXIT_O if all fruit collected else TEX_EXIT_L
```

Suggested HUD node names:

- `HudRoot` → `TopBar` (`NinePatchRect` / `TextureRect` ← `ui_panel.png`)
  - `LevelTitle` (`Label`)
  - `FruitCounter` (`HBox`: `FruitIcon` TextureRect ← `fruit_icon.png`, `FruitLabel`)
- `ButtonBar` → `BtnUndo`, `BtnRestart`, `BtnMenu` (`TextureButton` ← `ui_button.png`, 9-slice margins ~12)

Import settings: Filter **on** (soft painted), Mipmaps optional; 2D pixel snap **off** (not crisp pixel art).

**Out of scope for this art drop:** changing gravity, fruit growth, undo stack, level `.tres` data, or TileType values.

---

## Regeneration

Sprites were authored with a deterministic Python/Pillow paint script (soft blobs + grain). Re-run only if intentionally revising the look; keep filenames stable for Devin’s paths.
