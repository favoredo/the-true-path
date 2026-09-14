// Minimal read-only decoder for Chromium's non-interlaced 8-bit screenshots.
const zlib=require('node:zlib');
exports.decode=function(png){
 let width,height,channels;const chunks=[];
 for(let at=8;at<png.length;){const n=png.readUInt32BE(at),type=png.toString('ascii',at+4,at+8),data=png.subarray(at+8,at+8+n);at+=n+12;
  if(type==='IHDR'){width=data.readUInt32BE(0);height=data.readUInt32BE(4);if(data[8]!==8||data[12]!==0)throw Error('Unsupported PNG');channels=data[9]===6?4:data[9]===2?3:0;if(!channels)throw Error('Unsupported color');}
  if(type==='IDAT')chunks.push(data);
 }
 const raw=zlib.inflateSync(Buffer.concat(chunks)),stride=width*channels,out=Buffer.alloc(height*stride);
 const paeth=(a,b,c)=>{const p=a+b-c,pa=Math.abs(p-a),pb=Math.abs(p-b),pc=Math.abs(p-c);return pa<=pb&&pa<=pc?a:pb<=pc?b:c;};
 for(let y=0;y<height;y++){const f=raw[y*(stride+1)];for(let x=0;x<stride;x++){const left=x>=channels?out[y*stride+x-channels]:0,up=y?out[(y-1)*stride+x]:0,ul=y&&x>=channels?out[(y-1)*stride+x-channels]:0;let v=raw[y*(stride+1)+1+x];v+=f===1?left:f===2?up:f===3?Math.floor((left+up)/2):f===4?paeth(left,up,ul):0;out[y*stride+x]=v&255;}}
 return {width,height,pixel(x,y){const p=(Math.round(y)*width+Math.round(x))*channels;return [...out.subarray(p,p+3)];}};
};
