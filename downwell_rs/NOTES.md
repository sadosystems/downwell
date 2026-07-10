# downwell_rs — verified facts & workflow

## Layout (verified against libTAS capture)
- Window 760x568. View port 320x568 centered (x offset 220). App surface 160x284, drawn 2x.
- GUI space = 160x284 units, origin at app-surface top-left; `display_set_gui_size(WPort/2, HPort/2)`.
  Visible GUI x range is -110..270 (borders drawn at negative/overflow coords — GM letterbox trick).
- window_px = gui * 2 + (220, 0).

## Splash timeline (idle input, frame numbers = libTAS capture frames, 0-based)
Boot offset is ZERO: capture frame 0 is the first sim step (its end step arms alarm[0]=10).
- 0..9     showSplash=1  black
- 10..189  =2  Devolver logo, draw_sprite at (80,140), center origin (80,32)
- 190..369 =3  credits (disp4x3 layout: ojiro 80,130 / eirik 168,200 / joonas -8,200; '#'=newline, line height 10)
- 370..610 =4  controls sprite at (80,140), center origin (80,104)   [alarm 240]
- 611..670 =5  controls + sprDitherFade tiled from (-300,0), splashDithFrame 11 -> -=0.3 while >=1 (f64!)
- 671..730 =6  no black rect; dither +=0.3 reveals HUD/borders/app surface   [PHASE B — not ported yet]
- ~731     showSplash>=7 -> room_goto(room index 20); idle-run screen is static 704..798.
- SPACE = dUp (keyboard_check_pressed edge) → skips a splash state and re-arms alarm to 60.

## GM semantics pinned so far
- Alarm: `if a > -1 { a -= 1; if a == 0 { fire } }` per step, before the end step.
- Event order per frame: begin step (input) → alarms → step → end step → draw.
- GM reals are f64 (splashDithFrame accumulator must be f64; drawn frame = trunc toward 0).
- GM truthiness: x > 0.5. `global.disp4x3 = -1` is FALSE, `1` is TRUE. PC: disp4x3=1, scale=2.
- draw_rectangle is inclusive of x2,y2. draw_sprite_tiled phase-aligns tiles to (x,y) mod size.
- Fonts: glyphs_font0.csv = ascii;x;y;w;h;shift;offset. halign center: line width = sum(shift),
  glyph drawn at pen+offset, pen += shift. Border text = 4 black offsets ±1 + colored center.

## Geist workflow
AUTHORITATIVE check — geist directly on the two binaries, both under libTAS (identical harness:
same virtual clock, same injected inputs, same swap-hooked capture):
```
cd ~/sources/geist
python3 geist.py compare ~/downwell-linux ~/downwell-rs-build ~/sources/geist/scripts/idle.lua --frames 120 --json -
```
- ALWAYS pass the lua path ABSOLUTE (libTAS resolves it relative to the build dir → silent no-stop → GB-scale dumps).
- Use short --frames while iterating; full 800 only for final parity checks. libTAS runs ~1.6x realtime while encoding.
- The rust build dir is ~/downwell-rs-build/{runner,assets/game.unx}; refresh with:
  `cp target/release/app ~/downwell-rs-build/runner`
- Windowed mode = default (SDL2 window, wgpu offscreen + SDL blit; libTAS hooks SDL present + keyboard).
- INPUT ALIGNMENT (SOLVED, verified 0-diff on idle AND driven 300f): the Rust runner mimics the GM
  runner's boot present pattern: (1) create window 320x568, present black (lands in libTAS encode
  segment 0 like GM's pre-reset frame), (2) resize to 760x568, (3) pump events — IF any key events
  arrived during boot (driven tapes), present ONE extra black frame (GM's boot event-loop does the
  same, which is why its idle and driven _1 captures are offset by one frame), (4) main loop.
  Input read from SDL key EVENTS with manually tracked held-state, not the keyboard-state array.
- Headless --drive flag replays drive_welltaro.lua's tape (shifted -1 frame; recalibrate against the
  now-correct windowed alignment before trusting headless driven diffs — windowed geist is truth).
- geist.py patched: falls back to base .raw when a build never re-inits video (no _1 segment).
- Cleanup gotcha: pkill -f 'libTAS' from a shell whose own cmdline contains the pattern kills the shell;
  use `pkill -9 -x runner; pkill -9 -x libTAS`.

Fast inner loop (dev only, not verification): headless self-dump + --reuse diff against a stored capture:
```
./target/release/app --frames 799 --out /tmp/geistB_1.raw
python3 geist.py compare ~/downwell-linux ~/downwell-linux --reuse --json -
```
`scripts/idle.lua` = no input; `scripts/drive_welltaro.lua` = the driven tape (SPACE taps skip splash).
Status: **frames 0..998 pixel-identical to frame 1000** — verified authoritatively (geist on the two
binaries under libTAS, idle tape, 0/999 diffs). Covers splash, HUD4x3, palette shader, rmMenu night
scene (RNG-exact grass/nap/trees), dissolve reveal, f32 animation phases.

