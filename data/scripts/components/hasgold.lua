LuaQ  o   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\components\hasgold.lua                 d    d@  	@d  	@ dĄ  	@d  	@ d@ 	@d 	@           Class    GetGold    OnSetProfile 	   GiveGold 
   SpendGold    OnSave    OnLoad                   	@ 	Ą        inst    gold                               self           inst                           F @ ^          gold                       self                
           @Ą  	 @ Ą@ JA  @ I@         gold    GetGold    inst 
   PushEvent 
   deltagold                                               self     
      profile     
                       @ @@    @ @@@  @ @ @@ A 	 Ą@ @ 	 @ @A JA  Į@ I@         inst    profile 	   GiveGold    gold    GetGold 
   PushEvent 
   deltagold                                                                                            self           amt                   -     "    @  Ą@@ @   @@ @Ą@  @@@ @ A 	   @ @ 	 @@ @A JA  @ I@     @              gold    inst    profile 
   SpendGold    GetGold 
   PushEvent 
   deltagold     "                            !   !   !   !   !   "   "   "   "   "   "   $   $   $   '   '   '   '   '   '   '   )   )   )   +   +   -         self     !      amt     !           /   3     	   F @ F@Ą Z@  Ą J@  @ I ^          inst    profile    gold     	   0   0   0   0   1   1   1   1   3         self                5   9     
    @ @@@   Ą    @ Ą 	         inst    profile    gold     
   6   6   6   6   6   6   6   7   7   9         self     	      data     	                            
         -      3   /   9   5   <   <         HasGold           