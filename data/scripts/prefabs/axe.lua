LuaQ  h   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\axe.lua           1   
 E   @  Α  \   Α@  Α  Ε   A  A ά  AA  A E   ΑΑ \  Α  "@  d   €@  δ  $Α          d €A      ΕA  @   ά B AΒ  ΐ   ή          Asset    ANIM    data/anim/axe.zip    data/anim/goldenaxe.zip    data/anim/swap_axe.zip    data/anim/swap_goldenaxe.zip    IMAGE    data/inventoryimages/axe.tex #   data/inventoryimages/goldenaxe.tex    Prefab    common/inventory/axe    common/inventory/goldenaxe                   K @ \@         Remove                       inst                            ΐ @@  AΑ  Α  @ ΐ  AA @ ΐ AΑ @     
   AnimState    OverrideSymbol    swap_object 	   swap_axe    Show 
   ARM_carry    Hide    ARM_normal                                                           inst           owner                        	    ΐ @@  @ ΐ ΐ@ @     
   AnimState    Hide 
   ARM_carry    Show    ARM_normal     	                                    inst           owner                   D    a   E   \ @ΐ @ Ζ@ΐ Λΐΐά Aΐ AA A @ A ΑΑ AΒΑ AAΒ AΑΒ  AAΓ CCΑ DAΑΒ A AAΓ ADDΑ EAΑΒ A AAΓ AEEΑ ΑEAAΓ AEFΑ ΑEAAΓ AEAF  AAΓ AEFΑ EΑΑ A ΑΒ  AΑΒ A AΑΒ  AAΓ GEΑ FΘ	AΑΒ A AAΓ AHH AAΓ AHΑH A^    $      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    MakeInventoryPhysics    SetBank    axe 	   SetBuild    PlayAnimation    idle    AddComponent    weapon    components 
   SetDamage    TUNING    AXE_DAMAGE    tool 
   SetAction    ACTIONS    CHOP    finiteuses    SetMaxUses 	   AXE_USES    SetUses    SetOnFinished    SetConsumption       π?   inspectable    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_TOOL    equippable    SetOnEquip    SetOnUnequip     a                                                "   "   "   #   #   #   $   $   $   '   '   '   (   (   (   (   (   (   +   +   +   ,   ,   ,   ,   ,   ,   .   .   .   /   /   /   /   /   /   0   0   0   0   0   0   1   1   1   1   1   2   2   2   2   2   2   2   5   5   5   7   7   7   8   8   8   9   9   9   9   9   <   <   <   >   >   >   >   >   @   @   @   @   @   C   D         Sim     `      inst    `      trans    `      anim    `         onfinished    onequip 
   onunequip     F   K         ΐ @@  AΑ  Α  @ Α @A @ ΐ ΐA @ ΐ @B @     
   AnimState    OverrideSymbol    swap_object    swap_goldenaxe    SoundEmitter 
   PlaySound "   dontstarve/wilson/equip_item_gold    Show 
   ARM_carry    Hide    ARM_normal        G   G   G   G   G   G   H   H   H   H   I   I   I   I   J   J   J   J   K         inst           owner                M   W    "   D      \  ΐ @@  @ΐΐ  A@A ΑAE FAΒOA@ ΐΐ ΐBΕ  Ζ@ΒΟΐ ΐ ΐΐ @CΕ  ΖΐΓΐ ΐΐ  D@D @^       
   AnimState 	   SetBuild 
   goldenaxe    components    finiteuses    SetConsumption    ACTIONS    CHOP    TUNING    GOLDENTOOLFACTOR       π?   weapon    attackwear    researchvalue 
   basevalue    RESEARCH_VALUE_GOLD_TOOL    equippable    SetOnEquip     "   N   N   N   O   O   O   O   P   P   P   P   P   P   P   P   P   Q   Q   Q   Q   Q   Q   R   R   R   R   R   T   T   T   T   T   V   W         Sim     !      inst    !         fn    onequipgold 1                                                                  	   	   	   	   
            D   D   D   D   K   W   W   W   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z         assets    0      onfinished    0      onequip    0   
   onunequip    0      fn !   0      onequipgold "   0      golden %   0       