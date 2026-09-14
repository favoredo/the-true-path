local M={}
local buffers={}
function M.quad(vertices,x,y,w,h,z,index,columns,rows)
    columns,rows=columns or 4,rows or 4
    local col,row=(index-1)%columns,math.floor((index-1)/columns)
    local inset=0.004
    local u0,u1=col/columns+inset,(col+1)/columns-inset
    local v0,v1=1-(row+1)/rows+inset,1-row/rows-inset
    local points={{x-w/2,y-h/2,u0,v0},{x+w/2,y-h/2,u1,v0},{x+w/2,y+h/2,u1,v1},{x-w/2,y+h/2,u0,v1}}
    for _,i in ipairs({1,2,3,1,3,4}) do
        local p=points[i];vertices[#vertices+1]={p[1],p[2],z,p[3],p[4]}
    end
end
function M.upload(path,vertices)
    local cached=buffers[path]
    if not cached or cached.count~=#vertices then
        cached={count=#vertices,buffer=buffer.create(#vertices,{{name=hash('position'),type=buffer.VALUE_TYPE_FLOAT32,count=3},{name=hash('texcoord0'),type=buffer.VALUE_TYPE_FLOAT32,count=2}})}
        buffers[path]=cached
    end
    local b=cached.buffer
    local p=buffer.get_stream(b,'position');local uv=buffer.get_stream(b,'texcoord0')
    for i,v in ipairs(vertices) do
        p[(i-1)*3+1]=v[1];p[(i-1)*3+2]=v[2];p[(i-1)*3+3]=v[3]
        uv[(i-1)*2+1]=v[4] or 0;uv[(i-1)*2+2]=v[5] or 0
    end
    resource.set_buffer(path,b)
end
return M
