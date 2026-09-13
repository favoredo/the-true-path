const { test, expect } = require('@playwright/test');

const SOLUTION = 'RRRRDDDDRRDDRRRRUUUURRUURRDDDDLLDDRR';
const KEY = { U: 'ArrowUp', D: 'ArrowDown', L: 'ArrowLeft', R: 'ArrowRight' };

async function state(page) {
  return page.evaluate(() => window.__THE_TRUE_PATH_STATE__);
}

async function openGame(page, errors) {
  page.on('pageerror', error => errors.push(`page: ${error.message}`));
  page.on('console', message => {
    if (message.type() === 'error') errors.push(`console: ${message.text()}`);
  });
  page.on('requestfailed', request => errors.push(`request: ${request.url()} ${request.failure()?.errorText}`));
  await page.goto('/');
  await expect(page.locator('canvas')).toBeVisible();
  await page.waitForFunction(() => window.__THE_TRUE_PATH_STATE__?.status === 'playing');
  await page.locator('canvas').click({ position: { x: 320, y: 180 } });
}

async function pressAndSettle(page, key) {
  await page.keyboard.down(key);
  await page.waitForTimeout(50);
  await page.keyboard.up(key);
  await page.waitForTimeout(160);
}

test('loads without browser errors and obeys keyboard movement', async ({ page }) => {
  const errors = [];
  await openGame(page, errors);
  await expect.poll(() => state(page)).toMatchObject({ status: 'playing', row: 2, col: 2, blocked_count: 0 });

  await pressAndSettle(page, 'ArrowUp');
  await expect.poll(() => state(page)).toMatchObject({ row: 2, col: 2, blocked_count: 1 });

  await pressAndSettle(page, 'd');
  await expect.poll(() => state(page)).toMatchObject({ row: 2, col: 3 });

  await pressAndSettle(page, 'r');
  await expect.poll(() => state(page)).toMatchObject({ status: 'playing', row: 2, col: 2, blocked_count: 0, win_count: 0 });
  expect(errors).toEqual([]);
});

test('completes the maze once and restarts', async ({ page }) => {
  const errors = [];
  await openGame(page, errors);
  for (const step of SOLUTION) {
    await pressAndSettle(page, KEY[step]);
  }

  await expect.poll(() => state(page)).toMatchObject({ status: 'won', row: 8, col: 16, win_count: 1 });
  await pressAndSettle(page, 'ArrowLeft');
  await expect.poll(() => state(page)).toMatchObject({ status: 'won', row: 8, col: 16, win_count: 1 });

  await pressAndSettle(page, 'r');
  await expect.poll(() => state(page)).toMatchObject({ status: 'playing', row: 2, col: 2, win_count: 0 });
  expect(errors).toEqual([]);
});

test('does not retain movement after focus loss', async ({ page }) => {
  const errors = [];
  await openGame(page, errors);
  await page.evaluate(() => window.dispatchEvent(new Event('blur')));
  await page.waitForTimeout(250);
  await page.evaluate(() => window.dispatchEvent(new Event('focus')));
  await page.waitForTimeout(250);
  await expect.poll(() => state(page)).toMatchObject({ row: 2, col: 2 });

  await pressAndSettle(page, 'ArrowRight');
  await expect.poll(() => state(page)).toMatchObject({ row: 2, col: 3 });
  await page.waitForTimeout(300);
  await expect.poll(() => state(page)).toMatchObject({ row: 2, col: 3 });
  expect(errors).toEqual([]);
});

for (const viewport of [
  { width: 1280, height: 720 },
  { width: 800, height: 600 },
  { width: 390, height: 844 },
]) {
  test(`keeps the canvas visible at ${viewport.width}x${viewport.height}`, async ({ page }, testInfo) => {
    await page.setViewportSize(viewport);
    const errors = [];
    await openGame(page, errors);
    const box = await page.locator('canvas').boundingBox();
    expect(box).not.toBeNull();
    expect(box.x).toBeGreaterThanOrEqual(0);
    expect(box.y).toBeGreaterThanOrEqual(0);
    expect(box.x + box.width).toBeLessThanOrEqual(viewport.width + 1);
    expect(box.y + box.height).toBeLessThanOrEqual(viewport.height + 1);
    expect(box.width / box.height).toBeCloseTo(16 / 9, 1);
    await testInfo.attach(`viewport-${viewport.width}x${viewport.height}`, {
      body: await page.screenshot(),
      contentType: 'image/png',
    });
    expect(errors).toEqual([]);
  });
}
