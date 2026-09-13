---
name: defold-2d-game
description: Implement and verify approved 2D gameplay in native Defold resources and Lua. Use for project structure, collections, game objects, scripts, input, grid or physics movement, collision, cameras, GUI, level state, and gameplay tests; do not use to bypass this repository's plan and design approval gates.
---

# Defold 2D game

Read the approved plan and design before changing the game. If either approval is missing, return to `$game-feature-workflow` and produce the required artifact instead of implementing.

## Shape the project around Defold

- Keep `game.project` at repository root and ensure its bootstrap points to a reachable compiled collection resource.
- Use collections to compose scenes and levels, game objects as component containers, `.script` files for engine lifecycle glue, `.gui_script` for GUI behavior, and `.lua` modules for reusable rules and state transformations.
- Keep authoritative state ownership explicit. Prefer messages for meaningful communication between components; document sender, receiver, message id, and payload in the approved design.
- Reference every Defold resource from a build root or declare intentional runtime raw files through the project's Custom Resources setting.

## Implement deterministic gameplay

For maze rules, path cells, moves, win detection, and state transitions, prefer pure Lua modules with no Defold global calls. Let scripts translate input, collision messages, and lifecycle callbacks into operations on those modules.

Choose one movement model from the approved design:

- For tile-by-tile movement, validate the target cell against maze data before changing position. Define how held keys, simultaneous directions, interpolation, and input during movement behave.
- For continuous kinematic movement, use collision groups and masks deliberately and resolve contacts consistently. Use fixed timestep support when the design depends on physics stability.

Acquire input focus in the owning component and release it during teardown. Treat keyboard, pointer/touch, focus loss, restart, and resize behavior according to the design. Avoid frame-rate-dependent movement; scale continuous motion by `dt` or use fixed updates as appropriate.

Keep the victory transition idempotent so entering or overlapping the exit cannot fire completion more than once. Reset all transient state when restarting a level.

## Build feedback and presentation

Keep gameplay coordinates, rendering scale, and GUI coordinates conceptually separate. Make camera and viewport behavior deterministic for the supported aspect ratios. Give movement, blocked moves, the exit, victory, and restart enough visible or audible feedback to satisfy the design without hiding rules in presentation code.

## Verify the change

Read [references/verification.md](references/verification.md) when defining or executing checks. Start with pure Lua rules, then verify engine-dependent behavior in a focused collection, and finally exercise the complete playable flow. Record results against the design acceptance criteria.

Consult current official Defold manuals for APIs whose signatures or behavior are uncertain. Prefer the generated Defold API reference and manuals over remembered details or community snippets.
