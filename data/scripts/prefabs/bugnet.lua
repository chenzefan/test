LuaQ  k   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\bugnet.lua           	   
  E   @  Á  \   Á@  Á  Å    AA Ü "@  d   ¤@  ä  $Á          E Á À    ] ^          Asset    ANIM    data/anim/bugnet.zip    data/anim/swap_bugnet.zip    IMAGE     data/inventoryimages/bugnet.tex    Prefab    common/inventory/bugnet        
           K @ \@         Remove                       inst                            À @@  AÁ  Á  @ À  AA @ À AÁ @     
   AnimState    OverrideSymbol    swap_object    swap_bugnet    Show 
   ARM_carry    Hide    ARM_normal                                                           inst           owner                        	    À @@  @ À À@ @     
   AnimState    Hide 
   ARM_carry    Show    ARM_normal     	                                    inst           owner                   A    a   E   \ @À @ Æ@À ËÀÀÜ  @ A AÁ AÁÁ AÂA AÂ Á AÃ ÁBAC ÁCAÃ ÁB	ADÂ  AÃ DÁD AEAÂ  AÃ EÁE FAÃ EAF FAÃ EF  AÃ EÁF AEÁ A Â A AÂ  AÂ Á AÃ ÁGE FAÈ	AÂ  AÃ HÁH AÃ HI A^    %      CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics    SetBank    bugnet 	   SetBuild    PlayAnimation    idle    AddComponent    weapon    components 
   SetDamage    TUNING    BUGNET_DAMAGE    attackwear       @   tool 
   SetAction    ACTIONS    CATCH    finiteuses    SetMaxUses    BUGNET_USES    SetUses    SetOnFinished    SetConsumption       ð?   inspectable    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_TOOL    equippable    SetOnEquip    SetOnUnequip     a                                                !   !   !   "   "   "   $   $   $   %   %   %   %   %   %   &   &   &   )   )   )   *   *   *   *   *   *   -   -   -   .   .   .   .   .   .   /   /   /   /   /   /   0   0   0   0   0   2   2   2   2   2   2   2   4   4   4   6   6   6   7   7   7   8   8   8   8   8   ;   ;   ;   <   <   <   <   <   =   =   =   =   =   @   A         Sim     `      inst    `      trans    `      anim    `         onfinished    onequip 
   onunequip                                                       A   A   A   A   C   C   C   C   C   C   C         assets          onfinished          onequip       
   onunequip          fn           