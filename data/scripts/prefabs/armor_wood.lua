LuaQ  o   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\armor_wood.lua              
  E   @  Á  \   ÁĀ    "@  d   Ī@  ä        A A Ā             Asset    ANIM    data/anim/armor_wood.zip    IMAGE #   data/inventoryimages/armorwood.tex    Prefab    common/inventory/armorwood           
         Ā @@  AÁ    @ A A d      @     
   AnimState    OverrideSymbol 
   swap_body    armor_wood    ListenForEvent    blocked        	   	            @ @@   @        SoundEmitter 
   PlaySound    dontstarve/wilson/hit_armour        	   	   	   	   	   	             owner                      	   	   	   	   	   	   
         inst           owner                        	    Ā @@  @Ā@  @ @      
   AnimState    ClearOverrideSymbol 
   swap_body    RemoveEventCallback    blocked     	                                    inst           owner                   .    B   E   \ @Ā @@ @Ā Ā@@   Ā  @ @Á AÁ @@Á  BA @@Á BÁ @ĀÂ  @ĀÂ A @ĀÂ  @ĀÃ CÅ@ ÆÄĀ ĀÂ Á @ĀÃ ĀD EA AE@ĀÂ  @ĀÃ EÅ  Æ@ÆĀĀÃ EF  @ĀÃ EĀF @^          CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank    armor_wood    PlayAnimation    anim 	   SetBuild    AddComponent    inspectable    inventoryitem    researchvalue    components 
   basevalue    TUNING    RESEARCH_VALUE_TOOL    armor    InitCondition 
   ARMORWOOD    equippable 
   equipslot    EQUIPSLOTS    BODY    SetOnEquip    SetOnUnequip     B                                                                                                      !   !   !   !   !   $   $   $   %   %   %   %   %   %   '   '   '   (   (   (   (   (   *   *   *   *   *   +   +   +   +   +   -   .         Sim     A      inst    A         onequip 
   onunequip                                  
      .   .   .   0   0   0   0   0   0   0         assets 
         onequip       
   onunequip          fn           