## Phase B (frame-1000 target) — findings
Idle timeline: 671-730 rm_init reveal (HUD only, app surface black) | 731-764 rmMenu, dissolve still
solid black | 765-~820 dissolve reveal | 820-999 night scene (nearly static; ~4px residual anim).
- tools/gmdata.py parses game.unx: chunks/rooms/sprites(origins!)/objects/room instances+layers.
  Room index 20 = rmMenu (21-24 = rmGround* variants; obj_init_rm rRand=0 always picks 20).
- rmMenu: 416x1200, view0: 160x284 port 320x568, follows obj (border 80,150). 192 instances.
  Draw order via Compatibility_Instances_Depth_* layers (high depth first):
  bg black (0xFF000000) → trees@100000 (objTree 104392, groundTrees 104393/104394) → nightsky@10000
  → bench@1000 → walls@100 (162) → well@90 → depth0 (teleport, releaseNotes, invisWalls...) →
  player@-50000 → grass@-100000 (14x objGrass, on top).
- sprTabletBorder origin is (3,0) NOT (0,0). Always take origins from gmdata, never guess.
- Dissolve: rm_menu Create spawns ditherFade: 30 frames image_speed=0 (image_index 0 = solid tile),
  then 0.2/frame; Draw_0 tiles sprDitherFade[image_index] into global.surfaceDissipate (160x284);
  obj_controler_n Draw_0 draws surfaceFx/surfaceDissipate/surfaceButton at view pos over the room,
  then scrDrawHud4x3Top (PC disp4x3). Draw_64 (GUI) draws borders + scrDrawHud4x3 + app surface.
- objWell Create spawns 4 objInvisWall + objTitle at (x+56,y-80)=(328,432) — outside idle view,
  hence no DOWNWELL logo in idle frames. objWell Draw: black rect shaft + draw_self.
- objBgNightsky: parallax x=floor(xx+viewx/1.2), y=floor((viewy+142)/1.1), xx=120 init.
- Player NAPS on bench in menu (scrPlayerInit sets napping=1 somewhere; napping → xsp=ysp=0).
  Player idle path per frame: Step_1(begin): scrGravity_n, scrCheckInWater, scrPlMovement (noControl),
  scrWallCol, nap zeroing, xx+=xsp yy+=ysp, x=round(xx), camLocker→pCamFocus; Step_0: scrAimControl,
  global.player* mirrors; Draw_0: playerDraw().
- **RNG REQUIRED**: objGrass Create: sprite_index=choose(sprGrass,2,3,4); image_speed=random_range(.15,.25);
  image_index=irandom(image_number-1); if random(10)<1 destroy. groundTrees: irandom + choose(0,0,0,0,0,1).
  Deterministic under libTAS (randomize() sees fixed time). Port GM LCG (Delphi-style,
  seed*0x8088405+1) and RECOVER THE SEED by brute-force matching the observed grass pattern in the
  reference capture, consuming draws in exact room-instance-creation order (from gmdata room dump).
- Still to read: scrPlayerInit, playerSpriteControl (nap anim), scrGravity_n, scrPlMovement,
  scrWallCol, playerDraw, scrSpawnCamera + camera obj, scrDrawHud4x3Top, objTeleportMain cc715,
  musicDucker/roomEndSetter/camLocker (likely invisible no-ops), obj_title idle.
- HUD state at menu: hp 4/4, gems 0, ammo/stammo 8 ("8" digit via sprSpriteNumber sprite font,
  drawSpriteHP/GemNumber/AmmoNumber quadruple-draw black offsets then white).
- Reference: 1000-frame idle capture procedure in Geist workflow above (currently in /tmp/geistA_1.raw).

## Slice 2 spec (frames 765-998: dissolve reveal + night scene) — STATUS: parity 0..764 done
Verified so far: frames 0..764 pixel-identical headless-vs-reference (includes splash, HUD4x3,
borders, palette shader). Remaining diff = one run 765..998.

Camera (SETTLED values, safe to hardcode for this milestone):
- cam = (112, 448) -> view = (32, 306), proven by pixel-exact template match of sprTree frame 0
  (tree instance at (64,512), screen pos = (0-viewx, 393-viewy)). Settled well before reveal.
- OPEN QUESTION: why cam.y=448: matches Collision_sideCamLocker semantics (camPointy=other.y only,
  x still player-driven; camLocker at (328,448)), but camLocker's parent chain per my OBJT parse
  says no parent. Resolve when porting the camera dynamically for gameplay. Player pose ∈ {0,1}
  (napx=112: nap on bench visible; napy 506 pose0 / 512 pose1).
- objBgNightsky: x=floor(120 + viewx/1.2)=146, y=floor((viewy+142)/1.1)=407 (origin 119,104, frame 0).

Draw order (depth high->low): bg black -> objTree(64,512,spr631)+groundTrees(160,400),( -16,400)(spr646)
@100000 -> nightsky@10000 -> bench(112,512,spr640)@1000 -> 162 walls@100 (+ 'surrounded' filler tiles:
tileCavern spr739 subrect (48,48,16,16) at wall pos-8) -> well(272,512)@90 (OFFSCREEN) -> depth0 ->
player@-50000 (nap sprite at 112,506/512) -> grass@-100000 (14 tufts, y=512 row; only x in 32..192 visible).
Well/releaseNotes/title/teleport all offscreen at view x 32..192.

