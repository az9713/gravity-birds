# Gravity Birds v1.5 — Level Design Documentation

## Design Philosophy

Progressive teaching curve. One new idea per room. Every solution below was BFS-verified against the real sim (Move → Grow → Gravity → Hazards, per-segment gravity, grow after settle).

## Teaching Progression

1. **Gravity Basics** — move + gravity settle + fruit
2. **Body Bridge** — length spans gaps
3. **Step by Step** — body as climbing platform
4. **Spike Maze** — hazards with fair sightlines
5. **The Weave** — multi-fruit planning + climb to exit

---

## Level 1: Gravity Basics

**Idea:** Unsupported segments fall after each move.

**Layout (8×6):** ledge → drop → fruit → exit on floor  
**Start:** head `(1,2)`, tail `(1,1)` · **Fruit:** `(4,4)` · **Exit:** `(7,4)`

**Verified solution (6):** `RRRRRR`

---

## Level 2: Body Bridge

**Idea:** Grow, then use body support to reach a higher exit ledge.

**Layout (10×6):** left ledge, mid air fruit, right exit ledge  
**Start:** `(1,2)+(1,1)` · **Fruit:** `(6,3)` · **Exit:** `(8,3)`

**Verified solution (9):** `RRRRRURUR`

---

## Level 3: Step by Step

**Idea:** Multi-fruit length build for ascending platforms.

**Layout (10×8):** staggered solids climbing right/up  
**Start:** `(0,5)+(0,4)` · **Fruits:** `(1,5),(2,4),(3,3)` · **Exit:** `(9,0)`

**Verified solution (17):** `RRUURUURURURURURR`

---

## Level 4: Spike Maze

**Idea:** Visible spikes (overhead + one on the route). Plan the corridor; no cheap traps.

**Layout (10×7):**
```
..........
..........
..X...X...
..........
#...X....E   fruits at (2,4) and (6,4); exit (9,4)
#........#
##########
```
**Start:** head `(1,4)`, tail `(1,3)` (both empty — not inside solids)

**Verified solution (11):** `RURRRRURRUR`

---

## Level 5: The Weave

**Idea:** Collect three fruits, then climb body/ledges to a high exit. Planning peak.

**Layout (12×8):** floor fruits, mid pillars, high right exit at `(9,2)`  
**Start:** `(1,5)+(1,4)` · **Fruits:** `(2,5),(6,5),(8,5)`

**Verified solution (15):** `RRURRRRRULUUURR`

---

## Notes

- Original layouts only (mood refs allowed; no commercial level clones).
- L4/L5 in the first PR draft failed solvability (L4 spawn-in-solid; L5 unreachable) and were replaced with the layouts above.
- Identity unchanged: grid puzzle, head-only move, fruit = +1, exit after all fruit, spike/void soft-fail undo.
