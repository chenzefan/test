LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\birdcage.lua           9      A@  @ 
  E  ΐ  Α  \  Α@   "@  J  ΐ Α  A A Α Α b@ €   δ@  $  dΑ  €    δA       $      dΒ € δB $                  EC  ΐ    \ Γ Α D A Δ ^          require    prefabutil    Asset    ANIM    data/anim/bird_cage.zip    IMAGE "   data/inventoryimages/birdcage.tex 
   crow_beak 
   crow_body 	   crow_eye 	   crow_leg 
   crow_wing    tail_feather    Prefab    common/birdcage    MakePlacer    common/birdcage_placer 	   birdcage 
   bird_cage    idle                    ΐ @@   ΐ ΐ @@@Wΐ@@ ΐ @@@W A  @              components    edible 	   foodtype    VEGGIE    SEEDS                                                                    inst           item                   1     3   Ζ @Ζ@ΐΪ   @Ε  ΖΐΐAAA Aά  Α A   AΐAΐB AB AB ΑB AB ΑB AB ΑB AB ΑBA Β A  Α   C Α δ        A γ           components    edible    string    lower    prefab    _seeds    Prefabs    seeds 
   AnimState    PlayAnimation    peck    PushAnimation    hop 
   idle_bird    DoTaskInTime    FRAMES       N@       #   ,           @@ A   Aΐ     Αΐ  `@D  FΑFAΑKΑΔ \A_ ώE   F@ΐ \ ΐΑ @D   F Α F@Α KΑ Α  \@  	      math    random        @      π?   components    lootdropper    SpawnLootPrefab       ΰ?   seeds        $   $   $   $   %   %   %   %   &   &   &   &   &   &   %   )   )   )   )   )   *   *   *   *   *   *   ,      
   num_seeds          (for index)          (for limit)          (for step)          k             inst 
   seed_name 3                                                                                                      !   !   !   !   !   "   "   "   "   #   #   #   ,   ,   ,   #   /   1         inst     2      giver     2      item     2   
   seed_name 
   1           3   ?     "   E   F@ΐ \ ΐ  ΐ@  AA @A ΐAB @@Β  ΐ@  A @A ΐAΑ @ΐ ΐ@  A @ΐ@ @C @        math    random       ΰ?
   AnimState    PlayAnimation    caw    SoundEmitter 
   PlaySound    chirpsound 333333γ?   flap    dontstarve/birds/wingflap_cage    hop    PushAnimation 
   idle_bird     "   4   4   4   5   5   6   6   6   6   7   7   7   7   7   8   8   9   9   9   9   :   :   :   :   :   <   <   <   <   >   >   >   >   ?         inst     !      r    !           A   F        F @ Z   ΐ F @ K@ΐ \@ 	@     	   idletask    Cancel         B   B   B   C   C   C   D   F         inst                H   J       K@@ Α    \ 	@      	   idletask    DoPeriodicTask       @       I   I   I   I   I   J         inst              DoIdle     L   U    %    @ @@@@ ΐ  Δ    ΐΖA ΛAΑ@ Α ΑΒ Βΐ άA‘  @ύ@Β    @ @Β B	  A ΐB @ A @C B @   ΐ   @         components    trader    Enable    pairs 
   AnimState    OverrideSymbol    prefab    _build    chirpsound    sounds    chirp    PlayAnimation    flap    PushAnimation 
   idle_bird     %   M   M   M   M   N   N   N   N   O   O   O   O   O   O   O   O   N   O   Q   Q   Q   Q   Q   Q   R   R   R   R   S   S   S   S   S   T   T   T   U         inst     $      bird     $      (for generator)          (for state)          (for control)          k          v             bird_symbols    StartIdling     W   ^    
      ΐ   @  @ @@@@ ΐ  Δ   ΐ ΖA ΛAΑ@ άA‘  @ώ A AΑ B @         components    trader    Disable    pairs 
   AnimState    ClearOverrideSymbol    PlayAnimation    idle        X   X   X   Y   Y   Y   Y   Z   Z   Z   Z   [   [   [   [   Z   [   ]   ]   ]   ]   ]   ^         inst           bird           (for generator) 
         (for state) 
         (for control) 
         k          v             StopIdling    bird_symbols     `   p         @ @@@    ΐ @ @@ΐ@    @Ζ AΛ@ΑFA KΑ\ ά@  Ζ @ΖΐΑΛ Βά@  @ @BB@ ΐB @         components    occupiable    IsOccupied    Harvest 
   Transform    SetPosition    GetWorldPosition    inventoryitem 
   OnDropped    lootdropper 	   DropLoot    Remove        f   f   f   f   f   f   g   g   g   g   h   h   i   i   i   i   i   i   j   j   j   j   m   m   m   m   n   n   p         inst           worker           item 
              r   ~     !    @ @@@    @ΐ@  AA @ΐ@ AΑ @ B @B @ΐ@ AΑ B @ ΐΐ@  A @ΐ@ AA @        components    occupiable    IsOccupied 
   AnimState    PlayAnimation 	   hit_bird    PushAnimation    flap    SoundEmitter 
   PlaySound    dontstarve/birds/wingflap_cage 
   idle_bird 	   hit_idle    idle     !   t   t   t   t   t   t   u   u   u   u   v   v   v   v   w   w   w   w   x   x   x   x   x   x   z   z   z   z   {   {   {   {   ~         inst            worker                             ΐ A              HasTag    bird                             inst           guy                   ¨    ]   E   \ @ΐ @@ @ΐ ΐ@@ @ΐ  A@ @ ΐ   @ΐΑ  BA @ΐΑ BΑ @ΐΑ  CA @Γ Α @Γ  @Γ A @Γ  @ΐΔ DΔ   ΐ ΐΔ DΔ  ΐΐΔ DΔ  ΐ Γ Α @ΐΔ ΐE FA F@ΐΔ ΐEΐF @ΐΔ ΐE@G@ΐΔ ΐEG @Γ Α @ΐΔ ΐG H@ΐΔ ΐGΔ  ΐΐΔ ΐGH@ ^    #      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    MakeObstaclePhysics       ΰ?
   AnimState    SetBank 	   birdcage    PlayAnimation    idle 	   SetBuild 
   bird_cage    AddComponent    inspectable    lootdropper    sleeper    occupiable    components    occupytestfn    onoccupied 
   onemptied 	   workable    SetWorkAction    ACTIONS    HAMMER    SetWorkLeft       @   SetOnFinishCallback    SetOnWorkCallback    trader    SetAcceptTest 	   onaccept    Disable     ]                                                                                                                                                                                                                                         ’   ’   ’   £   £   £   £   £   €   €   €   €   ₯   ₯   ₯   ₯   §   ¨         Sim     \      inst    \         testfn    onoccupied 
   onemptied    onhammered    onhit    ShouldAcceptItem    OnGetItemFromPlayer 9                                          
                           1   ?   F   J   J   U   U   U   ^   ^   ^   p   ~      ¨   ¨   ¨   ¨   ¨   ¨   ¨   ¨   ͺ   ͺ   ͺ   ͺ   ͺ   «   «   «   «   «   «   «   «         assets    8      bird_symbols    8      ShouldAcceptItem    8      OnGetItemFromPlayer    8      DoIdle    8      StopIdling    8      StartIdling    8      onoccupied    8   
   onemptied !   8      onhammered "   8      onhit #   8      testfn $   8      fn ,   8       