LuaQ  w   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\components\periodicspawner.lua                 d    d@  	@d  	@ dภ  	@d  	@           Class    AddToLimit 	   TrySpawn    Start    Stop                	   	@ 	ภ	 ม	ม	 ย	ย	 ร	ย        inst    max        @   range       4@	   basetime       D@	   randtime       N@   product     min_spacing        @   limit     	                        
            self           inst                            @    ภ  @ @ 	   	@ @@ @  @ @ @         limit    task    Start                                                        self           num                    J     U   F @ K@ภ \ Z@      E   @ ภ@ A  \  @ Aมม Fย Aย ฦB  มภ @ C  @@ CFAC AA    AC E  \@ยร ฤ@ ฦBD CD ฮภ@ ฦD  ฬภฤa  ภ๛FD @ภE AC \ AE    AE ภA มภE@ ย@A A  มE    มE มD	มE ภB F A   KAF \A         inst    IsValid    Vector3 
   Transform    GetWorldPosition    TheSim    FindEntities    x    y    z    range            prefabs    product    pairs    prefab    GetDistanceSqToInst    min_spacing    max       ๐?   SpawnPrefab    onspawn    SetPosition    limit    Stop    Start     U   "   "   "   "   "   #   &   &   &   &   &   &   '   '   '   '   '   '   '   (   )   )   )   )   )   )   )   )   )   )   )   ,   ,   ,   ,   .   .   .   /   /   /   /   /   /   /   /   0   1   3   ,   4   7   7   7   8   8   8   9   9   9   :   :   :   <   <   <   <   <   <   <   >   >   >   ?   ?   ?   @   @   @   A   A   B   G   G   J         self     T      pos    T      ents    T      num    T      prefabname    T      (for generator) "   3      (for state) "   3      (for control) "   3      k #   1      v #   1      inst 9   R           L   P        F @ @  @ ฦภ@ ภ L @A A  d       	      	   basetime    math    random 	   randtime    task    inst    DoTaskInTime        O   O            @ @      	   TrySpawn        O   O   O   O             self    M   M   M   M   M   M   M   O   O   O   O   O   O   O   P         self           t               S   X        F @ Z   ภ F @ K@ภ \@ 	@        task    Cancel         T   T   T   U   U   U   V   X         self                              J       P   L   X   S   Z   Z         PeriodicSpawner           