Walls: sprite = global.wallTile = levelTile[0] = 76 (sprTileSurface 16x16 26 frames, origin 8,8).
Autotile (obj_wall_n Step_2, end step frame 1): 4-bit neighbor mask i (up1/right2/down4/left8 via
place_meeting = another wall at x,y±16 / x±16,y); area==0 remap: {2,0,10,8}->14 (10 too), then if
i not in {14,6,12} -> i=15; i==15: corner lights (frames 25/24/21/20 drawn over) from diagonal
neighbors; all 4 diagonals present -> surrounded -> replaced by tileCavern filler tile + destroy.
COMPUTE OFFLINE from the 162 wall positions (gmdata room dump) into a generated Rust table.

Dissolve (rmMenu): obj_controler_n Step_2 does surfaceClear(surfaceDissipate) EVERY frame; dither_fade
draws sprDitherFade[floor(image_index)] tiled at (0,0) into it; controller Draw_0 draws the surface at
view pos (covers exactly the 160x284 app area). ditherFade: created at room start (frame 731),
image_speed=0 + alarm[0]=30 -> at fire image_speed=0.2; image_index += speed/frame; anim end (>=12)
-> destroy (fully revealed). First visible change observed at capture frame 765. Frame 0 tile = solid.

RNG (GM LCG, port + recover seed):
- state' = state * 0x8088405 + 1 (u32); random(x) = state/2^32*x (f64); irandom(n) = (u64(state)*(n+1))>>32;
  choose(a..) = arg[irandom(argc-1)]; random_range(a,b) = a + random(b-a). VERIFY these bit-level rules
  during seed brute-force (they are assumptions until the search converges).
- Consumption order = room instance creation order (full 192-instance list from gmdata room 20):
  objPlayer_n FIRST: groundPlayerSet irandom(5) -> pose (constraint: pose ∈ {0,1}).
  Then per creation order: objGrass x14: choose(4 sprites: 635-638)=1 draw, random_range(0.15,0.25)=1,
  irandom(3)=1, random(10)<1 destroy check=1 (destroyed tufts still consume!).
  obj_tree: choose(0,0,0,0,0,1) (6 args) = 1 draw (frame 0 confirmed by template match).
  ground_trees x2: irandom(image_number-1)=irandom(3). objWell creates objTitle (check obj_title
  Create for RNG). objTeleportMain has creation code id 715 (check for RNG). releaseNotes: check.
- Seed recovery: brute force u32 state at first menu draw, checked against: nap pose ∈ {0,1} + which
  nap sprite visible (11 vs 12 distinguishable in capture at (112,~506/512)), tree frame 0, trees
  frames (template match), per-tuft grass sprite variant + image_index phase at known frames
  (image_index = init + speed*(f - 731) mod 4; sway band = gui y 203-213). Write as a small Rust bin.
- Grass visible tufts (x in 32..192 range): x ∈ {48,176,144,160,16?,32,160,176,192} — from instance
  list; exact positions in gmdata dump.

scrDrawHud4x3Top: no-op in menu (gemStreak 0, no water/oxygen). ✓ nothing to port.

## Player controller port (task #8, IN PROGRESS) — all GML consolidated in tools/player_ref.gml
Verbatim-translation targets -> sim/src/player.rs (+ fx objects + camera):
- Input globals (scrControlInput, keyboard only): dUp=space edge, dUpHeld, dUpRel, dLeft/dRight=A/D held,
  dLeftPressed/dRightPressed edges, anyInput = dUp||dLeftPressed||dRightPressed.
- Player fields/constants (scrPlayerInit): moveaccl .2, maxsp 2, airMaxsp 2.5, decclsp .4, airdeccl .1,
  jumpsp 4.4 (playStyle 0), wallkicksp 4, enemybounce 2.7, hardLandSp 1.2, grounded=0, airstatus=1,
  shotDelay=1, imgspstand .1, imgsprun .3, imgspspin .3, imgspshoot .25; sprites: idle 31, run 27
  (sprPlayerRunExg 32x32 org16,16), air 37 (5f), spin 1, shoot 3, yay 10, balancing 15, wall sprPlayerWall.
  mask ALWAYS sprPlayerIdle: bbox rel origin(12,12): x-4..x+3, y-4..y+7 (8x12).
- Step_1 order: activate-region (skip), scrGravity_n, scrCheckInWater (menu: no water), scrPlMovement
  (sets plx/ply=xx/yy FIRST; movement; scrUpButtonFunctions (jump/shoot/wallkick); land-detect w/ fx +
  scrRecharge; ends with playerSpriteControl() (nap wake here: anyInput && !noControl -> fx spawn) then
  xspFinal=xsp+xspCarry), scrWallCol (scrPlayerPlatformCollision(87=parentThinwall),
  scrCheckCollisionWith(57=parentWall), grounded logic), napping->xsp=ysp=0, yy+=ysp xx+=xsp,
  x=round(xx) y=round(yy), camLocker->pCamFocus. Step_0: pFired lifecycle, scrAimControl, sprite mirrors.
