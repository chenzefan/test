LuaQ  o   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\fishingrod.lua           
   
  E   �@  ��  \���   �@  �  ����    AA � �"@  d   �@  �  $�  d   �         ��� ��  �@  � �   �       Asset    ANIM    data/anim/fishingrod.zip    data/anim/swap_fishingrod.zip    IMAGE $   data/inventoryimages/fishingrod.tex    Prefab    common/inventory/fishingrod           
        K @ \@  �       Remove        	   	   
         inst                           � � �@@�  A�  ��  �@�� � �@@ A�  � �@�� � �@@A A�  �A �@�� � ��A� �@�� � � BA �@� � 
   
   AnimState    OverrideSymbol    swap_object    swap_fishingrod    fishingline    FX_fishing    Show 
   ARM_carry    Hide    ARM_normal                                                                                               inst           owner                           � � �@@�  �@�� � ��@ �@�� � �@A� �@�� � �@A� �@� �    
   AnimState    Hide 
   ARM_carry    Show    ARM_normal    ClearOverrideSymbol    fishingline    FX_fishing                                                                 inst           owner                         
   F @ F@� Z    �F @ F@� K�� ��  \@� �       components    finiteuses    Use       �?    
                                        inst     	           #   K    g   E   \�� �@� ��@�� �@� ���܀ A� AA A @� A ���� A���� A�A��� A��� � A�A� C�C�� �DA�A� C	�Ĉ�� �� A�A� �A�D�� � A A� �AAE�� �� A �� � A�A� FAF�� ��FA�A� F�F�� ��FA�A� FG�  A�A� �� �� A �� �� A��� � A��� �A A�A� AHE� F��	A��� �	 A�A� IAI� A�A� I�I��A�^   � '      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    MakeInventoryPhysics    SetBank    fishingrod 	   SetBuild    PlayAnimation    idle    AddComponent    weapon    components 
   SetDamage    TUNING    FISHINGROD_DAMAGE    attackwear       @   SetWaitTimes       D@   SetStrainTimes               @   finiteuses    SetMaxUses    FISHINGROD_USES    SetUses    SetOnFinished    ListenForEvent    fishingcollect    inspectable    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_TOOL    equippable    SetOnEquip    SetOnUnequip     g   $   $   %   %   %   &   &   &   '   '   '   (   (   (   *   *   *   +   +   +   ,   ,   ,   .   .   .   /   /   /   /   /   /   0   0   0   2   2   2   3   3   3   3   3   3   4   4   4   4   4   4   6   6   6   7   7   7   7   7   7   8   8   8   8   8   8   9   9   9   9   9   :   :   :   :   >   >   >   @   @   @   A   A   A   B   B   B   B   B   D   D   D   E   E   E   E   E   G   G   G   G   G   J   K         Sim     f      inst    f      trans    f      anim    f         onfinished 	   onfished    onequip 
   onunequip                                              
             K   K   K   K   K   M   M   M   M   M   M   M         assets          onfinished          onequip       
   onunequip       	   onfished          fn           