LuaQ  o   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\components\spawner.lua           !      d    d@  	@d  	@ dÀ  	@d  	@ d@ 	@d 	@ dÀ 	@d  	@ d@ 	@d 	@ dÀ 	@d  	@ d@ 	@d 	@           Class    GetDebugString    SetOnOccupiedFn    SetOnVacateFn 
   Configure    SpawnWithDelay    CancelSpawning    OnSave    OnLoad    TakeOwnership    LoadPostPass    IsOccupied    ReleaseChild    GoHome    OnChildKilled                   	@ 	À	 Á	À	@	À        inst    child     delay            onoccupied 	   onvacate    spawnsleft                                   self           inst                
        %   A   @  Æ@  U À@        Á  UÀ @A     A    @  ÅÀ Æ ÂA FA   MÜUÀ ÀB    À   Á  ÁB U ^          child:  	   tostring    child    IsOccupied 
    occupied    task    nextspawntime    string    format     spawn in %2.2fs    GetTime    spawnsleft     left:     %                                                                                                                        self     $      str    $                      	@         onoccupied                    self           fn                            	@      	   onvacate                     self           fn                "   '        	@ 	@ A  Á  A     
   childname    delay    SpawnWithDelay                #   $   &   &   &   &   &   '         self        
   childname           delay           startdelay                )   ,        @   @ 	 À@  A  d       	         nextspawntime    GetTime    task    inst    DoTaskInTime        +   +            @ @         ReleaseChild        +   +   +   +             self    *   *   *   *   +   +   +   +   +   +   +   ,         self           delay                .   4     	   F @ Z    F @ K@À \@ 	@	À        task    Cancel     nextspawntime     	   /   /   /   0   0   0   1   2   4         self                7   E     ,   J    @     @@       @ @ I  @    À @ À@ A    @ À@ A@A @  À  @ ÀAI À B      B Å Ü À IÀB I^          child    IsOccupied    GetSaveRecord    components    health    IsDead    childid    GUID    nextspawntime    startdelay    GetTime    spawnsleft     ,   8   :   :   :   :   :   :   :   ;   ;   ;   ;   ;   <   <   <   <   <   <   <   <   <   <   <   <   <   <   <   =   =   =   =   >   >   >   ?   ?   ?   ?   ?   B   B   D   E         self     +      data    +           H   \     +    @ @ @À    @  Æ@À ÆÀÀ Ë AFAÀ FAÁÜ@ËA @ Ü@ËÀA @ Ü@ Â     @B Â @Â    @Â 	 Â     Â ÀB@ C      C Æ@C @         CancelSpawning    child    SpawnPrefab    prefab    SetPersistData    data    TakeOwnership    GoHome    startdelay    SpawnWithDelay    spawnsleft            onoutofspawns    inst     +   J   J   L   L   L   M   M   M   M   N   N   N   N   O   O   O   P   P   P   R   R   R   S   S   S   V   V   V   W   W   X   X   X   X   X   X   X   X   X   Y   Y   Y   \         self     *      data     *      child 	              ^   h     #    @ W@ @@À   d          @ÀÀ  A   ÀÀ  A@A EÁ B ABB \  @  ÀÂ  @ÀÀ  C@CB @	@         child    ListenForEvent    death    components    knownlocations    RememberLocation    home    Vector3    inst 
   Transform    GetWorldPosition    AddComponent    homeseeker    SetHome        `   `            @   @        OnChildKilled        `   `   `   `   `             self    child #   _   _   _   `   `   `   `   `   `   `   a   a   a   a   b   b   b   b   b   b   b   b   b   b   b   e   e   e   f   f   f   f   f   g   h         self     "      child     "           j   r        Æ @Ú   ÀÆ @ÆÀ Ú   À Æ@À@ A        childid    entity    TakeOwnership        k   k   k   l   l   m   m   n   o   o   o   r         self           newents        	   savedata           child               t   v        F @ Z   F @ F@À @ W   B@  B  ^          child    parent    inst        u   u   u   u   u   u   u   u   u   u   u   v         self                x   ¥     
p   F @ Z   À F @ @À     K@ \@ FÀ@ Z@     Æ@A  ËA @ Ü@ËÀA @ Ü@ B     @@B BÁ@ @À@ ÀB@ @  Æ@B Æ ÃÚ   ÀÆ@B Æ ÃË@ÃÜ Ú@    Á@  À ÆÀ@ Æ ÃÚ   ÀÆÀ@ Æ ÃË@ÃÜ Ú@    Á@  À Å AB ÁCD Ü  A D ÁDE AE A AEÀ  ÁA  B E@  \ Ì@KA ÆÁ@ \AFÁ@ FÃZ  FÁ@ FÃKÁÅËÆÜ \A  @FÁ@ FÁÃKAÆËÆÜ \A  FF Z   FF AB \A B ^         spawnsleft            CancelSpawning    child    SpawnPrefab 
   childname    TakeOwnership    GoHome    IsOccupied    inst    RemoveChild    ReturnToScene    Physics 
   GetRadius    Vector3 
   Transform    GetWorldPosition    math    random        @   PI    cos    sin 	   Teleport    Get    SetPosition 	   onvacate     p   z   z   z   z   z   z   {   ~   ~                                                                                                                                                                                                                                                                                                         ¡   ¡   ¡   £   £   ¥         self     o      child 
   o      child          rad !   o      prad ,   -      prad 8   9      pos ?   o      angle E   o           §   ¾     9    @ @  @@  @   @ À@  @ Á @ @Á A   À @Á AÀA@ @Á  B   @@Á  B@B    À @Á  BB@ @Á ÀB   @@Á ÀB C    Àÿ@Ã  @ÀC     ÀC Æ@ @             child    IsOccupied    inst 	   AddChild    RemoveFromScene    components 
   locomotor    Stop 	   burnable 
   IsBurning    Extinguish    health    IsHurt    RemoveComponent    homeseeker    onoccupied     9   ¨   ¨   ¨   ¨   ¨   ¨   ¨   ©   ©   ©   ©   ª   ª   ¬   ¬   ¬   ¬   ­   ­   ­   ­   °   °   °   °   °   °   °   °   °   °   ±   ±   ±   ±   ´   ´   ´   ´   ´   ´   ´   ´   ´   ´   ·   ·   ·   ¸   ¸   ¸   ¹   ¹   ¹   »   »   ¾         self     8      child     8           Á   Ô     !    @     @ À @ @	  @ @@@À@     À@ Æ A @  @      @ À@A  @  À 	ÀA B AB @  
      spawnsleft               ð?   onoutofspawns    inst    IsOccupied    child     SpawnWithDelay    delay     !   Ã   Ã   Ã   Ã   Ã   Ã   Ä   Ä   Ä   Å   Å   Å   Æ   Æ   Æ   Ç   Ç   Ç   Ì   Ì   Ì   Ì   Ì   Ì   Í   Í   Í   Í   Î   Ï   Ï   Ï   Ô         self            child             !               
                '   "   ,   )   4   .   E   7   \   H   h   ^   r   j   v   t   ¥   x   ¾   §   Ô   Á   Ö   Ö         Spawner            