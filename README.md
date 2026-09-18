# Gravity Birds

An original grid-based puzzle game inspired by gravity-and-snake mechanics. Guide multi-segment creatures to collect fruit and reach the exit.

## Game Concept

**Gravity Birds** is an original puzzle game featuring:
- Snake-like creatures that move on a 2D grid
- Physics-based gravity system - unsupported objects fall after each move
- Strategic fruit collection that grows your creature
- Challenging levels with increasing difficulty

**This is an original game with unique art, levels, and design - not affiliated with or derived from any existing puzzle game IP.**

## About

**Grok Bot** built this.

This Godot puzzle game was developed by the **Grok Bot team** — autonomous assistants in the Grok Bot app — using a **Cursor Cloud Agent** on **Cursor Origin**, then re-homed here on GitHub.

**Grok Bot is the star of the show.** Cursor was the coding workshop; Grok Bot ran the production: planning, specialist handoffs, Cloud Agent steering, and demystifying the path from Origin to your laptop.

### Cast
- **Chief** (Grok Bot) — lead / orchestrator — the showrunner for this build
- **Devin** (Grok Bot, Development) — launched and steered the Cursor Cloud Agent — *not* Cognition's Devin product
- **Rex** (Grok Bot, Research) — Snakebird-inspired mechanics checklist (original game only)

**Live development journey (GitHub Pages):**  
[https://az9713.github.io/grokbot-gravity-bird/gravity-birds-dev-journey.html](https://az9713.github.io/grokbot-gravity-bird/gravity-birds-dev-journey.html)

Also in-repo: [`gravity-birds-dev-journey.html`](./gravity-birds-dev-journey.html)

## How to Play

### Controls
- **Arrow Keys** or **WASD**: Move the creature's head
- **Z**: Undo last move
- **R**: Restart current level
- **On-screen buttons**: Undo, Restart, Menu

### Rules
1. Move the creature's head in orthogonal directions (no reversing into your neck)
2. After each move, gravity pulls unsupported segments downward
3. Collect ALL fruit (orange circles) to unlock the exit (green square)
4. Guide the creature's head into the exit to win
5. Avoid spikes and falling into the void
6. Use undo/restart if you get stuck

### Mechanics Details
- **Simulation Order**: Move → Push → Grow → Gravity → Hazards
- **Fruit**: Eating fruit grows the creature by +1 segment at the tail
- **Exit**: Only unlocks after collecting all fruit
- **Death**: Touching spikes or void automatically undoes one step
- **Undo**: Full state stack saves every successful move

## Opening in Godot 4

### Requirements
- Godot 4.3 or later (download from [godotengine.org](https://godotengine.org/download))

### Steps
1. Launch Godot 4
2. Click "Import" on the project manager
3. Navigate to this folder and select `project.godot`
4. Click "Import & Edit"
5. Press **F5** or click the Play button to run the game

## Running the Game

Once opened in Godot:
1. Press **F5** to run from the editor
2. The main menu will appear
3. Click "Play" to see the level select
4. Choose a level to start playing

## Exporting to HTML5/Web

### Prerequisites
Install the Godot HTML5 export template:
1. In Godot, go to **Editor → Manage Export Templates**
2. Click "Download and Install" for version 4.3.x
3. Wait for download to complete

### Export Steps
1. Go to **Project → Export**
2. Click "Add..." and select "Web"
3. Configure export settings:
   - **Export Path**: Choose a folder (e.g., `export/web/index.html`)
   - **Export Type**: Regular
4. Click "Export Project"
5. The exported files will be in your chosen folder

### Running the Web Export
The HTML5 export requires a local web server. You can use:

```bash
# Python 3
cd export/web
python3 -m http.server 8000
```

Then open `http://localhost:8000` in your browser.

**Note**: Web exports cannot run directly from `file://` URLs due to browser security restrictions.

## Project Structure

```
.
├── project.godot          # Godot project configuration
├── scenes/                # Scene files (.tscn)
│   ├── main_menu.tscn    # Main menu screen
│   ├── level_select.tscn # Level selection screen
│   ├── puzzle.tscn       # Puzzle container scene
│   ├── puzzle_game.tscn  # Core game logic scene
│   ├── hud.tscn          # In-game HUD overlay
│   └── level_button.tscn # Level button template
├── scripts/               # GDScript files
│   ├── global.gd         # Global state singleton
│   ├── level_data.gd     # Level data resource script
│   ├── puzzle_game.gd    # Core game mechanics
│   ├── puzzle.gd         # Puzzle scene controller
│   ├── hud.gd            # HUD controller
│   ├── main_menu.gd      # Main menu controller
│   └── level_select.gd   # Level select controller
├── levels/                # Level resource files (.tres)
│   ├── level_01.tres     # Tutorial: First Steps
│   ├── level_02.tres     # The Gap
│   ├── level_03.tres     # Stairway
│   ├── level_04.tres     # Danger Zone
│   └── level_05.tres     # The Puzzle
└── assets/                # Assets folder (empty - using procedural art)
```

## Levels

The game includes 5 handcrafted levels:

1. **First Steps** - Tutorial level introducing basic movement and gravity
2. **The Gap** - Learn to bridge gaps with your growing body
3. **Stairway** - Climb using collected fruit strategically
4. **Danger Zone** - Navigate around spike hazards
5. **The Puzzle** - Multi-step challenge requiring careful planning

## Technical Details

- **Engine**: Godot 4.3
- **Language**: GDScript
- **Grid Size**: 64x64 pixels per tile
- **Art Style**: Simple geometric shapes with solid colors (original artwork)
- **State Management**: Deep copy state stack for unlimited undo
- **Physics**: Custom gravity simulation after each move

## Troubleshooting

### Game won't start
- Ensure you're using Godot 4.3 or later
- Check that all `.tscn` and `.tres` files are present

### Levels not loading
- Verify that all files in `levels/` folder exist
- Check console for error messages

### Web export issues
- Ensure export templates are installed for your Godot version
- Use a web server (not file:// URLs)
- Check browser console for errors

## Credits

**Game Design & Programming**: Original work
**Engine**: Godot Engine (MIT License)
**Inspiration**: Grid-based gravity puzzle mechanics

This game is an original creation with unique levels, art, and implementation.

## License

This project is provided as-is for educational and personal use.
