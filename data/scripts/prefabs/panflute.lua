LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\panflute.lua              
  E   @  Á  \   ÁĀ    "@  d   Ī@     Å@  @   Ý  Þ           Asset    ANIM    data/anim/pan_flute.zip    IMAGE "   data/inventoryimages/panflute.tex    Prefab    common/inventory/panflute           	        K @ \@         Remove              	         inst                   (    S   E   \ @Ā @@ @Ā Ā@@  Á @A @ Á ĀA @ Á  BA @ Ā  @ ĀÂ  @ĀÂ A @Ã @CÅ  Æ@ÄĀĀÂ  @Ã DĀD AE@ĀÂ  @Ã EĀE F@Ã E@F F@Ã EF  @Ã EĀF AEA @ ĀÂ A @ĀÂ  @Ã GÅ  Æ ČĀ^    !      CreateEntity    entity    AddTransform    AddAnimState 
   AnimState    SetBank 
   pan_flute 	   SetBuild    PlayAnimation    idle    MakeInventoryPhysics    AddComponent    inspectable    instrument    components 
   sleeptime    TUNING    PANFLUTE_SLEEPTIME    tool 
   SetAction    ACTIONS    PLAY    finiteuses    SetMaxUses    PANFLUTE_USES    SetUses    SetOnFinished    SetConsumption       ð?   inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_TOOL     S                                                                                                                                                                                                     !   !   !   !   !   !   !   #   #   #   $   $   $   %   %   %   %   %   '   (         Sim     R      inst    R         onfinished                                  	   (   (   *   *   *   *   *   *   *         assets 
         onfinished          fn           