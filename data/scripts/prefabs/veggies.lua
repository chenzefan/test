LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\veggies.lua           i      A@  @ $   A  À  Á  
 @  Á  ÁÁ   \ 	A@  Á  ÁÁ  Â \ 	A@   Á   \ 	A@  Á  Á  \ 	A@   Á   \ 	A@  Á  Á  \ 	A@    Á   \ 	A@   ÁÁ  \ 	AA 
 J  A ÁÁ Â AÂ  IIÁE"A dA       Å B ÜÀ @  B  C   ÅC ÆÆ  @ ÜCÅC ÆÆ  @ÜC   ÅC ÆÆ  @ ÜCá  @ùÅÁ   Ý Þ          require    tuning       @      ð?      à?   VEGGIES    carrot            berries    corn       ø?   pomegranate       @   pumpkin       Ð?   durian       À	   eggplant    dragonfruit       @   pt    Vector3    lev        @   pairs    table    insert    unpack                   Ê@ A  @A É A  A É A  @A EA  FÁAÉ A  A EA  FÁAÉ É Þ    	      health    TUNING    BASE_VEGGIE_HEALTH    hunger    BASE_VEGGIE_HUNGER    cooked_health    BASE_COOK_BONUS    cooked_hunger    seed_weight                                                        	   	   	   	   	   	   	   
               hunger           health           seedweight                    Á    i     Å   A  A    ÁÁ  UÁÜ  A A À   ¢@  Ê    AA    À  Â  E   ÁA    AÂ ÕA\â@  
 E  A  Á \  Á B @  B Å   A Ü"A  J   ÁÁ ÁbA Z    ACÀ   A BA¤      äA         $         EÂ  À  ÂÀ  @\Â Á    AÃ ÕB  @ Z   @ÅÂ  @   @  Ü ÚB    Ã @          Asset    ANIM    data/anim/    .zip    IMAGE    data/inventoryimages/    .tex    _cooked.tex    data/anim/seeds.zip    _seeds.tex &   data/inventoryimages/seeds_cooked.tex    _cooked    table    insert    _seeds    Prefab    common/inventory/        @   c     [       F@@ KÀ \@ F@@ KÀÀ \@ E     \@ F@A KÁ ÁÀ \@F@A K Â ÁÀ \@F@A K@Â Â  \@KB ÁÀ \@F C FÀÂ IÃKB ÁÀ \@F C FÀÃ @ DI KB ÁÀ \@KB Á  \@KB Á@ \@KB Á \@F@A KÀÅ Á  \@F C FÀÂ @ FIF C FÀÂ @  GIF C FÅ @ GIKB ÁÀ \@F C FÀÇ I@HKB Á \@KB ÁÀ \@F C FÀÈ @ @II F C FÀÈ    I     &      CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank    seeds 	   SetBuild    SetRayTestOnBB    AddComponent    edible    components 	   foodtype    SEEDS 
   stackable    maxsize    TUNING    STACK_SIZE_SMALLITEM 	   tradable    inspectable    inventoryitem    researchvalue    PlayAnimation    idle    healthvalue    SEEDS_HEALTH    hungervalue    SEEDS_HUNGER 
   basevalue    RESEARCH_VALUE_BASE 	   cookable    product    seeds_cooked    bait 
   plantable 	   growtime    SEEDS_GROW_TIME     [   A   A   B   B   B   C   C   C   E   E   E   F   F   F   F   G   G   G   G   H   H   H   H   J   J   J   K   K   K   M   M   M   N   N   N   N   N   P   P   P   Q   Q   Q   R   R   R   S   S   S   U   U   U   U   V   V   V   V   V   W   W   W   W   W   X   X   X   X   X   Z   Z   Z   [   [   [   ]   ]   ]   ^   ^   ^   _   _   _   _   _   `   `   `   `   b   c         inst    Z         name     e       l   E   \ @À @@ @À À@@   À  @ @Á A  @@Á ÀA @@Á @B  @Â Á @ Ã ÀBÅ   Æ ÆÀÃÀ Ã ÀBÅ   Æ Æ@ÄÀ  Ã ÀBÀDÂ  @   W@E   WEÀ    WÀE  @    @   Æ Ã Æ ÅA FÉ ËÂ AÁ Ü@ËÂ A Ü@ËÂ AA Ü@Æ Ã Æ@ÇA ÁGÉ ËÂ A Ü@Æ Ã Æ ÈÉÈÆ Ã Æ È É Å 	   Ü@ ËÂ AA	 Ü@ËÂ A	 Ü@ËÂ AÁ	 Ü@Æ Ã ÆÀÉ  AA
 AÉ ^    *      CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank    PlayAnimation    idle 	   SetBuild    AddComponent    edible    components    healthvalue    VEGGIES    health    hungervalue    hunger 	   foodtype    VEGGIE 
   stackable    pumpkin 	   eggplant    durian    maxsize    TUNING    STACK_SIZE_SMALLITEM    inspectable    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_BASE 	   burnable 	   burntime       .@   fxdata    MakeSmallPropagator    bait 	   tradable 	   cookable    product    _cooked     l   f   f   g   g   g   h   h   h   i   i   i   k   k   k   k   l   l   l   l   m   m   m   m   o   o   o   p   p   p   p   p   p   p   q   q   q   q   q   q   q   r   r   r   t   t   t   w   w   w   w   w   w   w   w   w   w   w   x   x   y   y   y   y   y   |   |   |   }   }   }   ~   ~   ~                                                                                                                  Sim     k      inst    k      is_big 9   k         name    burnfxdata        ¸    V   E   \ @À @@ @À À@@   À  @ @Á A  @@Á ÀA @@Á @B  @Â Á @ Ã ÀBÅ   Æ ÆÀÃÀ Ã ÀBÅ   Æ Æ@ÄÀ  Ã ÀBÀDÂ  @ Ã  EÅ ÆÀÅÀÂ  @Â A @Â  @ Ã FÅ Æ ÇÀÂ A @ Ã @GÀG Ã @GÄ  À @ À  @ Â  @Â Á @^    $      CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank    PlayAnimation    cooked 	   SetBuild    AddComponent    edible    components    healthvalue    VEGGIES    cooked_health    hungervalue    cooked_hunger 	   foodtype    VEGGIE 
   stackable    maxsize    TUNING    STACK_SIZE_SMALLITEM    inspectable    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_BASE 	   burnable 	   burntime       .@   fxdata    MakeSmallPropagator    bait 	   tradable     V                                                                                                             ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¢   ¢   ¢   ¤   ¤   ¤   ¥   ¥   ¥   ¥   ¥   §   §   §   ¨   ¨   ¨   ©   ©   ©   ª   ª   ª   ª   ª   ¬   ¬   ¬   ­   ­   ­   ®   ®   ®   ®   ¯   ¯   ¯   ²   ²   ²   µ   µ   µ   ·   ¸         Sim     U      inst    U         name    burnfxdata i   "   $   $   $   $   $   $   $   %   %   %   %   %   %   %   &   '   )   )   )   )   )   )   )   *   *   *   *   *   *   *   +   -   /   /   /   /   0   0   0   0   0   0   0   1   1   1   1   2   4   6   6   6   7   9   9   :   :   :   :   :   :   :   c   c            ¸   ¸   ¸   ¹   ¹   ¹   ¹   ¹   ¹   ¹   ¹   »   »   »   »   »   »   »   »   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ¼   ½   ½   ½   ½   Á         name     h   
   has_seeds     h      assets    h      assets_cooked     h      assets_seeds 1   h      prefabs 6   h   	   fn_seeds A   h      fn D   h   
   fn_cooked G   h      base O   h      cooked W   h      seeds d   h         burnfxdata i                                                                                                                                                                                                            Á   Á   Ä   Å   Å   Å   Å   Æ   Æ   Æ   Æ   Æ   Æ   Æ   Ç   Ç   Ç   Ç   Ç   È   È   È   È   È   É   É   Ê   Ê   Ê   Ê   Ê   Å   Ë   Î   Î   Î   Î   Î         MakeVegStats    h      COMMON    h   	   UNCOMMON    h      RARE    h      burnfxdata C   h      MakeVeggie E   h      prefs F   h      (for generator) I   d      (for state) I   d      (for control) I   d      veggiename J   b      veggiedata J   b      veg Q   b      cooked Q   b      seeds Q   b       