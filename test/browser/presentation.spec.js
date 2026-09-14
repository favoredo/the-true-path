const { test, expect } = require('@playwright/test');
const { decode } = require('./png.cjs');
async function checkTitle(page) {
 const png = decode(await page.screenshot());
 let bright = 0;
 for (let y=10; y<60; y++) for(let x=0; x<png.width; x++) if(png.pixel(x,y)[0]>100) bright++;
 expect(bright, 'Title remains visible after resize and input').toBeGreaterThan(100);
}

test('renderer follows settled hero through ten orientation changes', async ({ page }) => {
  const errors = [];
  page.on('pageerror', error => errors.push(error.message));
  page.on('console', message => {
    if (message.type() === 'error' || /ERROR:SCRIPT|ERROR:GAMESYS/.test(message.text())) errors.push(message.text());
  });
  await page.goto('/');
  await page.waitForFunction(() => window.__TTP_RENDER__ && window.__THE_TRUE_PATH_STATE__);
  for (let i = 0; i < 10; i++) {
    const portrait = i % 2 === 0;
    const viewport = portrait ? { width: 390, height: 844 } : { width: 844, height: 390 };
    await page.setViewportSize(viewport);
    await page.waitForTimeout(250);
    const { state, render } = await page.evaluate(() => ({
      state: window.__THE_TRUE_PATH_STATE__, render: window.__TTP_RENDER__
    }));
    expect(render.camera_x).toBeCloseTo(state.hero_x, 3);
    expect(render.camera_y).toBeCloseTo(state.hero_y, 3);
    expect(render.view_width / render.view_height).toBeCloseTo(viewport.width / viewport.height, 3);
    expect(Math.max(render.target_width, render.target_height)).toBeLessThanOrEqual(1920);
    await checkTitle(page);
  }
  await page.setViewportSize({ width: 390, height: 844 });
  await page.locator('canvas').focus();
  for (const [direction, key] of [['up','ArrowUp'], ['right','ArrowRight'], ['down','ArrowDown'], ['left','ArrowLeft']]) {
    await page.keyboard.press(key, { delay: 60 });
    await page.waitForTimeout(250);
    expect(await page.evaluate(() => window.__THE_TRUE_PATH_STATE__.direction)).toBe(direction);
    await checkTitle(page);
    await page.screenshot({ path: `test/evidence/003-hero-${direction}.png` });
  }
  expect(errors).toEqual([]);
});
