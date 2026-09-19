# Gravity Birds v1.5 - Level Design Documentation

## Design Philosophy

This level set teaches core Gravity Birds mechanics through a progressive difficulty curve. Each level introduces one new concept while reinforcing previous lessons. All levels are hand-verified solvable with documented solutions.

## Teaching Progression

1. **Gravity Basics** - Core movement and gravity
2. **Body Bridge** - Using body length to traverse gaps
3. **Step by Step** - Body segments as climbing platforms
4. **Spike Maze** - Hazard navigation and planning
5. **The Weave** - Multi-fruit order-dependent puzzle

---

## Level 1: Gravity Basics

**Teaching Goal**: Introduce gravity, fruit collection, and unsupported segments falling.

**Concept**: When you move off a platform, unsupported segments fall. Collect fruit to grow, then reach the exit.

### Layout (8x6)
```
. . . . . . . .
. . . . . . . .
S . . . . . . .
# # # . . . . .
# # . . F . . E
# # # # # # # #
```
- S = Start (head at row 2, tail at row 1, both column 1)
- F = Fruit at (4,4)
- E = Exit at (7,4)
- \# = Solid tile
- . = Empty

### Solution
1. **Start**: Creature at (1,2)+(1,1), length 2
2. **Move Right**: To (2,2). Gravity applies - both segments fall to (2,3) and (2,2) respectively
3. **Move Right**: To (3,3). Segments settle at (3,4) and (3,3)
4. **Move Right**: To (4,4). Collect fruit! Length now 3
5. **Move Right**: Continue to (5,4), (6,4), (7,4)
6. **Win**: Head reaches exit at (7,4) with all fruit collected

**Key Lesson**: Segments fall independently when unsupported. Plan for post-gravity positions.

---

## Level 2: Body Bridge

**Teaching Goal**: Use body length to bridge gaps and reach distant platforms.

**Concept**: Growing longer via fruit allows you to span gaps - your body segments can support your head.

### Layout (10x6)
```
. . . . . . . . . .
. . . . . . . . . .
S . . . . . . . . .
# # # . . . F . . .
# # . . . . . . # #
# # # # # # # # # #
```
- S = Start (head at row 2, tail at row 1, both column 1)
- F = Fruit at (6,3)
- E = Exit at (8,3)

### Solution
1. **Start**: Creature at (1,2)+(1,1), length 2
2. **Move Right**: To (2,2). Fall to (2,3) standing on platform
3. **Move Right** repeatedly: Navigate to fruit at (6,3)
4. **Collect fruit**: Length now 3 - head at (6,3), body at (5,3), tail at (4,3)
5. **Move Right**: Head to (7,3). Body forms bridge: (6,3), (5,3), (4,3)
6. **Move Right**: Head reaches (8,3) - exit! Body spans the gap, supporting the head
7. **Win**: Exit unlocked (all fruit collected) and head on exit

**Key Lesson**: Body segments prevent falling - use length strategically to cross gaps.

---

## Level 3: Step by Step

**Teaching Goal**: Use body segments as stairs to climb to higher platforms.

**Concept**: Collect fruits in sequence to build a staircase of body segments.

### Layout (10x8)
```
. . . . . . . . . E
. . . . . . . . # #
. . . . . . . # # .
. . . F . . # # . .
. . F . . # # . . .
S F . . # # . . . .
# # . # # . . . . .
# # # # # # # # # #
```
- S = Start at (0,5)+(0,4), length 2
- F = Fruits at (1,5), (2,4), (3,3)
- E = Exit at (9,0)

### Solution
1. **Start**: Creature at (0,5)+(0,4), length 2
2. **Move Right**: Collect fruit at (1,5). Length now 3
3. **Move Right**: Head at (2,5), body fills in. Gravity settles
4. **Move Up**: Head to (2,4). Stand on body segment at (2,5)
5. **Move Right**: Collect fruit at (2,4). Length now 4
6. **Navigate right and up**: Use body as platform to reach (3,4)
7. **Move Up**: Stand on body to reach (3,3)
8. **Collect fruit**: At (3,3). Length now 5
9. **Climb the staircase**: Move right onto platform at (4,3), then continue ascending
10. **Navigate the zigzag platforms**: (5,3) → (6,2) → (7,2) → (8,1) → (9,1) → (9,0)
11. **Win**: Reach exit at (9,0)

