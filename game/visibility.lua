-- Geometry only: usable in headless tests without engine globals.
local M = {}
local atan2 = math.atan2
function M.edges(maze, tile)
    local edges = {}
    local function add(x1,y1,x2,y2) edges[#edges+1]={x1,y1,x2,y2} end
    for row=1,maze.height() do for col=1,maze.width() do
        if not maze.is_walkable(row,col) then
            local x,y=(col-1)*tile,(maze.height()-row)*tile
            if maze.is_walkable(row+1,col) then add(x,y,x+tile,y) end
            if maze.is_walkable(row-1,col) then add(x,y+tile,x+tile,y+tile) end
            if maze.is_walkable(row,col-1) then add(x,y,x,y+tile) end
            if maze.is_walkable(row,col+1) then add(x+tile,y,x+tile,y+tile) end
        end
    end end
    -- Merge touching collinear segments without changing their boundary.
    local changed=true
    while changed do
        changed=false
        for i=1,#edges do
            local a=edges[i]
            for j=i+1,#edges do
                local b=edges[j]
                if a[2]==a[4] and b[2]==b[4] and a[2]==b[2] and a[1]<=b[3] and b[1]<=a[3] then
                    a[1],a[3]=math.min(a[1],b[1]),math.max(a[3],b[3]);table.remove(edges,j);changed=true;break
                elseif a[1]==a[3] and b[1]==b[3] and a[1]==b[1] and a[2]<=b[4] and b[2]<=a[4] then
                    a[2],a[4]=math.min(a[2],b[2]),math.max(a[4],b[4]);table.remove(edges,j);changed=true;break
                end
            end
            if changed then break end
        end
    end
    return edges
end
function M.distance(x,y,dx,dy,edges,radius)
    local nearest=radius
    for _,e in ipairs(edges) do
        local ex,ey=e[3]-e[1],e[4]-e[2]
        local cross=dx*ey-dy*ex
        if math.abs(cross)>1e-9 then
            local qx,qy=e[1]-x,e[2]-y
            local t=(qx*ey-qy*ex)/cross
            local u=(qx*dy-qy*dx)/cross
            if t>=0 and t<nearest and u>=-1e-8 and u<=1+1e-8 then nearest=t end
        end
    end
    return nearest
end
function M.polygon(x,y,edges,radius,wall_band)
    local nearby,angles={},{}
    for _,e in ipairs(edges) do
        local nx=math.max(math.min(e[1],e[3]),math.min(x,math.max(e[1],e[3])))
        local ny=math.max(math.min(e[2],e[4]),math.min(y,math.max(e[2],e[4])))
        if (nx-x)^2+(ny-y)^2<=(radius+16)^2 then
            nearby[#nearby+1]=e
            for k=1,3,2 do
                local a=atan2(e[k+1]-y,e[k]-x)
                angles[#angles+1]=a-0.0001;angles[#angles+1]=a;angles[#angles+1]=a+0.0001
            end
        end
    end
    for i=0,95 do angles[#angles+1]=-math.pi+i*2*math.pi/96 end
    table.sort(angles)
    local points={}
    for _,a in ipairs(angles) do
        local dx,dy=math.cos(a),math.sin(a)
        local d=M.distance(x,y,dx,dy,nearby,radius)
        d=math.min(radius,d+(wall_band or 0))
        points[#points+1]={x+dx*d,y+dy*d}
    end
    return points
end
function M.intensity(d,r)
    local q=math.max(0,math.min(1,(d/r-0.65)/0.35))
    return (1-0.55*math.min(1,d/r))*(1-q*q*(3-2*q))
end
return M
