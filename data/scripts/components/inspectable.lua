LuaQ  s   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\components\inspectable.lua                 d    d@  	@d  	@ dΐ  	@d  	@ d@ 	@          Class    SetDescription    CollectSceneActions    CollectInventoryActions 
   GetStatus    GetDescription                   	@ 	ΐ        inst    description                        self           inst                   
        	@         description        	   
         self           desc                        
   Ζ @ Ϊ@  @Ε@  Ζΐ  EΑ  FΑά@        onlyforcedinspect    table    insert    ACTIONS    LOOKAT     
                                       self     	      doer     	      actions     	                   
   Ζ @ Ϊ@  @Ε@  Ζΐ  EΑ  FΑά@        onlyforcedinspect    table    insert    ACTIONS    LOOKAT     
                                       self     	      doer     	      actions     	              -     l   F @ Z    F @ @@ \ Z@  @@@ @ΐ@    @@ @ΐ@ A    @ A@ ΐ@@ @A    @@ @AΐA    @ A  @@@ @@B    @@ @@BB    @ Aΐ ΐ@@ @ C   @@@ @ C@C         
@@ @ C    @@ @ CΐC @  @ A  @@ @@D    @@ @@DD    @ Aΐ  @@ @ E   ΐ@@ @ E@E      A ^       
   getstatus    inst    components    health    IsDead    DEAD    sleeper 	   IsAsleep 	   SLEEPING 	   burnable 
   IsBurning    BURNING 	   pickable 	   IsBarren    BARREN    CanBePicked    PICKED    inventoryitem    IsHeld    HELD    occupiable    IsOccupied 	   OCCUPIED     l                                                                                                                                                               !   !   "   "   "   "   "   "   "   "   "   "   "   "   #   #   #   $   $   $   $   $   $   $   $   $   $   $   $   %   %   &   &   &   &   &   &   &   &   &   &   &   &   '   '   (   (   (   (   (   (   (   (   (   (   (   (   )   ,   -         self     k      status    k           /   ;     &    @ @@ Ε  Α  AFAΑ  EΑ  FΑA A  @ ΑA AA\ B  ά   Ε@ ΛΒFΑA FΑΒKΓ\ ά  A C  Εΐ AΑ A ά           description     GetDescription    string    upper    prefab    nameoverride    inst 
   GetStatus    TheSim    GetLightAtPoint 
   Transform    GetWorldPosition    TUNING    DARK_CUTOFF 
   GetString    DESCRIBE_TOODARK     &   1   2   2   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   3   6   6   6   6   6   6   6   6   6   6   6   7   7   7   7   7   :   ;         self     %      viewer     %      desc    %                   
                  -      ;   /   @   @         Inspectable           