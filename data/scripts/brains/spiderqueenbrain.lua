LuaQ  t   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\brains\spiderqueenbrain.lua           )      A@  @    A  @    Aΐ  @    A  @    A@ @    A @   E@ €   ΐ  Eΐ €@      IEΐ €  I Eΐ €ΐ  IA ΐ Α  Α d 	A        require    behaviours/wander    behaviours/chaseandattack    behaviours/follow    behaviours/doaction    behaviours/minperiod    behaviours/panic    SpiderQueenBrain    Class    Brain       >@   OnAttacked    CanSpawnChild    CanPlantNest       $@      4@      .@   OnStart        	              @@ΐ     @        Brain    _ctor        
   
   
   
   
            self           inst                           @ @@@ΐ@  @ @ @@@ A  D  €  ΑA @         inst    components    combat 
   SetTarget    ShareTarget        @                  F @ @ΐ @F@ Fΐΐ K Α \ S  @ B@  B  ^          prefab    spiderqueen    components    health    IsDead                                                     dude                                                                     self        	   attacker           	   SEE_DIST             !   E   K@ΐ Α  \ΐ@  A ΐΐ@ AΐA BΕ@ ΖΒXΐ  ΐ@ AΐB C@  ΐΐ@ @C  XC  @              TheSim    FindFirstEntityWithTag    player    inst    GetTimeAlive       @   components    leader    numfollowers    TUNING    SPIDERQUEEN_FOLLOWERS    combat    target    GetDistanceSqToInst       y@    !                                                                                                            self            player                   6     O   F @ K@ΐ \   ΐ@@ E   @ @AA  \  ΐ  BAΒ FΒ ΑΒ Α  Α@  @ F@ W@ΐFΒCKΔ\ Z  FΒCKBΔ\ Z  @KDΑΒ \Z   E  ΖBAΛΑά   ΐ \Β@ B  ^ !  χA A @ Ε  ΖΑΕ EA  Ζ@   ΒE\ A  @ Z  @              inst    GetTimeAlive    TUNING    SPIDERQUEEN_MINWANDERTIME    Vector3 
   Transform    GetWorldPosition    TheSim    FindEntities    x    y    z       @      @   pairs    entity    IsValid 
   IsVisible    HasTag    blocker    distsq    GetClosestInstWithTag 
   spiderden    SPIDERQUEEN_MINDENSPACING    spiderqueen     O                               !   !   !   !   !   !   "   "   "   "   "   "   "   #   %   %   %   %   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   &   '   '   '   '   '   '   '   '   '   '   '   (   (   %   *   -   -   -   -   -   -   .   .   .   .   .   .   /   /   /   /   0   0   4   4   6         self     N      pt    N      ents    N      min_spacing    N      (for generator)    :      (for state)    :      (for control)    :      k    8      v    8      den @   N      queen F   N           <   T     8   E     Ε@  $      A  Α  ΖA  ά  A dA       ΕΑ $      ά   E A ΕA ΖΒB dΒ      Β ΕΒ $     A ά  \  A ΖA  ΕΑ A ά ’@  Α  \ Ζ A   	 A ΐD dA     @         PriorityNode 
   WhileNode    OnFire    Panic    inst    IfNode    can plant nest    ActionNode 
   MinPeriod    TUNING    SPIDERQUEEN_GIVEBIRTHPERIOD    needs follower    make child    ChaseAndAttack       Y@   Wander        @   bt    BT    ListenForEvent 	   attacked        A   A            @ @@ @ ΐ@           inst    components    health    takingfiredamage        A   A   A   A   A   A   A             self     C   C            @              CanPlantNest        C   C   C   C   C             self     D   D            @ @@ @ ΐ  @        inst    sg 
   GoToState 	   makenest        D   D   D   D   D   D   D             self     G   G            @              CanSpawnChild        G   G   G   G   G             self     H   H     	       @ @@ @ ΐ  @            inst    sg 
   GoToState    poop    SUCCESS     	   H   H   H   H   H   H   H   H   H             self     R   R           @Aΐ @        OnAttacked 	   attacker        R   R   R   R   R         inst           data              self 8   ?   ?   A   A   A   A   A   A   A   A   C   C   C   C   D   D   D   D   C   F   F   F   F   G   G   G   G   H   H   H   H   H   G   F   L   L   L   L   M   M   M   N   N   ?   P   P   P   P   P   R   R   R   R   R   R   T         self     7      root ,   7       )                                                         	   	      	                                 6      8   9   :   <   T   <   T      	   SEE_DIST    (      MIN_FOLLOW #   (      MAX_FOLLOW $   (      MED_FOLLOW %   (       