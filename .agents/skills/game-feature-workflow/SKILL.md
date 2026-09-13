---
name: game-feature-workflow
description: Manage the required plan, design, implementation, and verification gates for game feature requests in this repository. Use whenever the user proposes or changes game behavior, content, presentation, architecture, tooling, delivery, or release work.
---

# Game feature workflow

Preserve enough state in repository documents for another Codex session to continue without chat history.

## Locate the active work

Inspect `git status`, `docs/plans/*.md`, and `docs/design/*.md`. Match artifacts by slug and continue the current phase when the new request belongs to it. Create a short kebab-case slug only for genuinely new work.

Use the templates in `assets/plan-template.md` and `assets/design-template.md`. Keep the sections that carry decisions and continuation state; adapt detail to the feature.

## Enforce the gates

### Plan phase

Create `docs/plans/<slug>.md` with status `draft`. Capture the requested outcome, current repository state, scope, assumptions, ordered actions, affected areas, verification outline, risks, open decisions, and continuation context.

Make the plan concrete enough to estimate and review, but do not settle implementation details that need design analysis. Present the file and pause for explicit plan approval. If corrections arrive, edit the same plan, record the change, keep it `draft`, and present it again.

### Design phase

After explicit plan approval, record the approval and change the plan to `approved`. Create `docs/design/<slug>.md` with status `draft` and link both files.

Specify player-facing behavior, game rules and states, level/content representation, Defold resources and message flow, input, camera and presentation behavior, edge cases, HTML5 constraints, acceptance criteria, and exact verification scenarios. Every acceptance criterion needs a corresponding check with observable evidence.

Present the design and pause for explicit design approval. Corrections return the design to `draft`. Do not edit implementation, game assets, CI, or build configuration during plan or design review.

### Implementation and verification

After explicit design approval, record the approval, set the design to `implementing` and the plan to `in_progress`, then implement only the approved scope. Keep implementation checklists and continuation context current after meaningful milestones.

When implementation is complete, set the design to `verifying` and run the documented checks. Record each command or manual scenario, its result, and relevant evidence. Fix in-scope failures and rerun affected checks. Mark both artifacts `verified` only when all required acceptance criteria pass; otherwise leave the current status and document the exact remaining work.

## Handle changed scope

When a new request invalidates approved behavior or architecture, update the affected artifact, mark it `draft`, and repeat approval at that gate. Minor implementation discoveries that do not change observable behavior or agreed architecture may be recorded as decisions without reopening approval.

Never infer approval from silence, unrelated replies, or approval of a different phase.
