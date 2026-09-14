const {test,expect}=require('@playwright/test');
const fs=require('node:fs');
const {decode}=require('./png.cjs');
const SOLUTION='UUUURRRRUURRUUUULLLLUULLUURRRRDDRRUU';
const KEY={U:'ArrowUp',D:'ArrowDown',L:'ArrowLeft',R:'ArrowRight'};
const state=p=>p.evaluate(()=>window.__THE_TRUE_PATH_STATE__);
async function openGame(page){
 const errors=[];
 page.on('pageerror',e=>errors.push(e.message));
 page.on('console',m=>{if(m.type()==='error'||/ERROR:SCRIPT|ERROR:GAMESYS/.test(m.text()))errors.push(m.text());});
 page.on('requestfailed',r=>errors.push(r.url()));
 await page.goto('/');await page.waitForFunction(()=>window.__THE_TRUE_PATH_STATE__?.version==='003');
 await page.locator('canvas').focus();return errors;
}
async function press(page,key){await page.keyboard.press(key,{delay:60});await page.waitForTimeout(210);}
async function shot(page,name){fs.mkdirSync('test/evidence',{recursive:true});await page.screenshot({path:`test/evidence/${name}.png`});}
test('keyboard movement, walls and immediate restart',async({page})=>{
 const errors=await openGame(page);
 expect(await state(page)).toMatchObject({row:16,col:2,status:'playing'});
 await press(page,'ArrowLeft');expect(await state(page)).toMatchObject({row:16,col:2,blocked_count:1});
 await press(page,'w');expect(await state(page)).toMatchObject({row:15,col:2});
 await page.keyboard.down('w');await page.waitForTimeout(60);await press(page,'r');await page.keyboard.up('w');
 expect(await state(page)).toMatchObject({row:16,col:2,moving:false,win_count:0});expect(errors).toEqual([]);
});
test('full route and one victory, repeatable restart',async({page})=>{
 const errors=await openGame(page);
 for(const s of SOLUTION)await press(page,KEY[s]);
 expect(await state(page)).toMatchObject({row:2,col:8,status:'won',win_count:1,moving:false});
 await shot(page,'003-victory');await press(page,'ArrowDown');expect((await state(page)).win_count).toBe(1);
 await press(page,'r');expect(await state(page)).toMatchObject({row:16,col:2,status:'playing',win_count:0});expect(errors).toEqual([]);
});
test('held key stops at focus loss and does not resume',async({page})=>{
 const errors=await openGame(page);await page.keyboard.down('w');await page.waitForTimeout(240);
 await page.evaluate(()=>window.dispatchEvent(new Event('blur')));await page.waitForTimeout(250);
 const stopped=await state(page);await page.evaluate(()=>window.dispatchEvent(new Event('focus')));await page.waitForTimeout(400);
 expect(await state(page)).toMatchObject({row:stopped.row,col:stopped.col,moving:false});await page.keyboard.up('w');expect(errors).toEqual([]);
});
for(const viewport of [{width:390,height:844},{width:360,height:640},{width:844,height:390},{width:1280,height:720},{width:800,height:600}]){
 test(`camera and canvas ${viewport.width}x${viewport.height}`,async({page})=>{
  await page.setViewportSize(viewport);const errors=await openGame(page);const box=await page.locator('canvas').boundingBox();
  expect(box.width).toBeCloseTo(viewport.width,0);expect(box.height).toBeCloseTo(viewport.height,0);
  await page.keyboard.down('w');await page.waitForTimeout(70);
  const s=await state(page);expect(s.hero_x).toBe(s.camera_x);expect(s.hero_y).toBe(s.camera_y);
  const render=await page.evaluate(()=>window.__TTP_RENDER__);expect(render.target_count).toBe(2);
  // Inspect actual rendering too: correct state cannot pass with a blank canvas.
  await page.keyboard.up('w');await page.waitForTimeout(220);
  const pixels=decode(await page.locator('canvas').screenshot());
  const center=pixels.pixel(pixels.width/2,pixels.height/2);expect(center.reduce((a,b)=>a+b,0)).toBeGreaterThan(35);
  await page.keyboard.up('w');await page.waitForTimeout(220);await shot(page,`003-${viewport.width}x${viewport.height}`);expect(errors).toEqual([]);
 });
}
test('mobile touch hold, drag out, multitouch, cancel and restart',async({browser})=>{
 const context=await browser.newContext({viewport:{width:390,height:844},hasTouch:true,isMobile:true});const page=await context.newPage();
 const errors=await openGame(page);const cdp=await context.newCDPSession(page);
 const send=(type,points)=>cdp.send('Input.dispatchTouchEvent',{type,touchPoints:points});
 const up={x:100,y:686,id:1};await page.touchscreen.tap(up.x,up.y);await page.waitForTimeout(220);
 expect(await state(page)).toMatchObject({row:15,col:2});
 await send('touchStart',[up]);await page.waitForTimeout(250);await send('touchMove',[{...up,x:260,y:650}]);await page.waitForTimeout(250);
 const stopped=await state(page);await page.waitForTimeout(300);expect((await state(page)).row).toBe(stopped.row);await send('touchEnd',[]);
 await page.touchscreen.tap(348,802);await page.waitForTimeout(250);expect(await state(page)).toMatchObject({row:16,col:2});
 await send('touchStart',[up]);await page.waitForTimeout(60);await send('touchStart',[up,{x:158,y:744,id:2}]);await page.waitForTimeout(250);
 await send('touchCancel',[]);await page.waitForTimeout(220);const cancelled=await state(page);await page.waitForTimeout(300);expect((await state(page)).row).toBe(cancelled.row);
 expect(await page.evaluate(()=>window.scrollY)).toBe(0);expect(errors).toEqual([]);await context.close();
});
