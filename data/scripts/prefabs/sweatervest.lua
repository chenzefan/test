LuaQ  p   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\sweatervest.lua              
  E   @  Á  \   ÁĀ    "@  d   Ī@  ä        A A Ā             Asset    ANIM     data/anim/armor_sweatervest.zip    IMAGE %   data/inventoryimages/sweatervest.tex    Prefab    common/inventory/sweatervest           	         Ā @@  AÁ    @     
   AnimState    OverrideSymbol 
   swap_body    armor_sweatervest                          	         inst           owner                            Ā @@  @     
   AnimState    ClearOverrideSymbol 
   swap_body                             inst           owner                   (    9   E   \ @Ā @@ @Ā Ā@@   Ā  @ @Á AÁ @@Á  BA @@Á BÁ @ĀÂ  @ĀÂ A @ĀÂ  @ĀÃ CÅ@ ÆÄĀ ĀÂ Á @ĀÃ ĀDÅ@ ÆÅĀ ĀÃ ĀDĀE  @ĀÃ ĀD F @^          CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank    armor_sweatervest    PlayAnimation    anim 	   SetBuild    AddComponent    inspectable    inventoryitem    researchvalue    components 
   basevalue    TUNING    RESEARCH_VALUE_TOOL    equippable 
   equipslot    EQUIPSLOTS    BODY    SetOnEquip    SetOnUnequip     9                                                                                                                  !   !   !   "   "   "   "   "   $   $   $   $   $   %   %   %   %   %   '   (         Sim     8      inst    8         onequip 
   onunequip                                  	      (   (   (   *   *   *   *   *   *   *         assets 
         onequip       
   onunequip          fn           