LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\flint.lua              
  E   @  Į  \   ĮĄ    "@  d      ¤@     Å@  @   Ż  Ž           Asset    ANIM    data/anim/flint.zip    IMAGE    data/inventoryimages/flint.tex    Prefab    common/inventory/flint                  	@@F@ KĄĄ Į  \@F@ K@Į Į \@KĄA Å  Ę@ĀÜ ĪĀĢĄ$         \ 	@         task  
   AnimState    PlayAnimation    sparkle    PushAnimation    idle    DoTaskInTime    math    random       @      @                     D  @                                    shine    inst    	   
   
   
   
                                                         inst              shine        '    6   E   \ @Ą @@ @Ą Ą@@   Ą  @ @Į A @@Į ĄA @@Į @B @@Į ĄB @ Ć A @Ć @CÅ  Ę@ÄĄ Ć  @ Ć Į @ Ć  @Ć  EÅ  ĘÅĄ   Ą  @ ^          CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetRayTestOnBB    SetBank    flint    PlayAnimation    idle 	   SetBuild    AddComponent 
   stackable    components    maxsize    TUNING    STACK_SIZE_SMALLITEM    inspectable    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_BASE     6                                                                                                                                 !   !   !   "   "   "   "   "   $   $   $   &   '         Sim     5      inst    5         shine                                        '   '   )   )   )   )   )   )   )         assets 
         shine          fn           