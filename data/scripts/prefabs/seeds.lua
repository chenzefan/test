LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\seeds.lua           4      A@  @ 
  E�  ��  �  \����  �@ � ���ŀ  A A� � �"@  J  �  �@ b@ �� �� �  �� �A� � @��A���   ��   �@  $�    �   d�    ��� ��   @  �� ���Ł  @��  � �   �       require    prefabs/veggies    Asset    ANIM    data/anim/seeds.zip    IMAGE    data/inventoryimages/seeds.tex &   data/inventoryimages/seeds_cooked.tex    seeds_cooked    spoiled_food    pairs    VEGGIES    table    insert    Prefab    common/inventory/seeds    common/inventory/seeds_cooked           #     	!   A   �@  ŀ  �  ���@�A    �� L�� ��   ��@ ��A��� �@ �@  �  � ����B    � �  @  �� �  @��� �   �               pairs    VEGGIES    seed_weight       �?   math    random    carrot     !                                                                                             "   "   #         inst            total_w           (for generator)          (for state)          (for control)          k    
      v    
      rnd           (for generator)          (for state)          (for control)          k          v               &   E      C      �� F@@ K�� \@ F@@ K�� \@ E  �   \@ F@A K�� �� \@�F@A K � �� \@�F@A K@� � � \@�K�B �� \@�F C F�� I�ÆK�B �� \@�F C F�� �@ ��DI� �K�B �� \@�K�B �  \@�K�B �@ \@�K�B �� \@�K�B �� \@�F C F�� K � �@ �@�\@�F C F�� K�� \@ F C F�� I Ǎ   �       CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank    seeds 	   SetBuild    SetRayTestOnBB    AddComponent    edible    components 	   foodtype    SEEDS 
   stackable    maxsize    TUNING    STACK_SIZE_SMALLITEM 	   tradable    inspectable    inventoryitem    researchvalue    perishable    SetPerishTime    PERISH_PRESERVED    StartPerishing    onperishreplacement    spoiled_food     C   '   '   (   (   (   )   )   )   +   +   +   -   -   -   -   .   .   .   .   /   /   /   /   1   1   1   2   2   2   4   4   4   5   5   5   5   5   7   7   7   9   9   9   ;   ;   ;   <   <   <   >   >   >   @   @   @   @   @   @   A   A   A   A   B   B   B   D   E         inst    B           G   Y     ,      �� F @ K@� ��  \@�F�@ F � �� ��AI���F�@ F � �� �@BI� �F�@ F�� �� � CI���K@C �� \@�F�@ F�� I ćK@C �@ \@�K@C �� \@�F�@ F�� �� � EI���F�@ F�� � � I���   �    
   AnimState    PlayAnimation    idle    components    edible    healthvalue    TUNING    HEALING_TINY    hungervalue    CALORIES_TINY    researchvalue 
   basevalue    RESEARCH_VALUE_BASE    AddComponent 	   cookable    product    seeds_cooked    bait 
   plantable 	   growtime    SEEDS_GROW_TIME     ,   H   H   I   I   I   I   J   J   J   J   J   K   K   K   K   K   L   L   L   L   L   N   N   N   O   O   O   Q   Q   Q   R   R   R   S   S   S   S   S   T   T   T   T   X   Y         inst    +         common    pickproduct     [   d           �� F @ K@� ��  \@�F�@ F � I���F�@ F � �  �@BI���F�@ F�� �  � CI���F�@ F@� K�� �  ���\@�   �    
   AnimState    PlayAnimation    cooked    components    edible    healthvalue            hungervalue    TUNING    CALORIES_SMALL    researchvalue 
   basevalue    RESEARCH_VALUE_BASE    perishable    SetPerishTime    PERISH_MED        \   \   ]   ]   ]   ]   ^   ^   ^   _   _   _   _   _   `   `   `   `   `   a   a   a   a   a   a   c   d         inst             common 4                                                      	                                             #   E   Y   Y   Y   d   d   f   f   f   f   f   f   g   g   g   g   g   g   g         assets    3      prefabs    3      (for generator)           (for state)           (for control)           k          v          pickproduct !   3      common "   3      raw %   3      cooked '   3       