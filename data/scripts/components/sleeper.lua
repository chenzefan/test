LuaQ  o   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\components\sleeper.lua           '   $      $@  @  $  dÀ  ¤  Å  $A Ü $ É $Á É $ É $A        É $ É $Á É $ É $A É $    É $Á É $ É $A É Þ          DefaultSleepTest    DefaultWakeTest    Class    SetWakeTest    SetSleepTest    SetResistance    StartTesting 	   IsAsleep    GetTimeAwake    GetTimeAsleep    GetDebugString    AddSleepiness 
   GoToSleep    SetTest    WakeUp                   E   F@À FÀ KÀÀ \ Z   F@@ F Á Z   @F@@ F Á F@Á S  @ B@  B  ^          TheGlobalInstance    components    clock    IsNight    combat    target                                                                          inst                           E   F@À FÀ KÀÀ \ Z@  F@@ F Á Z    F@@ F Á F@Á ^          TheGlobalInstance    components    clock    IsDay    combat    target                                                              inst                	           F @ F@À Z    À   I  Á     Á À       @ @Á @         components    sleeper    lasttesttime    GetTime    sleeptestfn 
   GoToSleep        
   
                                                         inst           sleeper                          F @ F@À Z    À   I  Á     Á À       @ @Á @         components    sleeper    lasttesttime    GetTime    waketestfn    WakeUp                                                                    inst           sleeper                  )        F @ F@À Z    À @À  AI À À@ÀIÀ@@Á    À @Á A@ IÀÁ        components    sleeper    sleepiness               ð?   wearofftask    Cancel                                          !   !   !   "   #   #   #   $   $   $   %   )         inst           sleeper               -   =        	@ 	À	 Á  	  	@ 	 À 	  C @ 	Ã	 Ä	Ä @ ÀD d      @  @ ÀDA dA      @         inst 	   isasleep     testperiod       @   lasttransitiontime    GetTime    lasttesttime    sleeptestfn    DefaultSleepTest    waketestfn    DefaultWakeTest    StartTesting    resistance       ð?   sleepiness            wearofftime       $@   ListenForEvent 	   attacked    newcombattarget        :   :           @@         WakeUp        :   :   :   :         inst           data              self     ;   <        À        @@@         target    StartTesting        <   <   <   <   <   <   <         inst           data              self    .   /   0   1   1   1   2   2   2   3   3   4   4   5   5   6   7   8   :   :   :   :   :   :   ;   ;   ;   <   <   ;   =         self           inst                @   C        	@ Ë@@ @ Ü@        waketestfn    StartTesting        A   B   B   B   C         self           fn           time                E   H        	@ @@ @         sleeptestfn    StartTesting        F   G   G   H         self           fn                J   L        	@         resistance        K   L         self           resist                N   T        @     @@   @ @  @@  @     	   isasleep    SetTest        O   O   O   P   P   P   P   P   R   R   R   T         self           time              ShouldWakeUp    ShouldSleep     V   X        F @ ^       	   isasleep        W   W   X         self                Z   `        F @ Z    A@  ^   E  \ À@ M ^       	   isasleep            GetTime    lasttransitiontime        [   [   [   \   \   \   ^   ^   ^   ^   ^   `         self                b   h        F @ Z   @E@  \ @ M ^  @ AÀ  ^       	   isasleep    GetTime    lasttransitiontime                c   c   c   d   d   d   d   d   d   f   f   h         self                j   q        E   F@À   ÆÀ@ Ú    Á  Ú@    Á@ Á@   À A  A  @ ÁA  FB AB L  MÁB ÆC \^          string    format #   %s for %2.2f / %2.2f Sleepy: %d/%d 	   isasleep 	   SLEEPING    AWAKE    GetTimeAsleep    GetTimeAwake    lasttesttime 	   testtime    GetTime    sleepiness    resistance        k   k   k   l   l   l   l   l   l   l   m   m   m   m   m   m   m   m   m   n   n   n   n   n   n   o   o   k   p   q         self           str               s   ~    $   Æ @ Ì@	À Æ @ A@ XÀ  Æ@ Ú   À ËÀ@ @ Ü@ Æ @ A@  ÀÆ A Ë@ÁFA@ ¤         Ü@  ÆA Ú@  @Æ A ËÀÁFB   Ü 	À   	      sleepiness    resistance 	   isasleep 
   GoToSleep    inst    DoTaskInTime    wearofftask    DoPeriodicTask    wearofftime        x   x            @   @     
   GoToSleep        x   x   x   x   x             self 
   sleeptime $   t   t   t   u   u   u   u   u   u   u   v   v   v   v   w   w   w   w   x   x   x   x   x   x   x   x   z   z   z   {   {   {   {   {   {   ~         self     #      sleepiness     #   
   sleeptime     #         WearOff             A    @ @@@    @ @@@À@ @  À A Å Ü 	À	ÀA	@BÆB Ú   À ÆB ËÀÂÜ@ 	 CÆ @ Æ@ÃÚ   À Æ @ Æ@ÃËÃÜ@ Æ @ Æ@ÀÆÀÃÚ   @Æ @ Æ@ÀÆÀÃË ÄCÜ@Æ @ Æ@ÀÆ@ÄÚ    Æ @ Æ@ÀÆ@ÄËÃÜ@ @  À Æ @ ËÄAÁ Ü@Ë E FAE  Ü@         inst    components    health    IsDead 	   isasleep    lasttransitiontime    GetTime    sleepiness            wearofftask    Cancel     brain    Stop    combat 
   SetTarget 
   locomotor 
   PushEvent 
   gotosleep    SetWakeTest    waketestfn     A                                                                                                                                                                                                            self     @   
   sleeptime     @   
   wasasleep    @              «        Æ @ Ú    Æ @ Ë@ÀÜ@ 	@Z   @Å  Æ@Á FÁA  B ABLÜ	ÀÆB ËÀÂFÁ@  À Ü	À      	   testtask    Cancel  	   testtime    math    max            testperiod    random       à?   inst    DoPeriodicTask                    ¡   ¡   ¡   ¤   ¦   ¦   §   §   §   §   §   §   §   §   §   §   §   ¨   ¨   ¨   ¨   ¨   ¨   ¨   «         self           fn           time                ­   ¾     #   F @ F@À FÀ Z   F @ F@À FÀ KÀÀ \ Z@  @F A Z   E \ 	@	ÀAF @ F Â Z   À F @ F Â K@Â \@ F @ KÂ ÁÀ \@K C Æ@C \@        inst    components    health    IsDead 	   isasleep    lasttransitiontime    GetTime     brain    Start 
   PushEvent 	   onwakeup    SetSleepTest    sleeptestfn     #   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ±   ±   ±   ²   ´   ´   ´   ´   µ   µ   µ   µ   ¸   ¸   ¸   ¸   ¹   ¹   ¹   ¾         self     "       '                     )   -   =   -   C   @   H   E   L   J   T   T   T   N   X   V   `   Z   h   b   q   j   ~   ~   s         «      ¾   ­   Á   Á         ShouldSleep    &      ShouldWakeUp    &      WearOff    &      Sleeper 
   &       