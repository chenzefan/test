LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\components\trap.lua           )      d    d@  	@d  	@ dÀ  	@d  	@ d@ 	@d 	@ dÀ 	@d  	@ d@ 	@d 	@ dÀ 	@d  	@ d@ 	@d 	@ dÀ 	@d  	@ d@ 	@d 	@           Class    SetOnHarvestFn    GetDebugString    SetOnBaitedFn    IsFree 	   IsBaited    Reset    Disarm    Set 	   OnUpdate 	   DoSpring    Harvest    RemoveBait    SetBait    AcceptingBait    CollectSceneActions    OnSave    OnLoad    LoadPostPass                   	@ 	À	 Á	 Á	ÀA	@B	ÀBB 	 	À	@        inst    bait  	   issprung     isset    range       ð?
   targettag    smallcreature    checkperiod       è?   timetocheck 
   onharvest 	   onbaited                          	   
   
                  self           inst                           	@      
   onharvest                    self           fn                   /     
5    @    @ A@  @@    @ AÀ    A  @A      Á Á FAA  A U@@B      Á Á FAB  A U@ÀB     ÀB       Á@ UÀ  ÆÀB  À À   A U@¡  @þ^          isset    SET!  	   issprung 	   SPRUNG!     IDLE!     bait    Bait: 	   tostring         target    Target:    lootprefabs            Loot:     pairs     5                                                                  "   "   "   #   #   #   #   #   #   #   &   &   &   &   &   &   &   '   '   '   (   (   (   (   )   )   )   )   (   )   -   /         self     4      str     4      (for generator) ,   3      (for state) ,   3      (for control) ,   3      k -   1      v -   1           1   3        	@      	   onbaited        2   3         self           fn                5   7        F @ W@À   B@  B  ^          bait         6   6   6   6   6   6   7         self                9   ;        F @ Z   ÀF@@ Z@   F@ ÀÀ   B@  B  ^          isset 	   issprung    bait         :   :   :   :   :   :   :   :   :   :   :   :   ;         self                >   E     
   F @ K@À À   \@	À@	À@	Á	Á	A  	      inst    StopUpdatingComponent    isset  	   issprung    lootprefabs     bait    target     
   ?   ?   ?   ?   @   A   B   C   D   E         self     	           G   I        K @ \@         Reset        H   H   I         self                K   O        K @ \@ 	ÀFÀ@ K Á À   \@        Reset    isset    inst    StartUpdatingComponent        L   L   M   N   N   N   N   O         self                Q   a         @    @@ @ 	@@ @ À  Æ A AA d   ÆA ¢A     	Æ A Ë Â@  Ü@Æ A Ë@ÂA Ü@ÆÀB 	À        isset    timetocheck            FindEntity    inst    range 
   targettag    target    StopUpdatingComponent 
   PushEvent    springtrap    checkperiod        U   X        F @ F@À Z   @F @ F@À KÀ \ Z@  @F @ FÀÀ Z   F @ FÀÀ K Á \ S  @ B@  B  ^          components    health    IsDead    inventoryitem    IsHeld        V   V   V   V   V   V   V   V   W   W   W   W   W   W   W   W   W   W   W   W   W   W   W   X         guy               R   R   R   S   S   S   T   T   T   U   U   U   X   X   X   X   U   Y   Y   Z   [   [   [   [   \   \   \   \   ^   ^   a         self           dt           guy               c        e   F @ K@À À   \@F@ Z   À
F@ KÀÀ \ Z   	F@ K Á \ Z@  @F@ K@Á Á 
  F@ 	AFB 	A\@ F@ F@Â FÂ Z   @J  @  Cb@ 	@F@ F@Â F@Ã Z   @F@ F@Â F@Ã KÃ \ 	@F@ KÀÃ \@ F B Z    F B KÀÀ \ Z   À F B KÀÃ \@  F @ F Ä K@Ä \  ÁD À  A  EA  \ÀBÂB  ÀBÂBWE BÂBÂEE ÂÃB @ a  @û	E	E	@F	ÀF        inst    StopUpdatingComponent    target    IsValid 
   IsInLimbo 
   PushEvent 
   ontrapped    trapper    bait    components    inventoryitem    lootprefabs    prefab    lootdropper    GenerateLoot    Remove 
   Transform    GetWorldPosition    TheSim    FindEntities        @   pairs     owner    isset  	   issprung     e   d   d   d   d   f   f   f   f   f   f   f   f   f   f   f   f   f   g   g   g   g   g   g   g   g   g   h   h   h   h   h   i   i   i   i   i   i   k   k   k   k   k   l   l   l   l   l   l   o   o   o   r   r   r   r   r   r   r   r   s   s   s   s   u   u   u   u   v   v   v   v   v   v   v   w   w   w   w   x   x   x   x   z   z   z   z   z   z   z   z   z   {   {   |   w   ~                  
      self     d      x C   `      y C   `      z C   `      ents J   `      (for generator) M   `      (for state) M   `      (for control) M   `      k N   ^      v N   ^                   L    @    À@@ @Á  @ A      A Æ@@ @ @A    @Á ÀA   @  Æ@A  ÀÅA   Ü Ú  Á ÂABÃÃ E KCÃÆC@ ÆÃËÃÃÜ \    B  ¡  @ú D @ @@ A@D   @@@ A@DD Á ÀABA@ CÁ Å ËAÃFB@ FÃKÂÃ\ Ü    @       	   issprung    inst 
   PushEvent    harvesttrap 
   onharvest    lootprefabs    components 
   inventory    ipairs    SpawnPrefab 	   GiveItem    Vector3    TheSim    GetScreenPos 
   Transform    GetWorldPosition    Reset    finiteuses    GetUses             L                                                                                                                                                                                                                                             self     K      doer     K      (for generator)    .      (for state)    .      (for control)    .      k    ,      v    ,      loot    ,           ¡   ¦     	   F @ Z    F @ F@À F À IÀ@	À@        bait    components    trap      	   ¢   ¢   ¢   £   £   £   £   ¤   ¦         self                ¨   ±        Z   @ À @@   @	@ À @@  ÀÀ  AAA Á@A @  ÀA    À ÀA Æ@A A@ @        components    bait    trap 
   Transform    SetPosition    inst    GetWorldPosition 	   onbaited        ©   ©   ©   ©   ©   ©   ª   «   «   «   ¬   ¬   ¬   ¬   ¬   ¬   ¬   ­   ­   ­   ®   ®   ®   ®   ±         self           bait                ³   µ     
   F @ Z    F@@ WÀ   B@  B  ^          isset    bait      
   ´   ´   ´   ´   ´   ´   ´   ´   ´   µ         self     	           ·   »     
   Æ @ Ú   @Å@  ÆÀ  EÁ  FÁÜ@     	   issprung    table    insert    ACTIONS 
   CHECKTRAP     
   ¸   ¸   ¸   ¹   ¹   ¹   ¹   ¹   ¹   »         self     	      doer     	      actions     	           ¿   Ç        J  @@ I @ I À@    À À@  A@      IA I^          sprung 	   issprung    isset    bait    guid    loot    lootprefabs        À   Â   Â   Ã   Ã   Ä   Ä   Ä   Ä   Ä   Ä   Ä   Ä   Ä   Å   Å   Æ   Ç         self                É   Ú     %    À 	 @À 	  ÆÀÀ   A   ÆÀÀ ¢@ 	  ÆÀÀ  A@ ÀÀ 	@@     ÀA  B   @ @    À ÀA @B @        sprung    isset    type    loot    string    lootprefabs    table    inst    StartUpdatingComponent 
   PushEvent    springtrap     %   Ê   Ê   Ë   Ë   Î   Î   Î   Î   Î   Ï   Ï   Ï   Ï   Ï   Ð   Ð   Ð   Ð   Ð   Ñ   Ñ   Ô   Ô   Ô   Õ   Õ   Õ   Õ   Õ   Ö   Ö   Ö   ×   ×   ×   ×   Ú         self     $      data     $           Þ   å        Æ @Ú   Æ @ÆÀ Ú    A@ A        bait    SetBait        ß   ß   ß   à   à   á   á   â   â   â   å         self     
      newents     
   	   savedata     
      bait    
       )                  /      3   1   7   5   ;   9   E   >   I   G   O   K   a   Q      c         ¦   ¡   ±   ¨   µ   ³   »   ·   Ç   ¿   Ú   É   å   Þ   ç   ç         Trap    (       