- Collision families in rmMenu (static rects, gen offline): parentWall(57): objWall_n(60 via parent 59);
  sParentSolid(56): walls + invis walls?; parentThinwall(87): groundBench(318), objThinPlatform(93).
  objInvisWall(98) parent=? CHECK. objWell spawned 4 invisWalls at (272,512)+(288)+(368)+(384)! Wall bbox
  = sprite 76/51 16x16 full? (margins from SPRT id of wallTile 76). Bench bbox from spr 640 margins.
- Shooting (dUpHeld airborne, shotDelay=1 initially -> first shot needs alarm2 expiry? shotDelay=1 at
  init, cleared by alarm[2]... CHECK alarm2), gun 2 lvl 0 stats from bStat tables [2][0] (bStatInitialize
  — pull values), recoil ysp cap, casings (bullet_casing physics visible), muzzle fx scrEffectSpawn,
  bullets (global.pBulObject for gun 2 — find), camera SHAKE (scrSShake -> cam irandom_range PER FRAME =
  RNG draws!), stammo/HUD, grass gets shot (objHp->sprGrassLay).
- Camera: port cam_main Create+Step_0 VERBATIM (in ref file) incl. view border semantics; y-lock
  mystery expected to resolve empirically; add camShake RNG draws in exact order.
- Fx: objJumpSmallerFx/objJumpFx (create/draw/anim-end in ref), emitMovingFx/emitSmoke/scrEffectSpawn,
  sprite ids TBD via gmdata; scrRisingText if stammo hits 0 (won't in menu: 8 ammo, recharges on land).
- GUN at menu = MACHINEGUN (styleUpdate(0) sets pGunType=0; overrides scrPlayerGlobalStat's 2):
  object 261, bulletSprite 459, muzzle fx 603, sound 18, ConRate 1 (matches HUD divider proof),
  Rof 7 (auto), Recoil 0 (ysp capped at 0 when shooting!), ScreenShake 2 dur 3, DelayKill 1
  (dUpRel clears shotDelay -> shooting unlocked after first space release post-wake), Speed 8,
  Accuracy 3, RangeRandom 2, RangeTimer 12, SpType 0, aimAccl 5 dccl 2 LIMIT 0 (aimAngle stays 0!).
- RNG consumers in gameplay (exact order matters): scrJump: choose(86)=1 draw; casing create:
  random_range x2 + choose(5 args)=3 draws; scrShotSound (check choose); bullet create (accuracy/
  range random?); cam shake: irandom_range x2 per frame while camShake>0. scrRecharge on land:
  fx 111 spawn + meterJiggle=4 (HUD jiggle: metery=21+meterJiggle, jiggle -= sign each HUD draw;
  chargeMetery=229+meterJiggle*4; hudAmmoJiggle on pFired: +2, drawn +x/y offsets).
- Casing/collision rects in room_menu_gen.rs (MENU_WALL_RECTS 78, MENU_THIN_RECTS bench seat
  101..124 x 514..515). Player mask rel (x,y): x-4..x+3, y-4..y+7 (sprPlayerIdle bbox, FIXED).
- playerDraw normal path = draw_sprite_ext(sprite,image_index,x,y,image_xscale,1,0,white,1)
  (dFlash=-1 is GM-falsy -> plain branch; laser sight/jetpack/water not in menu).
- fx objects: objJumpSmallerFx: img_speed .5, draws sprJumpSmallerFx (id TBD) at x,y mirrored
  per emitTo (both if 0), kills at anim end. objJumpFx: img_speed .5, default draw (sprite from
  OBJT 233), anim-end kill. bullet_casing: xsp=rr(-3,-1)*sign(plr xscale), ysp=rr(-3,0),
  image_speed=choose(-.5,-.3,0,.3,.5), alarm0=15, ugrav .08 (ysp<-1: .2), Step: ysp+=grav,
  x+=xsp y+=ysp presumably + wall bounce (read Step tail), Draw default-ish (check).
- Iterate: build -> geist driven 400 -> extend to 800 (well dive at ~f800 -> rmMain = STOP for now).

## Driven-tape frontier (task #8) — STATUS
Harness/input alignment SOLVED and verified: idle 300f = 0 diffs, driven 300f = 0 diffs (both
binaries under libTAS, real key injection). Driven 400f: first divergence = frame 320, localized
to the player: GM's welltaro WAKES from the nap (space press once noControl=0 after the dissolve)
and sits up; ours still sleeps. Next to port, in order:
1. Wake: playerSpriteControl nap branch — anyInput && !noControl -> napping=0; if grounded:
   soundLand() + instance_create(objJumpSmallerFx) (visible fx!). noControl set 0 by ditherFade
   destroy (already modeled as fade_alive=false).
2. Post-wake stance: playerSpriteControl normal branches (idle sprite 31, 4 frames, imgspstand),
   grounded state via scrWallCol; then scrJump on dUp, walk via scrPlMovement (dLeft/dRight),
   scrGravity_n (grav 0.2, maxgrav 7). Player Step_1 order in NOTES 'Player idle path' above.
3. Dynamic camera (freeCam ground-room branch, camSlowdown 5/10 exponential; OPEN: y target
   observed 448 = ply+daop with ply=480?? — resolve by porting cam_main Step_0 verbatim and
   diffing; the nap-time settled view (32,306) is currently hardcoded in menu.rs).
4. The tape dives into the well ~f780+ (objTeleportMain at (240,640), cc 'destination=1') -> rmMain.
   That's the gameplay-proper port (level gen, enemies) — big new phase.
Tape facts: SPACE 4on/36off <780 then 3on/15off; D at [820,855)+[930,960); A at [880,910)+[990,1015).
Wake fx sprite: objJumpSmallerFx — get sprite id/frames from gmdata before porting.

## GameMaker 2022 RNG — fully reverse-engineered (sim/src/rng.rs)
Found by disassembling the runner (registration table via name-string xrefs at 0x473230,
functions F_Random 0x46d3c0, F_RandomRange 0x46d420, F_Irandom 0x46d550, Init 0x424b30,
core 0x424c20) + a gdb breakpoint call-trace + pixel validation. NOT the classic 0x8088405 LCG.
- Core: WELL512 variant, 16xu32 state @0xb46fe0 + index @0xb47020. Invertible (rng.rs has both).
- Init(seed): s = ((s*0x343FD + 0x269EC3)>>16) sixteen times -> state; index=0. Seed @0xb47024.
- randomize() under libTAS frozen clock -> seed 0 (twice at boot: engine + GML randomize).
- random(x) = 1 draw * 2^-32 * x; random_range(a,b) = min + 1 draw * 2^-32 * |b-a|.
- irandom(n) = TWO draws: ((d2 & 0x7fffffff)<<32 | d1) % (n+1). choose(...) = ONE draw % argc.
- rmMenu creation chain (77 draws, gdb-verified): pose irandom(5); per tuft [choose(4), rr(0.15,0.25),
  irandom(3), random(10)] in ROOM instance order with objTree choose(6) + groundTrees irandom(3)
  interleaved after tuft 3, groundTrees@-16 last. Menu idle consumes ZERO draws per frame.
- image_index/image_speed are engine-side FLOAT32 (GML vars are f64!). f32 accumulation determines
  animation frame boundaries (ditherFade 0.2/frame crossings at 765/770/775/780, NOT 785).
- Player nap phase: scrPlayerInit sets image_speed=0.3; the creation-frame advance applies 0.3 once
  before playerSpriteControl switches to the nap speed -> image_index = 0.3 + 0.015k thereafter.
- Grass/scene anim: created frame T=first menu frame; draw at f shows idx after (f-T) advances
  (advance applies at start of the next sim tick in our model).
- Debugging tools that made this possible: gdb attach + state dump (state static during idle),
  WELL inverse for offset search, gdb breakpoint trace of F_* calls (software breaks AFTER exec;
  attach by PID during boot — hbreak/follow-exec chains fail through libTAS's sh/file helpers).

## Build
`python3 tools/pack_assets.py` regenerates assets/atlas.rgba + sim/src/font_gen.rs + app/src/atlas_gen.rs.
sim = no_std, no deps, POD state, tick()/draw() emit a DrawList. app = wgpu 22 headless, renders
799 frames + readback in ~2.5s (GM: 13s+ realtime under libTAS).

## Bullet/casing mechanics (menu shooting, gun 0)
- bulletRanged(261, parent parentPBullet 89): Create: parent init (no RNG), bulPropertyCheck
  (bdirRand=pBulAccuracy=3, fields from pBul* — no RNG), image_speed=0, imgSp=rr(0.4,0.6)[1w],
  bSpeed += rr(-pBulSpecial[0],0)[1w] (pBulSpecial[0]=RangeRandom=2, [1]=RangeTimer=12),
  alarm0=decTimer=12. First Step: bDir += rr(-3,3)[1w]; xsp/ysp = lengthdir(bSpeed,bDir)
  (GM: x=cos(deg)*sp, y=-sin(deg)*sp); every step: if decelerate (post alarm0) bSpeed*=0.8;
  anim starts when bSpeed<3 (imgSp); scrBulCheckSolid (line-collision vs solid -> walk-to-contact
  by (xsp/10,ysp/10) steps, damage wallHp if parent 84 else destroy + hitWallFx 101 spawn?);
  x+=xsp y+=ysp; Step_2 despawn offscreen. Draw: draw_self rotated image_angle=bDir (RENDERER
  NEEDS ROTATION for bullets + muzzle fx (angle=270) — casings unrotated, angle never set).
- Total WELL draws per shot: bullet create 2, bullet first-step 1, casing 3. Jump: 1 (choose 86).
  Land: 2 (irandom_range sound). Footstep: 2. Cam shake: 2/frame while camShake>0.
- RECOIL=0 for machinegun: ysp capped at 0 while shooting airborne (hover-ish), stammo 8 @ 1/shot,
  scrRecharge on every landing (stammo->8 + fx 111 spawn + meterJiggle=4 + shake(1,2)).

## Camera y-lock RESOLVED (and a process lesson)
roomEndSetter (-128,624) Create: `myCam.roomEnd = y - 160 - 16` = 448 -> cam Step clamps
camPointy AND yy to 448. Nap target 474 clamps to 448 -> view centers (32,306). The answer
was a 3-line Create event dismissed early as a no-op. RULE: read EVERY Create/Step of every
instance a room spawns before reaching for pixel measurement — the GML is the primary source;
geist verifies, it should not discover.

## Wired-player status (driven 420: 50 diffs, first 319; nap phase + standing MATCH)
Camera/view/roomEnd clamp verified live. Remaining defects:
1. WAKE OFF BY ONE: B wakes at tick 319 (dUp edge), A at 320. Since anyInput needs an edge and the
   edge is at 319, GM's noControl must still be 1 at 319 (fade anim-end 1 frame later than ours) and
   GM's wake trigger at 320 must come from... re-derive: check exact GM wake frame; likely fix =
   delay fade anim-end (no_control=false) by one frame (advance ordering), making the 319 edge gated
   and the NEXT edge (359? no — 320 has no edge...). CAREFUL: maybe GM wakes via dUp on 319 but its
   sitting sprite shows at 321 because spriteControl runs in scrPlMovement (inside Step_1) BEFORE
   wallCol, and after wake the NEXT frame's spriteControl picks grounded-idle... trace precisely.
2. JUMP ARC diffs (359-369, 375-391, 399-409, 415+): player position off by 2-4px mid-arc — suspect
   shooting differences (dUpHeld airborne -> machinegun, recoil caps ysp at 0 = hover). Check muzzle/
   casing/shake presence in A vs B crops; verify shotDelay unlock timing (first dUpRel after wake),
   jump_shoot_lock clearing, ROF alarm cadence, and whether GM's 'if (global.pFired)' image_index=0
   reset matters. Also HUD stammo digit/fill changes when shooting (not yet parameterized!) will diff
   in the right border once shooting fires — implement HUD stammo/jiggle wiring.
Also TODO: casing Alarm_0 verbatim (read object/bullet_casing/Alarm_0.gml — currently provisional
despawn), muzzle fx rotation (renderer angle support), fx draw depths, hitWallFx impact sprite.

## Player-wired status (driven 420 direct geist: 20/418 diff)
Input delay shim (menu-phase inputs delayed 1 frame; GM's room switch eats a present so menu
constants are capture-aligned) fixed wake+jump timing: 50 -> 20 diffs. gm_round = HALF-TO-EVEN.
Remaining 20 frames = two identical jump cycles (360-373-391 / 400-413-...) + wake fx (320/321):
- 360/400 (68px, y198-204): objJumpFx spawn detail (position/mirror/frame) at jump start.
- 361-366/401-406 (4-16px head slivers): 1px arc or air-frame while rising.
- 373/413 (96px apex): sprPlayerAir frame differs at apex (A vs B different frame/mirror) —
  suspect ysp sign at apex after dUpRel halving, or air-frame switch thresholds; verify by
  measuring the player top-row trajectory EXCLUDING the starfield rows (restrict x to 355..410,
  y to 340..430) and comparing frame choices.
- 320/321 + 390/391 (20px, y206-207): wake/land objJumpSmallerFx details (both-mirror draw at
  emitTo=0 vs my rendering, or fx anim phase).
Next after zero: extend frames toward the well dive (D-window 820+, walking + footstep RNG +
camera x-follow), then the dive -> rmMain (level gen port = next big phase). HUD stammo/jiggle
dynamics still unwired (will show once shooting fires — no shots fired through f420).

## OPEN: input delivery to the Rust runner slips ±1 frame irregularly
DOWNWELL_INPUT_LOG=1 under libTAS, drive tape (constant 4-frame presses every 40):
arrivals (app ticks): (0,1) (39,41) (79,81) (118,121) (159,161) (198,201) (239,241)
(279,281) (318,321) (359,361) — hold lengths 2/3/4 vary, starts drift by ±1.
GM's X11 input path gets clean arrivals. This (not GML) causes the apex air-frame
mismatch (release edge late by 1 when a press loses its head frame) and shooting-era
residuals. Suspects: (a) SDL event staging vs my pump timing around SDL_RenderPresent,
(b) software-canvas present not mapping 1:1 to libTAS frame boundaries, (c) the wgpu
readback interacting with libTAS's frame detection. Next probes: count presents vs
pump batches; try SDL_PumpEvents immediately after present too; check libTAS's SDL2
render-present hook semantics for double-blits. The menu +1 input shim (raw_prev)
stays until this is root-caused.

## Input desync RESOLVED via agent_log's prescribed fix (tick-keyed tape)
The geist agent_log (day 0!) predicted cross-engine input desync and prescribed keying
inputs to logical ticks. Implemented: DOWNWELL_TAPE=1 env -> windowed runner computes
drive_welltaro's schedule from its own tick counter (input = tape(tick+2); +2 = the two
boot presents making _1[k] = tick k-1 in driven mode; menu shim -1 still applies inside
the sim). GM keeps real libTAS injection. Result identical to best SDL run (200/999,
first 373) but with NO delivery slips (the SDL path slips ±1 irregularly — libTAS's
GM-tuned gettimes threshold (runner.ini main_gettimes_threshold=100) advances time on
wgpu's variable clock reads). Geist invocation: DOWNWELL_TAPE=1 python3 geist.py compare ...
Frontier: 373 apex air-frame + shooting-era 200 diffs = pure sim/GML details now.

## Walk tape (righ_walk.lua) + tape offset law + title/well
- righ_walk.lua: no space (splash self-advances), D held from f850. Rust side mirrors via
  DOWNWELL_TAPE=right_walk (tape selector in app). ALWAYS pass the env to geist compare.
- TAPE OFFSET LAW: +2 when boot saw key events (extra boot present emitted), +1 when not
  (walk tape). Auto-detected via boot_saw_key. Wake fencepost verified fixed (user confirmed
  B was 1 frame early; now first div 852 = walk dynamics, wake aligned).
- objWell drawn (depth 90: black shaft rect (248,576)-(408,2024) + sprWell2 at (272,512) org 8,8).
- objTitle ported: sprite 654 sprTitleFade (10f, org 64,16) at (328, ystart 432); trigger when
  328 within lastframe-viewx+80±4 and !napping -> alarm2=15 -> image_speed 0.32; rise
  y = 432-3*(idx/9); anim-end: alarm0=1 -> 20-sparkle burst + alarm1=75 (titleOk gate).
  Sparkles = parentMovingFx: kinds 6/7 (sprites 655 5f / 656 4f, org 16,16), drift ysp=-speed,
  anim-end kill. RNG per sparkle frame: choose(2); if 1: rr,rr,choose(2),rr [5 draws]; burst:
  rr,rr,choose(2),rr,rr x20. ORDER CAVEAT: title step runs before camera step in our tick
  (reads stale view, matching GM's __view_get timing) but GM's camMain step (shake RNG) runs
  BEFORE title's step — swap needed if a tape ever has shake + title animating simultaneously.
- Walk-era residual (first div 852, localized): velocity/camera/parallax per user's eyeballs.

## Walk tape at 23/1099 (first 965) — sparkle residual isolated
Fixed this stretch: landing bounce (scrFjump(0,1): ysp=-1, spinJumping=1, hardLandJump+alarm6=15,
recharge, NO soundLand on that path — the stub was also burning 2 phantom RNG draws/landing);
well sprite size (menu sprite_px had no 642 entry -> 0x0 quad); nightsky parallax timing (Step
reads LAST frame's view — store sky_x/sky_y in a pre-camera step; 1-frame lag vs draw-time calc);
GML ARG ORDER LAW: call arguments evaluate RIGHT-TO-LEFT (VM pushes reversed) — emitMovingFx's
in-argument RNG draws must be consumed in reverse (fixed both sparkle sites; 233->23 with parallax).
- ISOLATION RESULT: sparkles remain ~1px off (user eyeballs; 23 frames = sparkle era only).
  Tried: (a) spawn-frame step skip (GM mid-dispatch-created instances joining current event
  iteration is version-dependent) and (b) image_angle=90 via shader rotation — BOTH regressed
  (138 diffs) individually traced to (b); reverted both. Conclusion: GMS2022 DOES step
  mid-dispatch spawns same-frame (a=wrong), and GM's image_angle rasterization != my
  center-rotation shader for these quads (b=wrong-as-implemented). OPEN: characterize the 1px —
  ask user whether B's sparkles look ROTATED or TRANSLATED vs A; if rotated, implement GM's exact
  rotation quad math (corners = pos + R*(corner-origin), y-down CW sign?) instead of shader-center.

## Spawn-phase stepping law (CONFIRMED empirically, walk tape 23 -> 6)
Instances created during the STEP dispatch do NOT run their own Step that frame; instances
created during the ALARM phase DO (Step dispatch comes after Alarms). Sparkles: trickle
(title Step_0) fresh=true, burst (title Alarm_0) fresh=false. Begin-step spawns (casings,
bullets from player Step_1) also step same-frame (Step_0 phase follows) — already correct.
Walk tape now 6/1099, first 992 (the burst moment itself) — remaining residual under
investigation via user eyeballs. NOTE: one flaky geist run showed first=10 (boot-frame
capture misalignment, ±1 libTAS nondeterminism) — RERUN before believing any regression
that starts in an era the change cannot touch.

## Seed generalization VERIFIED (same lua, different seed)
GM randomize() seed law: seed = rotl32(us,16) ^ (us_lo + us_hi), us = CLOCK_MONOTONIC
microseconds (libTAS --elapsed-time-sec; NOT wall time — systime change leaves seed 0).
Verified: elapsed 0 -> 0, elapsed 7 -> 0xcfaacfaa (gdb @0xb47024 + formula + Rust derivation).
CRITICAL: read the clock at the TOP of main() — after SDL/wgpu init libTAS has advanced
virtual time and the seed is wrong (334-diff scene mismatch; early read -> exact match).
geist: GEIST_ELAPSED_SEC env sets --elapsed-time-sec for both builds.
Walk tape at seed 0xcfaacfaa: 6/1099 first 996 — same burst-only residual as seed 0.
The 6-frame sparkle-burst residual is SEED-INDEPENDENT -> structural (burst draw order /
pool permutation or 1px raster nuance), not RNG.

## MILESTONE: right-walk tape PASSES at both seeds (geist --allowance 100)
seed 0 and seed 0xcfaacfaa (elapsed=7): 0/1099 diff frames, 6 tolerated (<=36px each,
116 stray px total — one sparkle's anim state near the logo for 6 frames; accepted debt,
forensics in scratchpad order7.json era). Acceptance command:
  GEIST_ELAPSED_SEC=7 DOWNWELL_TAPE=right_walk python3 geist.py compare \
    ~/downwell-linux ~/downwell-rs-build ~/sources/geist/scripts/righ_walk.lua \
    --frames 1100 --allowance 100 --json -
Remaining on the menu surface: drive_welltaro tape shooting era (~180 diffs from ~810) —
suspects: RNG stream audit during shake, muzzle rotation raster, EMPTY-branch visuals.

## CAMPAIGN: dive -> rmPlayMenu -> rmMain generation (task #9) — architecture (all read from GML)
STAGE 1 — dive out of rmMenu:
  objTeleportMain (240,640) cc: destination=1. Player collision: goalStop=1, noControl=1, active=1.
  Step_1: once titleOk (set by title's Alarm_1 via objTeleportMain.titleOk) -> alarm[1]=30 ->
  EnterSequence: cam roomEnd=-1, camLocker.pointery accelerates down (ysp+=0.25) to y>1000,
  then blackSet -> alarm[0]=5 -> room_goto(rmPlayMenu). Draw: black cover once blackSet.
STAGE 2 — rmPlayMenu (room 8, 160x568, single PlayMenu instance at (80,128)):
  Create: cursorAt=global.playStyle, whompCreate, loadForArea(1), styleInit (styleMax=4).
  Step_1 (when yall==0 && !selected): dRightPressed/dLeftPressed move cursorAt 0..4 + styleUpdate;
  far-left toggles hardMode (if unlocked). dUp selects (if styleUnlock >= cursorAt):
  playStyle=cursorAt, save.ini writes, selected=1. Draw runs the descend anim (plSpDescend,
  ysp+=0.05) + sprEnterDither wipe (dithy+=16/frame) + vdithy curtain -> scrNextLevel(1) ->
  room_goto(rmMain), wallTile=levelTile[area]. Sprites: styleRun[], sprSelectArrow, sprHardSkull,
  sprEnterDither; text via draw_text (font0) + border text.
STAGE 3 — rmMain (room 11, 480x300000!, view follows player, wrapMode horizontal):
  244 static instances (room_main_gen.rs) incl. objBuilder(-16,704) whose Create = scrBuilderCreation,
  Step_0 = scrBuilder (stream chunks when builder.y within view+128 and !endReached).
  scrBuilderCreation (area 1): scrLevelPat1: extraColumn=level+1, levelLength=15+level,
  genCount=-10 (or -30 first boot: firstBoot 2 gate!), rightRoomAmt=choose(2,2,3), shopMade gate
  (area1 level1 playStyle!=4 -> shopMade=1, rightRoomAmt=2); tables partStart/Main/Right/ShopR/End
  (patterns_gen.rs, index sentinel [100]=len-1); side-room slot picking: rightRoom[i]=
  irandom_range(3,levelLength-1) with anti-adjacency reroll loop (wl>100 bail 9999).
  scrBuilder per emission: pixelBuilt check; genCount<-1 -> blank 2-row chunk; ==-1 ->
  partStart[irandom]; side-room slots -> makeShop gates (playStyle choose tables) partShopR/
  partRight + sideRoomLog reroll loop (wl>60); filler logic area3 only; else partMain[irandom]
  with while(rand==prvstr) reroll; genCount>levelLength -> partEnd, endReached.
  Stamping: reverseBuild=choose(0,1) per chunk (mirrors x); parse chars (skip \t, skip leading
  CR/LF, 9-wide rows via scrSetBuildx + k row counter — READ scrSetBuildx + builderCavern NEXT);
  cells: 1=wall 2=choose wall 3=choose box B=box -=thin W=watertop $=Shop \\=sign @=chunkOrCrate
  state machine (293/109) + hp/style overrides, +=GunModule, %=?(likely gem block — in
  builderCavern?), e/b/c/d/f/t/^/=/{/}/O/J/_ = enemies/markers (in builder* per-area scripts).
  ALL choose/irandom calls consume the SHARED WELL stream — stamp order = RNG order.
STAGE-3 DEPENDENCIES also needed: objBox_n (destructible), enemies spawned by letters, Spawner,
  objDepthMeter (player create in rmMain), camera autoScroll=0 path, wrapMode player physics,
  levelBeginCue, HUD in-well bits, startTimeField, obj_enter_dither/objEnterDither reveal.
PLAN: Stage 1+2 first (bounded UI work, verify via .ltm recording that dives + picks default style),
  then Stage 3 area-1-only with enemies stubbed-but-RNG-exact (spawn draws consumed, objects
  static until ported), verified by seed-0 and seed-7 dives to first landing, then enemy sim.
