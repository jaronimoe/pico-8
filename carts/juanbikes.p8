pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- juan bikes
-- (c) jaronimoe

scrn = {}
p1 = {}
p1.x = 64
p1.y = 64
p1.dir = 3
p1.sprtcnt = 0
t = 0
t_cnt = 30
t_hide = 10
sound = 1 --play pause sound

colpath = {}
colpath.cnt = 0
colpath.pathx = {}
colpath.pathy = {}

function _init()
 cls()
	show_menu()
end

function show_menu()
	scrn.upd = update_menu
	scrn.drw = draw_menu
end

function draw_menu()
 cls()
	spr(0,0,0,20,20)
	print("b      i      k      e      s",5,45,14)
	rectfill(0,54,128,74,2)
	t+=1
	if(t<t_cnt)	print("press x to start", 30, 62, 3) sound=0
	if(t>t_cnt) rectfill(0,74,128,54,2) sound=1
	if(t==t_cnt+t_hide) t=0
	if(sound==1 and  t<t_cnt) sfx(0,0,0)
end

function update_menu()
  -- button 5 == X
	if(btnp(5)) run_game() sfx(1,0,0)
end

function run_game()
 cls()
 --setup game screen & player
 rect(0,0,127,127,9)
 p1.x = 64
 p1.y = 64
 p1.dir = 3
 scrn.upd = update_game
 scrn.drw = draw_game
	sfx(4,1,0)
end


function update_game()
 if(btnp(5)) show_menu()

 -- buttons 0, 1 = left, right arrow keys
 if(btnp(1)) p1.dir-=1 sfx(3,0,0)
 if(btnp(0)) p1.dir+=1 sfx(3,0,0)
 if(p1.dir < 1) p1.dir=4
 if(p1.dir > 4) p1.dir=1
-- if(btnp(2)) p1.dir+=1
-- if(btnp(3)) p1.dir+=1

 if(p1.dir==1) p1.y+=1
 if(p1.dir==2) p1.x+=1
 if(p1.dir==3) p1.y-=1
 if(p1.dir==4) p1.x-=1

colpath.pathx[colpath.cnt] = p1.x
colpath.pathy[colpath.cnt] = p1.y
colpath.cnt += 1

--collision
	--if(pget(p1.x,p1.y)!=0) sfx(2,1,0) show_gover()

p1.sprtcnt += 1
if(p1.sprtcnt > 2) p1.sprtcnt = 0

end

function draw_game()
	--pset(p1.x,p1.y,3)
  cls()
   for i=0,colpath.cnt do
     pset(colpath.pathx[i],colpath.pathy[i],3)
   end
  spr(p1.sprtcn,p1.x-4,p1.y-4)
end


function show_gover()
	scrn.upd = update_menu
	scrn.drw = draw_gover
 anim=0
end

anim_col=0
circs = {0,-10,-20,-30,-40,-50,-60,-70,-80}
num_circs = 9
circle = {}
circle.rad = 10
circle.current = 0

function draw_gover()
--todo: smaller circles should be drawn last
 for i=1,num_circs do
   circfill(p1.x,p1.y,circle.current,i)
   circle.current+=1
   if(circle.current > circle.rad) circle.current = 0
 end
--	anim+=1
--	anim_col+=1
--	twait+=1
--	if(anim_col>16) anim_col=0
end

--function circspawn()
	--circfill(x,y,rad,col)
--end




function _update()
	scrn.upd()
end

function _draw()
	scrn.drw()
end


__gfx__
00055000000550000005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00333300003333000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00333300003333000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00344300003443000034430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00f44f0000f44f0000f44f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00fccf0000fccf0000fccf0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055000000550000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055000000660000005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088800000000000000088800
00000000000000000888888888888888888888888880000000000000000000000000000088800000000000000000000000000000088800000000000000088800
00000000000000000888888888888888888888888880000000000000000000000000000088888000000000000000000000000000088880000000000008888800
00000000000000000888888888888888888888888880000000000000000000000000000088888800000000000000000000000000888880000000000088888800
00000000000000000888888888888888888888888000000000000000000000000000000088888800000000000000000000000000888880000000000088888800
00000000000000000888880000008888888888800000000000000008888000000000000088888880000000000000000000000000888880000000000888888800
00000000000000000000000000008888888880000000000000000008888888800000000088888880000000000000000000000000888888000000000888888800
00000000000000000000000000000888888880000888000000000008888888800000000088888888000000000000000000000008888888800000008888888800
00000000000000000000000000000888888800008888000000000008888888800000000088888888000000000000000000000008888888800000008888888000
00000000000000000000000000000888888800008888000000000008888888800000000088888888000000000000000000000088888888880000008888888000
00000000000000000000000000000888888800008888000000000008888888800000000088888888800000000000000000000088888888888000008888880000
00000000000000000000000000000888888000008888000000000008888888800000000888808888880000000000000000000888888888888800008888880000
00000000000000000000000000008888888000008888000000000008888888800000000888800888888000000000000000008888880888888800088888880000
00000000000000000000000000008888888000008888000000000000888888800000008888800088888800000000000000088888880088888880088888880000
00000000000000000000000000008888888000008888000000000000888888800000008888000008888800000000000000888888880088888880088888880000
00000000000000000000000000088888888000008888000000000008888888800000088888000008888880000000000000888888800088888888088888800000
00000000000000000000000000088888888000008888000000000008888888800000088880000000888888000000000000888888800008888888088888800000
00000000000000000888800000088888888000008888000000000008888888800000088880000000888888000000000008888888000000888888888888800000
00000000000000000888880000888888880000008888000000000088888888000000888800000000008888800000000008888888000000088888888888800000
00000000000000000888888008888888880000008888800000000088888888000000888800000000008888880000000088888880000000008888888888800000
00000000000000000888888008888888800000008888880000088888888888000008888888888888888888880000000088888880000000000888888888000000
00000000000000000088888888888888000000008888888888888888888880000088888888888888888888888000000088888800000000000088888888000000
00000000000000000088888888888880000000000888888888888888888800000088888888888888888888888000000888888800000000000088888888000000
00000000000000000008888888888880000000000888888888888888888000000888888888888888888888888800000888888000000000000088888888000000
00000000000000000000888888088800000000000008888888888888880000000888800000088888800008888800000888888000000000000008888888000000
00000000000000000000000000000000000000000000008888888888800000000888800000088880000000888880000888000000000000000000888888000000
00000000000000000000000000000000000000000000000888888800000000000888000000000000000000888880000000000000000000000000888888000000
00000000000000000000000000000000000000000000000008888800000000000888000000000000000000088880000000000000000000000000088800000000
00000000000000000000000000000000000000000000000008888000000000000000000000000000000000008880000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000888000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000500000401004020050300704008050090600807009070090700907009070090700907009070090700907009070090700907007070060700606004050040400403001020000100000000000000000000000000
0002000000000202001e2001247014470154700d2000d2001e200212001b4701e470152000000000000000001d2001b20024470264702a4701120014200152001f200222002d4703247020200000000000000000
00030000000003267032670306702e6702c6702a67028670256701f670216701e6701d6701b6701b670176701367010670106700c6700f6701267013670176501b64020630256202262000000000000000000000
00030000000001b2702727029270292702d2702d27000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100050f2200f2200a2200f2200f220000000000000000000003620000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
