LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\froglegs.lua           
#   
  E   �@  ��  \���   ��   ����   �  AA � �"@  J � �� b@� �   �@     $�     E� � ��   @� \���� �A   @  � ^   � 
      Asset    ANIM    data/anim/frog_legs.zip    IMAGE "   data/inventoryimages/froglegs.tex )   data/inventoryimages/froglegs_cooked.tex    froglegs_cooked    Prefab    common/inventory/froglegs !   common/inventory/froglegs_cooked           1      M      �� F@@ K�� \@ F@@ K�� \@ F A K@� �� \@�F A K�� �� \@�E  �   \@ K@B �� \@�K�B �  \@�F@C F � I�C�K�B �  \@�F@C F � K@� ŀ ���\@�F@C F � K � \@ F@C F � I�ŊK�B �� \@�F@C F�� �� �@FI� �K�B �� \@�K�B �� \@�K�B �  \@�K�B �@ \@�F@C F@� �� ��GI� �K�B �  \@�F@C F � I�Ȑ   � #      CreateEntity    entity    AddTransform    AddAnimState 
   AnimState    SetBank 
   frog_legs 	   SetBuild    MakeInventoryPhysics    AddTag 
   smallmeat    AddComponent    edible    components 	   foodtype    MEAT    perishable    SetPerishTime    TUNING    PERISH_FAST    StartPerishing    onperishreplacement    spoiled_food 
   stackable    maxsize    STACK_SIZE_SMALLITEM    bait    inspectable    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_DROPS 	   tradable 
   goldvalue             M                                                                                                                                       !   !   !   "   "   "   "   "   $   $   $   &   &   &   (   (   (   )   )   )   *   *   *   *   *   ,   ,   ,   -   -   -   0   1         inst    L           3   ?           �� F @ K@� ��  \@�F�@ F � �� ��AI���F�@ F � �� �@BI� �F�@ F�� K�� ŀ � �\@�K@C �� \@�F�@ F�� I ć   �    
   AnimState    PlayAnimation    idle    components    edible    healthvalue    TUNING    HEALING_TINY    hungervalue    CALORIES_SMALL    perishable    SetPerishTime    PERISH_FAST    AddComponent 	   cookable    product    froglegs_cooked        4   4   5   5   5   5   7   7   7   7   7   8   8   8   8   8   9   9   9   9   9   9   ;   ;   ;   <   <   <   >   ?         inst          	   commonfn     A   J           �� F @ K@� ��  \@�F�@ F � I���F�@ F � �  �@BI���F�@ F�� K�� �  � �\@�   �    
   AnimState    PlayAnimation    cooked    components    edible    healthvalue            hungervalue    TUNING    CALORIES_SMALL    perishable    SetPerishTime    PERISH_MED        B   B   C   C   C   C   E   E   E   F   F   F   F   F   G   G   G   G   G   G   I   J         inst          	   commonfn #                                             	         1   ?   ?   J   J   L   L   L   L   L   L   M   M   M   M   M   M   M         assets    "      prefabs    "   	   commonfn    "   
   defaultfn    "   	   cookedfn    "       