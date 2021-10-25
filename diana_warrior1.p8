pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--diana warrior

function _init()
	create_player()
 --create_enemies()
	init_msg()	
	
	end
	


function _update()
if not msg_list[1] then
 player_movement()
 end
 update_camera()
 update_msg()
 
end

function _draw()
cls()
 draw_map()
	draw_player()
--	draw_enemies()
	draw_ui()
	draw_msg()
	
end
-->8
--player

function create_player()
p={
  x=2,y=2,
  ox=0,oy=0,
  start_ox=0,start_oy=0,
  anim_t=0,
  sprite=33,
  pages=0,
  attack=false,
  }
  end
  
function draw_player()
 spr(p.sprite,
 p.x*8+p.ox,p.y*8+p.oy,
 1,1,p.flip)
 spr( id,x,y,1,1,true)


end
 
function player_movement()
 	newx=p.x
 	newy=p.y 
 
	if p.anim_t==0 then
	 newox=0
	 newoy=0
 end
 
 if btn(➡️) then
  newx+=1
  newox=-8
  p.flip= false 
 elseif btn(⬅️) then
  newx-=1
  newox=8
  p.flip= true
 elseif btn(⬆️) then
   newy-=1
   newoy=8 
 elseif btn(⬇️) then
   newy+=1
   newoy=-8
 end
 
 if btn(❎) then
 	p.attack=true
 	else p.attack=false 
 end
  
  
  
interact(newx,newy)
  
 if not check_flag(0,newx,newy)
 and(p.x!=newx or p.y!=newy) then
  	p.x=mid (0,newx,127)
 	 p.y=mid (0,newy,63)
 	 p.start_ox=newox
 	 p.start_oy=newoy
 	 p.anim_t=1
 end
  
  
  --animation
  --p.anim_t=max(p.anim_t-0.125,0)
  --p.ox=p.start_ox*p.anim_t
  --p.oy=p.start_oy*p.anim_t
  
	if p.anim_t>=0.5 then
 	 p.sprite=34
	else
 	 p.sprite=33
	end
  
 if btn(❎) then 
  	p.sprite=35
 end

end
  

function interact(x,y)
 if check_flag(1,x,y) then
  pick_up_pages(x,y) 
 elseif check_flag(2,x,y)
	and p.pages==3 then
  open_door(x,y)
 
end
  --message
 if x==20 and y==2 then
  sfx(3)
  start_dialogue("harceleur 1","diana","un petit sourire?","...","pourquoi tu fais la gueule","...","vas-y degage salope","fuck le patriarcat")
	end
	

end
	 
			
  
-->8
--map

function draw_map()
 map(0,0,0,0,128,64)
 	
 end
 
 function check_flag(flag,x,y)
  local sprite=mget(x,y)
  return fget(sprite,flag)
  end
  
 function update_camera()
 local camx=mid (0,p.x-7.5,127-15)
 local camy=mid (0,p.y-7.5,63-15)
 camera (camx*8,camy*8)
		end
		
		function next_tile(x,y)
		local sprite=mget(x,y)
		mset(x,y,sprite+1)
		end
		
		function pick_up_pages(x,y)
		next_tile(x,y)
		p.pages+=1
		sfx(1)
		end
		
		function open_door(x,y)
			--next_tile(x_y)
			local sprite=mget(x,y)
			mset(x,y,sprite+1)
			p.pages=3
			sfx(2)
	 end
	 

 

-->8
--interface utilisateur

function draw_ui()
camera()
 palt(0,true)
 spr(89,2,2)
 palt()
 print("X"..p.pages,10,2,7)
 end
-->8
--enemies



-->8
--message

function init_msg()
msg_list={}
current_speaker=""
pnj_name="harceleur 1"
player_name="diana"

end

function  create_msg(name,...)
	msg_title=name
	messages={...}
end 


function start_dialogue(pnj_name,player_name, ...)
current_speaker=pnj_name
pnj_name=harceleur
player_name=diana
msg_list={...}
end

function switch_speaker()
if current_speaker==pnj_name then
current_speaker=player_name

else
current_speaker=pnj_name
end
end


function update_msg()
if (btn(❎))then
deli(msg_list,1)
switch_speaker() 
--and messages2[1]
end
end


