LuaQ  n   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\spiderden.lua           <   
 A   @  Α  "@J   ΐ  Α  A  b@    Κ  Α A A Α  Ι ΙΐB’@ δ   $A  d  €Α    δ   $B   d €Β δ 
JΓ  ICCIIΓ  DΓΓΚ  ΙCDΙ"CdC               ΑΓ  @             spider    silk    spidereggsack    Asset    ANIM    data/anim/spider_cocoon.zip    pt    Vector3         333333Σ?   lev       @   name    small    time    fn    med    large    Prefab    forest/monsters/spiderden 
               	   F @ F@ΐ Z   ΐ F @ F@ΐ Kΐ \@         components    childspawner    StartSpawning     	                                    inst                        	   F @ F@ΐ Z   ΐ F @ F@ΐ Kΐ \@         components    childspawner    StopSpawning     	                                    inst                   !         @ @@@Α  AA @ @ @AAΑ  ΑAA @ B @BB ΑB@        components    childspawner    SetMaxChildren    TUNING    SPIDERDEN_SPIDERS    health    SetMaxHealth    SPIDERDEN_HEALTH 
   AnimState    PlayAnimation    anims    idle                                                                      !         inst           stage                #   )       J  IΐI Α	@ F@A KΑ Αΐ \@D      Ζ B Ζ@ΒΖΒ\@F B FΐΒ K Γ Κ  A AA β@ \@        anims    hit    cocoon_small_hit    idle    cocoon_small    Physics 
   SetSphere       ΰ?   components 	   growable    stage    lootdropper    SetLoot    silk        $   $   $   $   %   %   %   %   &   &   &   &   &   &   '   '   '   '   '   '   '   '   )         inst           	   SetStage     +   0       J  IΐI Α	@ F@A KΑ Αΐ \@D      Ζ B Ζ@ΒΖΒ\@F B FΐΒ K Γ Κ  A AA A ΑA β@ \@        anims    hit    cocoon_medium_hit    idle    cocoon_medium    Physics 
   SetSphere 333333γ?   components 	   growable    stage    lootdropper    SetLoot    silk        ,   ,   ,   ,   -   -   -   -   .   .   .   .   .   .   /   /   /   /   /   /   /   /   /   /   0         inst           	   SetStage     2   7       J  IΐI Α	@ F@A KΑ Αΐ \@D      Ζ B Ζ@ΒΖΒ\@F B FΐΒ K Γ Κ A AA A ΑA B AB  β@\@        anims    hit    cocoon_large_hit    idle    cocoon_large    Physics 
   SetSphere       θ?   components 	   growable    stage    lootdropper    SetLoot    silk    spidereggsack        3   3   3   3   4   4   4   4   5   5   5   5   5   5   6   6   6   6   6   6   6   6   6   6   6   6   6   7         inst           	   SetStage     9   <         ΐ @@  @        sg 
   GoToState    taunt        :   :   :   :   <         inst           spider                ?   A        E   F@ΐ Fΐ ^          TUNING    SPIDERDEN_GROW_TIME       π?       @   @   @   @   A         inst                C   E        E   F@ΐ Fΐ ^          TUNING    SPIDERDEN_GROW_TIME        @       D   D   D   D   E         inst                M   Ή    
   E   \ @ΐ @ Ζ@ΐ Λΐΐά Aΐ AA A @  AAΐ ΑA KBΑA \AKΒΑΑ \AKΓΑΑ \AKAΓΑ  \A KΑΓ Α \AKAΔ Α \AFΑΔ FΔKΕΑA \AKAΔ Α \AFΑΔ FΕIΖFΑΔ FΕ ΑFIFΑΔ FΕ AGIFΑΔ FΕKΗΔ  \AKAΔ ΑΑ \AKAΔ Α \AFΑΔ FΘIΘFΑΔ FΘ IFΑΔ FΘKΙδ     \AKAΙ Α	 $B       EΒ	 \AKAΙ Α
 $      EΒ	 \AKAΔ ΑA
 \AFΑΔ FAΚKΚδΑ     \AEΑ
  \A KAΔ Α \AFΑΔ FΛ IFΑΔ FΛKΛΑΑ \AFΑΔ FΛKΜ\A KAΔ ΑA \AFΜ KΑΜΑ B \A ^    6      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    MakeObstaclePhysics       ΰ?   AddMiniMapEntity    SetIcon    spiderden.png    SetBank    spider_cocoon 	   SetBuild    PlayAnimation    cocoon_small    AddTag 
   structure    AddComponent    health    components    SetMaxHealth       i@   childspawner 
   childname    spider    regenperiod    TUNING    SPIDERDEN_REGEN_TIME    spawnperiod    SPIDERDEN_RELEASE_TIME    SetSpawnedFn    lootdropper 	   burnable 	   burntime       4@   fxdata    SetBurnCallback    ListenForEvent 	   dusktime    TheGlobalInstance    daytime    combat 	   SetOnHit    MakeLargePropagator 	   growable    stages 	   SetStage       π?   StartGrowing    inspectable    SoundEmitter 
   PlaySound     dontstarve/spider/spidernest_LP    loop        u   z            @ @@         @ @@ @ @    ΐ@ @  @        components    childspawner    ReleaseAllChildren    RemoveComponent        v   v   v   v   v   w   w   w   w   w   y   y   y   y   z             inst     }   }           D  @              }   }   }   }             StartSpawning    inst     ~   ~           D  @              ~   ~   ~   ~             StopSpawning    inst        ‘    k       @@@@     
   ΐ@ AA @    @A        @AΐA@     B@B@    BΐB @   B@C @    @ΐC DA D  FΔKΑΔ\   @  @   B@C @   ΐ@ A  AEE@   ΐ@ΐE  AEF@    @A   @@ FΔ   Ζ ΐΖΐΖΖ ΗΞ@ΗΜΐ   @AΑGΑ    A ΰΐΔ  ΖΐΖΑΛAΘά Ϊ   ΐH   ΐHΒH  Bίϋ  $      components    health    IsDead 
   AnimState    PlayAnimation    cocoon_dead    childspawner    ReleaseAllChildren    Physics    ClearCollisionMask    SoundEmitter 
   KillSound    loop 
   PlaySound %   dontstarve/spider/spiderLair_destroy    lootdropper 	   DropLoot    Vector3 
   Transform    GetWorldPosition !   dontstarve/spider/spiderLair_hit    anims    hit    PushAnimation    idle    math    min 	   growable    stage        @      @   childreninside       π?   SpawnChild    combat 
   SetTarget     k                                                                                                                                                                                                                                                                                                                                 ‘      	   attacker     j      damage     j      num_to_release U   j      (for index) X   j      (for limit) X   j      (for step) X   j      k Y   i      spider ^   i         inst    N   N   O   O   O   P   P   P   Q   Q   Q   S   S   S   S   U   U   U   V   V   V   X   X   X   Y   Y   Y   Z   Z   Z   Z   ]   ]   ]   `   `   `   a   a   a   a   a   d   d   d   e   e   e   f   f   f   f   f   g   g   g   g   g   i   i   i   i   i   n   n   n   r   r   r   s   s   s   t   t   t   t   u   u   u   z   z   u   }   }   }   }   }   }   }   ~   ~   ~   ~   ~   ~   ~                     ‘   ‘      €   €   €   ¨   ¨   ¨   ©   ©   ©   ©   ͺ   ͺ   ͺ   ͺ   ͺ   «   «   «   «   ³   ³   ³   ΄   ΄   ΄   ΄   ΄   Έ   Ή         Sim           inst          trans          anim          minimap             onspawnspider    burnfxdata    StartSpawning    StopSpawning    growth_stages <                     
   
   
   
                                          !   )   )   0   0   7   7   <   A   E   G   G   H   H   H   H   I   I   I   I   J   J   J   Ή   Ή   Ή   Ή   Ή   Ή   »   »   »   »   »   »   »   »         prefabs    ;      assets    ;      burnfxdata    ;      StartSpawning    ;      StopSpawning    ;   	   SetStage    ;   	   SetSmall    ;   
   SetMedium    ;   	   SetLarge    ;      onspawnspider    ;      GetSmallGrowTime     ;      GetMedGrowTime !   ;      growth_stages .   ;      fn 4   ;       