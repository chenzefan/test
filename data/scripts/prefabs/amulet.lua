LuaQ  k   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\amulet.lua              
  E   �@  ��  \���   �@  �  ����    AA � �"@  d   �@  �    �    � A� ���      �       Asset    ANIM    data/anim/amulet.zip    data/anim/torso_amulet.zip    IMAGE     data/inventoryimages/amulet.tex    Prefab    common/inventory/amulet        	           � � �@@�  A�  ��  �@� �    
   AnimState    OverrideSymbol 
   swap_body    torso_amulet        
   
   
   
   
   
            inst           owner                           � � �@@�  �@� �    
   AnimState    ClearOverrideSymbol 
   swap_body                             inst           owner                   1    C   E   \�� �@� ��@�@ �@� ��@�@ �  � � �@ �@� ��A� �@��@� � BA �@��@� ��B� �@����  �@���� A �@��@� ��C� �@����  �@��@� � D�� � ��� ��@� � D�@E  �@��@� � D��E� �@���� � �@��@� ��E�@F���� � �@��@� ��F�  �@�����^   �       CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank    amulet    PlayAnimation    anim 	   SetBuild    AddComponent 
   stackable    inspectable    SetBloomEffectHandle    data/shaders/anim.ksh    equippable    components 
   equipslot    EQUIPSLOTS    BODY    SetOnEquip    SetOnUnequip    inventoryitem    keepondeath    researchvalue 
   basevalue    TUNING    RESEARCH_VALUE_RARE_ITEM     C                                                                                             !   !   !   !   #   #   #   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   *   *   *   +   +   +   -   -   -   .   .   .   .   .   0   1         Sim     B      inst    B         onequip 
   onunequip                                                    1   1   1   3   3   3   3   3   3   3         assets          onequip       
   onunequip          fn           