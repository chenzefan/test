LuaQ  q   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\krampus_sack.lua           7   
  E   @  Α  \   Α@  Α  Ε    AA ά "@  d   €@  Κ    AΑ   AB B@Β Α CCCA  B  B B@Β ΑΒ CCCA  B  ϊ$          E A ΐ    ] ^          Asset    ANIM    data/anim/backpack.zip     data/anim/swap_krampus_sack.zip    IMAGE &   data/inventoryimages/krampus_sack.tex               @      π?   table    insert    Vector3      @dΐ     ΐR@     \@     ΐUΐ   Prefab    common/inventory/krampus_sack                    ΐ @@  AΑ   @ ΐ @@  AΑ    @@Α A @A  B@B  @  
   
   AnimState    OverrideSymbol 
   swap_body    swap_krampus_sack 	   backpack    components 
   inventory 	   overflow 
   container    Open        	   	   	   	   	   	   
   
   
   
   
   
                                    inst           owner                            ΐ @@  @ ΐ @@Α  @ Α @AΐA A  B@B  @  
   
   AnimState    ClearOverrideSymbol 
   swap_body 	   backpack    components 
   inventory 	   overflow  
   container    Close                                                                 inst           owner                   ?    O   E   \ @ΐ @@ @ΐ ΐ@@   ΐ  @ @Α AΑ @@Α  BA @@Α BΑ @ Γ A @ Γ  @ΐΓ C@D Γ  @ΐΓ DΕ  Ζ@ΕΐΐΓ DE  @ΐΓ DΐE @ Γ  @ΐΓ  F@F  @ΐΓ  FΔ  ΐ ΐΓ  F ΗΐΓ  F ΗΐΓ  FΕΐ  AA  ά ΐ ^    #      CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank 
   backpack1    PlayAnimation    anim 	   SetBuild    swap_krampus_sack    AddComponent    inspectable    inventoryitem    components    cangoincontainer     equippable 
   equipslot    EQUIPSLOTS    BODY    SetOnEquip    SetOnUnequip 
   container    SetNumSlots    widgetslotpos    widgetanimbank    ui_krampusbag_2x5    widgetanimbuild 
   widgetpos    Vector3      (@     @Uΐ            O           "   "   "   #   #   #   $   $   $   &   &   &   &   '   '   '   '   (   (   (   (   *   *   *   ,   ,   ,   -   -   -   /   /   /   0   0   0   0   0   2   2   2   2   2   3   3   3   3   3   6   6   6   7   7   7   7   7   7   8   8   8   8   9   9   9   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   >   ?         Sim     N      inst    N         onequip 
   onunequip    slotpos 7                                                                                                                                       ?   ?   ?   ?   A   A   A   A   A   A   A   	      assets    6      onequip    6   
   onunequip    6      slotpos    6      (for index)    ,      (for limit)    ,      (for step)    ,      y    +      fn 0   6       