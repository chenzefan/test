LuaQ  h   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\bee.lua           %   
 E   @  Á  \   Á@    Å   Á  A Ü  AA  "@  J  À Á  b@ ¤   ä@  $  dÁ          A Á  @             Asset    ANIM    data/anim/bee.zip    SOUND    data/sound/bee.fsb    IMAGE    data/inventoryimages/bee.tex    stinger    honey    Prefab    forest/monsters/bee                %    @ @@     @ @@@    Æ @ÆÀÀÚ    Æ @ÆÀÀË Á@  Ü@Æ À Æ@ÁÚ   @Æ À Æ@ÁËÁ@   ÅÁ  BBB ÂB   Ü  Ü@          components    homeseeker    home    childspawner    OnChildKilled 
   inventory 	   GiveItem    Vector3    TheSim    GetScreenPos 
   Transform    GetWorldPosition     %                                                                                                                        inst     $      worker     $      owner    $              .     1   F @ K@À Á  \@FÀ@ F Á Z    FÀ@ F Á K@Á Á \@FÀA Z    FÀA K Â \@ F @ Z    F @ K Â \@ FÀ@ F@Â Z   FÀ@ F@Â KÂ \ @  FÀ@ F@Â KÀÂ \ Z   Àü Ã @CC ÁC @   û        sg 
   GoToState    idle    components 	   workable    SetWorkLeft       ð?   brain    Start 
   stackable 
   StackSize    Get    Physics 	   Teleport 
   Transform    GetWorldPosition     1                                                      !   !   !   #   #   #   $   $   $   &   &   &   &   '   '   '   '   '   '   (   (   (   (   )   )   *   *   *   *   *   *   +   .         inst     0      item '   /           0   8        F @ K@À Á  \@FÀ@ Z    FÀ@ K Á \@ F@A Z    F@A K Á \@         SoundEmitter 
   KillSound    buzz    brain    Stop    sg        1   1   1   1   2   2   2   3   3   3   5   5   5   6   6   6   8         inst                :       ¼   E   \ @À @@ @À À@@ @À  A@ @À @A@ @À A@ ÀÁ  BA AA @ Â ÀB@  Ã A @ Ã  @ Ã Á @ Ã  @@ À   AA @ ÀÄ  EA E@ÀÄ ÀE@ ÀÄ  FA AF@ÀÄ  FA E@Æ ÀFA @Æ  GA @Æ @G @Æ ÀG @ È A @È Á @È 	 @@É ÀHI  @@É ÀHÀI @@É ÀH@JÈ 
 @@É JÀJ A @ @É JÀJA A @ @É JÄÈ  @@É  L@L ÁL@@É  L M @@É  L@M @È  @@É MÀM AN@È  @È Á @@É ÀN O AO@@É ÀNO ÁO@È  @È A @È  @È Á @  Á@ @ Ñ Á  @   Ò @R AÁ @ ^    L      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    AddLightWatcher    AddDynamicShadow    DynamicShadow    SetSize       à?
   Transform    SetFourFaced    AddTag    bee    insect 
   hit_panic    smallcreature    MakeCharacterPhysics       ð?   Physics    SetCollisionGroup 
   COLLISION    FLYERS    ClearCollisionMask    CollidesWith    WORLD 
   AnimState 	   SetBuild    SetBank    PlayAnimation    idle    SetRayTestOnBB    SetStateGraph 
   SGbee.lua    AddComponent    inventoryitem 
   stackable    components    SetOnDroppedFn    SetOnPickupFn    canbepickedup     lootdropper    AddRandomLoot    honey    stinger       @   numrandomloot 	   workable    SetWorkAction    ACTIONS    CATCH    SetWorkLeft    SetOnFinishCallback    health    SetMaxHealth    TUNING    BEE_HEALTH    pollinator    combat    SetDefaultDamage    BEE_DAMAGE    SetAttackPeriod    BEE_ATTACK_PERIOD    sleeper    knownlocations 
   locomotor    inspectable    require    brains/beebrain 	   SetBrain 	   BeeBrain    SoundEmitter 
   PlaySound    dontstarve/bee/bee_fly_LP    buzz     ¼   ;   ;   =   =   =   >   >   >   ?   ?   ?   @   @   @   A   A   A   B   B   B   B   B   C   C   C   H   H   H   I   I   I   J   J   J   K   K   K   M   M   M   M   M   N   N   N   N   N   O   O   O   P   P   P   P   P   Q   Q   Q   Q   Q   S   S   S   S   T   T   T   T   U   U   U   U   V   V   V   V   X   X   X   Z   Z   Z   [   [   [   \   \   \   \   \   ]   ]   ]   ]   ]   ^   ^   ^   b   b   b   c   c   c   c   c   c   d   d   d   d   d   d   e   e   e   h   h   h   i   i   i   i   i   i   j   j   j   j   j   k   k   k   k   k   o   o   o   p   p   p   p   p   p   s   s   s   v   v   v   w   w   w   w   w   w   x   x   x   x   x   x   |   |   |                                                                              Sim     »      inst    »      
   OnDropped    OnPickedUp 	   OnWorked %                                                         
               .   8                                             assets    $      prefabs    $   	   OnWorked    $   
   OnDropped    $      OnPickedUp    $      fn    $       