**Key Lesson**: Body segments create platforms. Strategic fruit collection builds the tools you need.

---

## Level 4: Spike Maze

**Teaching Goal**: Navigate around hazards with fair sightlines.

**Concept**: Spikes cause instant failure (soft undo). Plan your path to avoid them.

### Layout (10x7)
```
. . . . . . . . . .
. . . . . . . . . .
. . . X . . X . . .
# # # . # # . . . .
# # F . . F . . . E
# # . . X . . X # #
# # # # # # # # # #
```
- S = Start at (1,3)+(1,2), length 2
- F = Fruits at (2,4), (5,4)
- X = Spikes at (3,2), (6,2), (4,5), (7,5)
- E = Exit at (9,4)

### Solution
1. **Start**: Creature at (1,3)+(1,2), length 2
2. **Move Down**: To (1,4). Fall to row 4
3. **Move Right**: Collect fruit at (2,4). Length now 3
4. **Move Down**: Careful! Spike at (2,5) would kill us if we move there
5. **Move Right**: Navigate around spike at (2,5) by staying at row 4
6. **Navigate right**: Carefully move through (3,4) - avoiding spike at (3,2) above and (4,5) below
7. **Move Right**: To (4,4), then (5,4) - collect second fruit! Length now 4
8. **Continue right**: Navigate past spikes at (6,2) and (7,5)
9. **Move Right**: Continue to (9,4)
10. **Win**: Reach exit with all fruit

**Key Lesson**: Spikes are visible obstacles. Plan ahead - undo is available but mastery means no mistakes.

---

## Level 5: The Weave

**Teaching Goal**: Planning peak - fruit collection order matters.

**Concept**: Some puzzles have "wrong" orderings. Think ahead about where your body will be.

### Layout (12x8)
```
. . . . . . . . . . . .
. . . . . . . . . . . .
. . . . . . . . . . E .
# # . . . F . . . # # #
# # . . # . # . . . . .
# # F . # . # . F . . .
# # . . # # # . . . . .
# # # # # # # # # # # #
```
- S = Start at (1,5)+(1,4), length 2
- F = Fruits at (2,5), (5,3), (8,5)
- E = Exit at (10,2)

### Solution (One valid path)
1. **Start**: Creature at (1,5)+(1,4), length 2
2. **Move Right**: To (2,5), collect fruit immediately. Length now 3
3. **Move Right**: To (3,5). Body trails behind
4. **Navigate around column**: Can't go through solid at (4,5). Need to go up
5. **Move Up**: To (3,4), (3,3) to get above the column
6. **Move Right**: Through (4,3), reach fruit at (5,3). Length now 4
7. **Move Down and Right**: Navigate through gap at (6,4), then (6,5)
8. **Continue Right**: Through (7,5), reach fruit at (8,5). Length now 5
9. **Navigate to exit platform**: Body is long enough to help climb
10. **Move Right**: To (9,5), then start climbing
11. **Move Up**: Using body as support, climb to (9,4), (9,3), (9,2)
12. **Move Right**: To (10,2) - exit!
13. **Win**: All fruit collected, head on exit

**Key Lesson**: Order matters. Wrong collection order can trap you. Use undo freely to experiment.

---

## Design Notes

### Difficulty Progression
- **L1**: 6 moves, teaches basics
- **L2**: ~10 moves, introduces bridging
- **L3**: ~20 moves, climbing mechanics
- **L4**: ~15 moves, hazard awareness
- **L5**: ~25 moves, planning and sequencing

### No Cloned Layouts
All layouts are original designs. Snakebird was studied for mood/pacing only - no level geometry was copied.

### Simulation Order Preserved
All solutions account for the Move→Push→Grow→Gravity→Hazards simulation order. Gravity applies after each move, segments fall independently, growth happens after gravity settles.

### Testing Recommendations
1. Verify each level loads without errors
2. Hand-test solutions match documentation
3. Confirm difficulty ramp feels smooth
4. Check that teaching goals are communicated clearly through layout
