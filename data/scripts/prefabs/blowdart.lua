LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\blowdart.lua           0   
 �E   �@  ��  \���   �@  �  ����    AA ܀�  A �� �"@  d   �@  �    �    $�  d �A �   �      $� d �B   �  �   ��  @��  ܂ � AC � �   �   � 
      Asset    ANIM    data/anim/blow_dart.zip    data/anim/swap_blowdart.zip    IMAGE (   data/inventoryimages/blowdart_sleep.tex '   data/inventoryimages/blowdart_fire.tex    Prefab     common/inventory/blowdart_sleep    common/inventory/blowdart_fire 
       
           � � �@@�  A�  ��  �@�� � � AA �@�� � ��A� �@� �    
   AnimState    OverrideSymbol    swap_object    swap_blowdart    Show 
   ARM_carry    Hide    ARM_normal                                                           inst           owner                        	   � � �@@�  �@�� � ��@ �@� �    
   AnimState    Hide 
   ARM_carry    Show    ARM_normal     	                                    inst           owner                   5     D      �� F@@ K�� \� �@@ ��@�� �     �@ �@AA� �@���AA� �@�� B AA �@�ˀB A� �@�� C ����@�A� �@�� C ������A �@�ˀB AA �@�ˀB A� �@�ˀB A� �@�� C ���A �E� �ˀB A� �@�ˀB A �@�� C � ��@�D  �@�� C � �ˀ�D� �@�� C � �� Ǎ   �       CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics    SetBank 
   blow_dart 	   SetBuild    AddTag 	   blowdart    AddComponent    weapon    components 
   SetDamage         	   SetRange        @   inspectable    inventoryitem    researchvalue 
   basevalue    TUNING    RESEARCH_VALUE_TOOL 
   stackable    equippable    SetOnEquip    SetOnUnequip    equipstack     D                                                               !   !   !   "   "   "   "   "   #   #   #   #   #   '   '   '   )   )   )   *   *   *   +   +   +   +   +   -   -   -   /   /   /   0   0   0   0   0   1   1   1   1   1   2   2   2   4   5         inst    C      trans    C      anim    C         onequip 
   onunequip     7   9        � � �@@�   �       components    sleeper        8   8   8   9         inst           target                :   >     
   F @ F@� Z    �F @ F@� K�� ��  \@� �       components    sleeper 
   GoToSleep       $@    
   ;   ;   ;   ;   <   <   <   <   <   >         inst     	           ?   N     4   � @�@��   @�� @�@�ˀ�A�  � �@ � @�@��    �� @�@�ˀ�@� �@���A�   ����A� �AA ܀��@  @���A���ƀ�����   � ���A� �A� �@�� � �@��   ��� � �@�ˀ�@  �  �@ @ ���C �@  �       components    sleeper    AddSleepiness       �?      .@   combat    SuggestTarget    sg    HasStateTag 	   sleeping    states    hit 
   GoToState 
   inventory    RemoveItem    Remove     4   @   @   @   @   A   A   A   A   A   A   B   B   B   B   C   C   C   C   C   E   E   E   E   E   E   E   E   E   E   E   E   E   E   E   F   F   F   F   I   I   I   I   J   J   J   J   J   J   J   L   L   N         inst     3   	   attacker     3      target     3           O   X           �� K @ �@  \@�F�@ K�� �  \@�F@A F�� K�� � � \@�F@A F�� K � �  \@�   � 	      AddTag 
   sleepdart 
   AnimState    PlayAnimation    idle_purple    components    weapon    SetOnAttack    SetCanAttack        P   P   R   R   R   S   S   S   S   T   T   T   T   T   U   U   U   U   U   W   X         inst             common    sleepattack    sleepcanattack     Z   \        � � �@@�    �� � �@@��@�� �  �   �       components 	   burnable 
   IsBurning        [   [   [   [   [   [   [   [   [   [   \         inst     
      target     
           ]   f        � @�@��   � �� @�@�ˀ��@ � � ����   ��� � ���� �@  �  �@ @ ��@A �@  �       components 	   burnable    Ignite 
   inventory    RemoveItem    Remove        ^   ^   ^   ^   _   _   _   _   a   a   a   a   b   b   b   b   b   b   b   d   d   f         inst        	   attacker           target                g   p           �� K @ �@  \@�F�@ K�� �  \@�F@A F�� K�� � � \@�F@A F�� K � �  \@�   � 	      AddTag 	   firedart 
   AnimState    PlayAnimation 	   idle_red    components    weapon    SetOnAttack    SetCanAttack        h   h   j   j   j   k   k   k   k   l   l   l   l   l   m   m   m   m   m   o   p         inst             common    fireattack    firecanattack 0                                                               5   5   5   9   >   N   X   X   X   X   \   f   p   p   p   p   r   r   r   r   r   s   s   s   s   s   s   s         assets    /      onequip    /   
   onunequip    /      common    /      sleepcanattack    /      sendtosleep    /      sleepattack    /      sleep    /      firecanattack    /      fireattack     /      fire $   /       