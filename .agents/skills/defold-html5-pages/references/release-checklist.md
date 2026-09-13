# HTML5 release checklist

## Build contract

Record the pinned Defold version and Bob source in repository configuration. The canonical Bob flow is:

```sh
java -jar <bob.jar> \
  --archive \
  --platform wasm-web \
  --bundle-output <bundle-dir> \
  resolve build bundle
```

Adapt output paths and optional release flags to the approved design. Use `distclean` only when a clean rebuild is required; it deletes Bob build output.

Confirm the uploaded Pages artifact contains the generated `index.html`, WebAssembly and engine files, game archives, and all resources referenced by the page. Add `.nojekyll` to the published artifact if GitHub's static processing would otherwise interfere with generated filenames.

## Local browser smoke test

Serve the bundle directory with an HTTP server. Verify:

- initial load completes and the browser console has no uncaught errors;
- every request succeeds and `.wasm` is served as `application/wasm`;
- keyboard and any approved pointer/touch input work after the canvas receives focus;
- losing focus does not cause stuck input;
- audio starts only after browser-approved user interaction where required;
- resizing and representative desktop/mobile aspect ratios follow the design;
- one complete game session reaches the exit and restart works.

## Pages workflow contract

The build job must upload only the static bundle directory with `actions/upload-pages-artifact`. The deploy job uses `actions/deploy-pages`, has `pages: write` and `id-token: write`, and targets the `github-pages` environment. Pull requests may build and validate artifacts but must not deploy production Pages.

After deployment, verify the actual Pages URL rather than relying only on a green workflow.

## Official references

- Defold HTML5 manual: https://defold.com/manuals/html5/
- Bob manual: https://defold.com/manuals/bob/
- Defold bundling: https://defold.com/manuals/bundling/
- GitHub Pages custom workflows: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site
