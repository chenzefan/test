LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\beemine.lua           +   
  E   �@  ��  \���   ��   ����   A A� � �"@  J � �� b@� �   �@  $�    �   d�     �   �   �A $�      �d�   �     �� �B  �@  �� ���   � 
      Asset    ANIM    data/anim/bee_mine.zip    IMAGE !   data/inventoryimages/beemine.tex    SOUND    data/sound/bee.fsb    bee    Prefab    common/inventory/beemine                 I   F @ K@� ��  \@�F�@ Z    �F�@ K � \� Z   ��A@ �� ��A�@ `@�E �A \� Z   ��� ��B ��� ��  �A Ɓ�܁� ����B �C�� �CE BFBD�B ��D� �� ���L���A��F�D�B �E� �� ���L���A��FB�K����E� \B  F�FB�Z   �F�FB�K����@ \B�_ �F�@ K�� �  \@� �       SoundEmitter 
   PlaySound    dontstarve/bee/beemine_explo    target    IsValid       �?   TUNING    BEEMINE_BEES    SpawnPrefab    bee    Vector3 
   Transform    GetWorldPosition    math    random        @   PI    x    cos    z    sin    Physics 	   Teleport    Get    components    combat 
   SetTarget 
   PushEvent    coveredinbees     I                                                                                                                                                                                                                               	      inst     H      (for index)    D      (for limit)    D      (for step)    D      i    C      bee    C      pos    C      dist    C      angle %   C           "   +        F @ Z   � �F @ K@� \@ 	�@�F�@ Z   � �F�@ K@� \@ 	��� �    	   testtask    Cancel     rattletask        #   #   #   $   $   $   %   '   '   '   (   (   (   )   +         inst                .   4       D   �   \@ F @ K@� ��  \@�F�@ K � �@ \@�K�A �� �� �� \@ K@B �� $  \@  �    
   AnimState    PlayAnimation    explode    SoundEmitter 
   PlaySound    dontstarve/bee/beemine_launch    DoTaskInTime    FRAMES       "@   ListenForEvent 	   animover        3   3        K @ \@  �       Remove        3   3   3         inst               /   /   /   0   0   0   0   1   1   1   1   2   2   2   2   2   3   3   3   3   4         inst              StopTesting 
   SpawnBees     6   9       	@ ��   �   �@  �       target        7   8   8   8   9         inst           worker              Explode     ;   C       E@  �   ŀ  ���$  \� 	@ �F @ Z   @�D   �   \@ D � �   \@  �       target    FindEntity    TUNING    BEEMINE_RADIUS        <   =        K @ �@  \��Z@  @�K @ ��  \��Z@   �K @ ��  \��Z   � �K @ �  \��S � ^   �       HasTag 
   character    monster    animal    player        =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =         dude               <   <   <   <   =   <   =   ?   ?   ?   @   @   @   A   A   A   C         inst              StopTesting    Explode     E   I        F @ K@� ��  \@�F @ K�� �  \@�F@A K�� �� \@� �    
   AnimState    PlayAnimation    hit    PushAnimation    idle    SoundEmitter 
   PlaySound    dontstarve/bee/beemine_rattle        F   F   F   F   G   G   G   G   H   H   H   H   I         inst                K   N       K@@ ��    A�  \��	@ �K@@ �@ � A�  \��	@ � �    	   testtask    DoPeriodicTask �������?      �?   rattletask       @       L   L   L   L   L   L   M   M   M   M   M   M   N         inst           	   MineTest    MineRattle     P   u     P      �� F@@ K�� \� �@@ ��@�� �@@ � ��@ �@    �@ ˀAA� �@�� BAA �@�ˀBA� �@�� C AA �@�ˀC A� �@�ˀC A �@��@D � ���D��@D � �� �D  �@��@D � ��@�D� �@�ˀC A� �@��@D ƀ� AF� ��ˀC A� �@�ˀC A� �@��@D ���� �EA F���@��@D ������A �@��@D ����@�D �@�� �    �@    � "      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    MakeInventoryPhysics    SetBank    beemine 	   SetBuild 	   bee_mine    PlayAnimation    idle    AddTag    mine    AddComponent    inspectable    inventoryitem    components 	   nobounce    SetOnPickupFn    SetOnDroppedFn    researchvalue 
   basevalue    TUNING    RESEARCH_VALUE_TOOL    lootdropper 	   workable    SetWorkAction    ACTIONS    HAMMER    SetWorkLeft       �?   SetOnFinishCallback     P   Q   Q   R   R   R   S   S   S   T   T   T   U   U   U   Z   Z   Z   [   [   [   \   \   \   ^   ^   ^   `   `   `   a   a   a   b   b   b   c   c   c   c   c   d   d   d   d   d   f   f   f   g   g   g   g   g   i   i   i   j   j   j   k   k   k   k   k   k   l   l   l   l   l   m   m   m   m   m   o   o   o   t   u         inst    O      trans    O      anim    O         StopTesting    StartTesting    onhammered +                                                          +   4   4   4   9   9   C   C   C   I   N   N   N   u   u   u   u   w   w   w   w   w   w   w   w   
      assets    *      prefabs    *   
   SpawnBees    *      StopTesting    *      Explode    *      onhammered    *   	   MineTest    *      MineRattle    *      StartTesting    *      fn #   *       