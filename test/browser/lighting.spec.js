const {test,expect}=require('@playwright/test');
const {decode}=require('./png.cjs');
for(const viewport of [{width:720,height:720},{width:390,height:844}]){
 test(`actual radial light pixels ${viewport.width}x${viewport.height}`,async({page})=>{
  await page.setViewportSize(viewport);await page.goto('/lighting/');await page.waitForFunction(()=>window.__TTP_LIGHT_READY__);await page.waitForTimeout(150);
  const png=decode(await page.locator('canvas').screenshot());const scale=Math.min(png.width,png.height)/720,cx=(png.width-1)/2,cy=(png.height-1)/2;
  for(const distance of [80,160,230,270]){
   const samples=[[1,0],[0,1],[-1,0],[0,-1]].map(([x,y])=>png.pixel(cx+x*distance*scale,cy+y*distance*scale));
   for(let c=0;c<3;c++)expect(Math.max(...samples.map(p=>p[c]))-Math.min(...samples.map(p=>p[c]))).toBeLessThanOrEqual(3);
  }
  const dark=png.pixel(cx,cy+330*scale);expect(dark).toEqual([3,5,6]);
  await page.screenshot({path:`test/evidence/003-light-${viewport.width}.png`});
  await page.goto('/lighting/?wall=1');await page.waitForFunction(()=>window.__TTP_LIGHT_READY__);await page.waitForTimeout(150);
  const wall=decode(await page.locator('canvas').screenshot());expect(wall.pixel(cx+140*scale,cy)).toEqual([3,5,6]);expect(wall.pixel(cx-140*scale,cy)[0]).toBeGreaterThan(60);
 });
}
