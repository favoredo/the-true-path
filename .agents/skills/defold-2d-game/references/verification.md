# Defold gameplay verification

Use the narrowest layer that can prove each criterion, then cover the complete player flow.

## Static and build checks

- Confirm `game.project` references the intended bootstrap collection using the compiled `.collectionc` suffix.
- Confirm resources required at runtime are reachable from build roots.
- Run the repository's formatter or Lua static checks when configured.
- Build with the project's pinned Bob version. A successful build proves resource compilation only.

## Pure Lua checks

Exercise deterministic modules directly where the available runner supports it. Useful cases for a maze game include:

- bounds and wall rejection;
- valid movement in every supported direction;
- spawn and exit validity;
- win transition firing exactly once;
- restart restoring the initial state;
- maze parsing or generation invariants, including a reachable exit when generation is used.

Avoid tests that merely duplicate constants or implementation text.

## Running collection checks

Use a focused development or test collection for behavior that needs Defold lifecycle, input, messages, collision objects, factories, animation, or GUI. Establish a known state, perform one behavior, assert the observable result, and clean up.

Use a temporary Bob settings file to select a test bootstrap collection. Do not leave `game.project` pointing to test content.

## Playable flow

Serve the HTML5 bundle over HTTP and verify at least:

1. the game loads without browser console errors;
2. the intended controls move the hero and walls block movement;
3. focus loss and regain do not leave movement stuck;
4. the exit triggers the designed completion state once;
5. restart produces a clean playable state;
6. representative viewport sizes keep play and GUI usable.

Record environment, command or URL, result, and any evidence in the design document.

## Official references

- Building blocks: https://defold.com/manuals/building-blocks/
- Scripts and lifecycle: https://defold.com/manuals/script/
- Physics and collision: https://defold.com/manuals/physics/
- Project settings: https://defold.com/manuals/project-settings/
- Automated testing: https://defold.com/manuals/automated-testing/