function draw_msg()
if msg_list[1] then
local y=100
rectfill(6,y,6+#current_speaker*4,y+8,1)
print(current_speaker,7,y+1,7)
rectfill(2,y+11,125,y+20,5)
rect(2,y+11,125,y+20,1)
print(msg_list[1],3,y+13,7)
end
end

__gfx__
0000000000000000333333333a3333333333333333333333444444449aa9aaa93333333366666666666666666666667433333365333333333333333333333333
000000000eeeee0033bba333a9a333333b33333333333333343434349aa9a9a93333333366666666666666666666665433333356333333333733333333344333
00700700eeeedee03babbb333a333333333333333333333334343434aa9aa9a93333333366666666666666666666665733333357333333337a73333333888833
00077000ed1dd1e03bbb8b33333333333333333333333333444444449a9aaaaa3333333366666666666666666666664533333365333333333733333333484833
00077000eedddde038b44b33333333a3333333b333333333333333339aaa9a9a3333333366666666666666666666664533333375070707333333333333888833
00700700eeccce0033b4b33333333a9a3b3333333333333333333333a9aa9a9a3333333366666666666666666666665733333357300070333333337333388333
00000000e077700033343333333333a3333333333333333333333333a9a9a9aa655765566666666645574554666666543333335633070733333337a733333333
000000000080800033343333333333333333b3333333333333333333aaa9a9aa5675576566666666547557456666667533333365337337333333337333333333
0000000033343333111111114444444444444444443444341111111c000000003333333333333333000000001111111133fffff3333333330000000000000000
00000000434333331111111166666666777777444344344311c111110000000033333bbbbbb3333300000000111111113335f5f3333333330000000000000000
00000000343333331111111111111111444444444434443411111c11000000003333bbbbbbbb33330000000011188111333ffff3333333330000000000000000
00000000334e33331111111111111111447777773443434411c1111100000000333bbbbabbbbb33300000000117117113ff5ff5f333333330000000000000000
0000000034e33333111111111111111144444444443344341111c1110000000033bbbbbbbbbbbb33000000001181181133555555333333330000000000000000
00000000eee4e4e31111111111111111777774444344434411c11111000000003bbbbbabbbbbbbb3000000001117711133f5ff5f333333330000000000000000
0000000033e34e3311111111111111114444444444434434c11111c1000000003bbbbbbbbbbbbbb3000000001111111133dddddd3fdf5f330000000000000000
000000003333333311111111111111114447777734444344111c11110000000033bbbbbbbbbabbbb0000000011111111333f33f333df5ff30000000000000000
00000000000000000000000000000000000000000000000000000000000000003bbbbbbbabbbbbb8000000000000000000000000000000000000000000000000
000000000eeeee000eeeee000eeeee000000000000000000000000000000000038bbbbbbbbbbbbb3000000000000000000000000000000000000000000000000
00000000eeeedee0eeeedee0eeeedee00000000000000000000000000000000033bbbabbbbbbbbb3000000000000000000000000000000000000000000000000
00000000ed1dd1e0ed1dd1e0ed1dd1e00000000000000000000000000000000033bbbbbbbbbbbb33000000000000000000000000000000000000000000000000
00000000eedddde0eedddde0eedddde00000000000000000000000000000000033bbbbbbbbbabb33000000000000000000000000000000000000000000000000
00000000eecccc000ecccc00eecccc0000000000000000000000000000000000338bbbbbbbbbb333000000000000000000000000000000000000000000000000
00000000e0777700e0777700e0777780000000000000000000000000000000003333bb444bb33333000000000000000000000000000000000000000000000000
00000000e0800800e008e000e0008000000000000000000000000000000000003333334443333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003333333443333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003333333443333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003333334443333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003333334443333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003333334443333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003333344444333333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003334444444433333000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000003444444444444333000000000000000000000000000000000000000000000000
66666666666666666607706655555555556765555567655566666666000000044444400055555555556665555555555555555555666666666666666600000000
66666666666666666600006655555555556665555566655566666666000000000000000055555555556765555555555555555555777777667777776600000000
66655666000000006607706666666666556765556667655566666666000000000000000055666666556665555555555555555555633336666888866600000000
66555566707070706600006676767676556665556766655566666666000000000000000055676676556766666666666666677666636636666866866600000000
655a5a56707070706607706666666666556765556667655566666666000000000000000055666666556666767676767676666667333333a6888888a600000000
65a5a556000000006600006655555555556665555555555566666666000000000000000055676555556766666666666666677666606660666066606600000000
65555a56666666666607706655555555556765555555555566666666000000000000000055666555555555555555555556666665777777667777776600000000
655a5556666666666600006655555555556665555555555566666666000000000000000055676555555555555555555556677665666666666666666600000000
655555566666666655556666666666666666666666666666000000003fffff33333333330fffff00333333333333333300000000000000000000000000000000
65a555566666666655555666665566666665566666666666000000003f666f33333333330ff6ff00333443333334433300000000000000000000000000000000
6555a556666666665a55a566655556666655556666666666000000003fffff3333333333066fff00334444333344443300000000000000000000000000000000
655a55566666666655a55a5655a55665665a5556666616660000000035fffff3333333330ffffff0344554433443544300000000000000000000000000000000
6a555a56666666665a5a55565a55a55a55555a55666111660000000033666ff33333333305f666f0345555433433554300000000000000000000000000000000
65a555566666666655555566555555555a55a5a5661111160000000033fff6f33333333300ffff6034a555433433a54300000000000000000000000000000000
655555a666666666a5555666555555a5555555556661116600000000335ffff333333333005ffff0545555465433554600000000000000000000000000000000
65566556666666665566666655665555555665556661116600000000333333333333333300000000645555456433554500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000666556666666666600000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000006655a5666655566600000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000065555556655a556600000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000055a5a5a55555555600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000a55a55a55a5a555600000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000055a5555555555a5600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000a555a5a5a5a5555600000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000055555555555a555600000000000000000000000000000000000000000000000000000000
__gff__
0000010000000000010001010101000000000101000001000101000109000000000000000000000001010000000000000000000000000000010100000000000001000000000000000000000000010100010000010100000200000500000000000000000000000000000000000000000000000000000000010100000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
05050505050505030e05050505050505050504050505050e0505040505040505050e050505050505050505050505050505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05040503050205050505050205050504030505050e05040504050505050504050505050e04050505050503050505050e05050505050505050505050505570c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05050505050504050505050503050505050505051c050505050504050e05050505040505050505030405050505040505050e0505050518190505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050403040d05050503050504050505040513131314131305050505050503050e05040505050e0505050405050304050405040405050528290505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050505050505050505050505040d050413121612141212131305050e0505050405050503050505040504050504050f050e050505050538390505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050e05030505050504050504050512121b151515151212050405050e04050e050e05050405050505050e0504050504040505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050205050505040d04050505050505030512121215151216120505050405050305050f050505050e05050305050e050305050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0503050403050505050505050305050505040512121512120505040e050e050505050e0504050405050505050305050505040405050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050405030505050e050505050504050e0512121512121305050505030504050305050505050504050504050d050405040505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050405050505050405050505050503050505131212151216121305050505050505050503050505050e0505050505050505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050404040e05050505050e030505050513131212121512121b121313131313130505050505050505050505050505050505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05050505040505050503050505131313121212151515151515151212121212121305050505050418190404050404050505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050503050505051312121216121515155715151515151212161212121305040e040528290505050503050505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02020205031819040505050505051b121212121515151515151512121212121205050505050505383905050e0505040505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05030505052829050405020202050505121612121212121212121212121212050505050505050505050405050405050505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0305050e053839050504050505050513121212121205051212121205050505050305050305040404040505050505050505050505050505050505050505050c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808085a0c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909440b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094009094009440b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909097753545053545053440b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094943434343434343450b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094454090909510909090b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094454094609090909090b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094454090909090909090b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094477090909090909090b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094477090909090909090b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094a4b4b4b4c4b4b4b4b4b520b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094e4d0909094d4e090b090b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094e4d0909094d4e090b550b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909094e4d0909094d4e090b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090946460909094d4e55550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a55550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000003105037050330502d050250501b0501505015050150501505016050000000000000000000000000000000000000000000000000000000000000000000000000000
00100000000001e05024050280502f05033050380503c0503f0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001c2501c2501c2501d2501e25020250212502225023250262502c250322503425033200322003220034200112000e2000c200072000420000200000000000000000000000000000000000000000000000
00100000000000000000000000000000000000000000000007350083500f350103501035010350083500835008350000000000000000000000000000000000000000000000000000000000000000000000000000
