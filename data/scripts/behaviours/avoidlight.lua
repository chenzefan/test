LuaQ  r   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\behaviours\avoidlight.lua              @  E  €         d@  	@   d  	@    dΐ  	@        AvoidLight    Class    BehaviourNode    Wait    PickNewAngle    Visit                	      @@ΐ     @	@	@A	ΐA        BehaviourNode    _ctor    AvoidLight    inst    waiting     phasechangetime             	                                    self           inst                
           @    	 @   @     	   waittime    GetTime    Sleep                                      self           t                   %     Q   J    @ @@@Α  A      @ Aΐ  Α @ @ @@@Α  A      @ Aΐ  A @ @ @@@ AΑ       @ Aΐ   @ @ @@@ AΑ       @ Aΐ  Α  @ΐ  Ζ @ ΖΐΒΛ Γά Ϊ   ΐA AC@ €    A Β   ΑCT     ΑC AB D          inst    Physics    CheckGridOffset               πΏ   table    insert      Vΐ      π?     V@     f@   LightWatcher    GetLightAngle    sort    math    random      F@                    ΐ     Ε     D  άXΐ   @           
   anglediff                                                        a           b              light Q                                                                                                                                                                                                                                   #   #   #   #   #   #   $   %         self     P      angles    P      angle 6   P      light :   P           '   O     	V   F @ @   @ E  	@ F @    Fΐ@ F Α K@Α \   ΖΐA X Ζ B Ϊ   @Z   ΐΖ B Σ 	ΐ Ζ B Ϊ   ΐΕ@ ΖΒά ΞΐΒΜΐ 	ΐΖΐ@ Ζ@ΓΖΓΛΐΓά@ @Λ@D ά 	ΐ ΜDA B ΑDΜ 	ΐΖ B Ϊ@  @Ζΐ@ Ζ ΑΛ Εά Ϊ   Α@ AEE ΑΑ Β AΖEA FΒ\ NAΖAF	 Α@ ACCΑFD AG A A        status    READY    RUNNING    inst    LightWatcher 
   IsInLight    GetTime    phasechangetime    waiting    math    random       Π?Ι?   components 
   locomotor    Stop    angle    PickNewAngle       π?      @   GetLightAngle    entity    LocalToWorldSpace              f@      N@      >@   WalkInDirection    Wait Ή?    V   )   )   )   )   *   *   .   .   .   .   /   /   /   /   1   1   2   2   2   2   2   2   2   2   4   4   4   6   6   6   7   7   7   7   7   7   8   8   8   8   8   8   :   :   :   ;   ;   ;   ;   ;   ;   ;   @   @   @   B   B   B   B   C   C   E   E   E   E   E   E   E   G   G   G   G   G   G   G   G   I   I   I   I   I   I   J   J   J   O         self     U   	   in_light    U      t    U      light ;   U                         
      
      %      '   O   '   O           