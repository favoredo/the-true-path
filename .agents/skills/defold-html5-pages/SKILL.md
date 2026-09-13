---
name: defold-html5-pages
description: Build, test, and publish an approved Defold HTML5 release through GitHub Pages. Use for Bob configuration, web bundle layout, browser checks, GitHub Actions Pages workflows, and deployment diagnostics; do not publish or alter release infrastructure before the repository's design gate is approved.
---

# Defold HTML5 and GitHub Pages

Read the approved plan and design. Deployment configuration is implementation, so do not create or change it while the design remains unapproved.

Read [references/release-checklist.md](references/release-checklist.md) before creating or changing the build workflow.

## Produce a reproducible bundle

- Pin the Defold/Bob release used by local scripts and CI. Do not rely on an unrecorded latest version.
- Run Bob from repository root. Resolve dependencies, build an archive, and bundle for `wasm-web`; use an explicit build and bundle output path.
- Default to the non-threaded `wasm-web` architecture for GitHub Pages. Add `wasm_pthread-web` only when the approved design needs it and the hosting setup provides the required cross-origin isolation headers; retain `wasm-web` fallback where practical.
- Keep generated bundles out of source control unless the approved delivery design explicitly uses a committed publishing directory.
- If custom HTML, CSS, icons, or splash resources are needed, configure them as Defold HTML5 template resources so bundling reproduces them.

## Configure GitHub Pages

Prefer the official Pages artifact workflow: check out the source, obtain the pinned Bob toolchain, produce the HTML5 bundle, configure Pages, upload only the static bundle directory, and deploy it in a separate job or step with the documented permissions.

Use least privilege: `contents: read`, plus `pages: write` and `id-token: write` only for deployment. Limit deployment to the default branch and allow `workflow_dispatch` when useful. Use the `github-pages` environment and expose the deployment URL from the deploy action.

Pin third-party actions to reviewed major versions or immutable commits according to repository policy. Do not invent secrets; standard Pages deployment uses the GitHub-provided token and OIDC permissions.

## Verify before and after publishing

An HTML5 bundle must be served over HTTP; opening `index.html` through `file://` is not a valid test. Check `.wasm` MIME handling, browser console output, asset loading, input and focus, audio activation, canvas sizing, and the complete start-to-exit-to-restart flow.

Validate the workflow syntax and inspect the bundle contents before deployment. After an authorized deployment, inspect the Actions result and run the same smoke scenario at the published Pages URL. Record the workflow run, URL, and results in the design document.

If GitHub Pages repository settings still require a maintainer to select **GitHub Actions** as the publishing source, report that exact remaining step; do not mark the release verified until the public URL works.
