LuaQ  r   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\components\equippable.lua                 d    d@  	@d  	@ dÀ  	@d  	@ d@ 	@d 	@ dÀ 	@          Class    SetOnEquip    SetOnPocket    SetOnUnequip    Equip 	   ToPocket    Unequip    CollectInventoryActions           	     
   	@ 	À  @A		ÀA	ÀA	ÀÁ	@        inst    isequipped  
   equipslot    EQUIPSLOTS    HANDS 
   onequipfn     onunequipfn    onpocketfn    equipstack     
                              	         self     	      inst     	                      	@      
   onequipfn                    self           fn                           	@         onpocketfn                    self           fn                           	@         onunequipfn                    self           fn                        	   	@@Æ@ Ú   À Æ@ Á@ @ Ü@        isequipped 
   onequipfn    inst     	                                    self           owner           slot                    %         @    À  @ Æ@@   @        onpocketfn    inst        !   !   !   "   "   "   "   %         self           owner                '   .     	   	@@Æ@ Ú   À Æ@ Á@ @ Ü@        isequipped     onunequipfn    inst     	   (   *   *   *   +   +   +   +   .         self           owner           slot                1   7        Æ @ Ú@  Å@  ÆÀ  EÁ  FÁÜ@@Å@  ÆÀ  EÁ  FAÁÜ@        isequipped    table    insert    ACTIONS    EQUIP    UNEQUIP        2   2   2   3   3   3   3   3   3   3   5   5   5   5   5   5   7         self           doer           actions                  	                              %       .   '   7   1   9   9         Equippable           