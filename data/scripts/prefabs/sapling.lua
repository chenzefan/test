LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\sapling.lua           ,   
 � E   �@  ��  \���   ��   � �"@  J  �@ �� b@ �   �@  
� J�  � �A B AB �� I���I�B�"A� d�  ��  � $B      �  �     �   E �B �    @� ]�^   �       Asset    ANIM    data/anim/sapling.zip    SOUND    data/sound/common.fsb    twigs    dug_sapling    pt    Vector3            lev       @   Prefab    forest/objects/sapling                   F @ F@� K�� \@  �       components 	   pickable 
   MakeEmpty                             inst                           � @ �@@�   ��� @ �@@��@�� �    �� @ ��@� AA �@���A �@ � @ ��@� A� ��� �       components 	   pickable    CanBePicked    lootdropper    SpawnLootPrefab    twigs    Remove    dug_sapling                                                                                   inst           chopper           bush                        
   F @ K@� ��  \@�F @ K�� �    \@  �    
   AnimState    PlayAnimation    rustle    PushAnimation    picked     
                                        inst     	           "   %     
   F @ K@� ��  \@�F @ K�� �  � \@  �    
   AnimState    PlayAnimation    grow    PushAnimation    sway     
   #   #   #   #   $   $   $   $   $   %         inst     	           '   )        F @ K@� ��  \@� �    
   AnimState    PlayAnimation    empty        (   (   (   (   )         inst                -   W    	g   E   \�� �@� ��@�� �@� ���܀ A� A� FA� K���� \A�K��� \A�KA�� \A�K���� � \A K��A Ɓ�܁� ���\A�KD�A \A�K�� �� \A�F� F��I�ŊF� F��K��� B �F\A F� F���  I���F� F���� I��F� F��� I���F� F����I��K�� �� \A�K�� � \A�K�� �A \A�F� FA�K���� ��\A�F� FA�KA�� \A�F� FA�K����	 \A�K�� �
 \A�F� F�I�ʔF� F���I���E �� \A ^   � -      CreateEntity    entity    AddTransform    AddAnimState    AddMiniMapEntity 
   AnimState    SetRayTestOnBB    SetBank    sapling 	   SetBuild    PlayAnimation    sway    SetTime    math    random        @   SetIcon    sapling.png    AddComponent 	   pickable    components 
   picksound !   dontstarve/wilson/harvest_sticks    SetUp    twigs    TUNING    SAPLING_REGROW_TIME 
   onregenfn    onpickedfn    makeemptyfn    ontransplantfn    inspectable    lootdropper 	   workable    SetWorkAction    ACTIONS    DIG    SetOnFinishCallback    SetWorkLeft       �?	   burnable 	   burntime       $@   fxdata    MakeSmallPropagator     g   .   .   /   /   /   0   0   0   1   1   1   2   2   2   2   4   4   4   5   5   5   6   6   6   6   7   7   7   7   7   7   9   9   9   <   <   <   =   =   =   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   A   A   A   A   B   B   B   B   C   C   C   C   E   E   E   I   I   I   J   J   J   K   K   K   K   K   K   L   L   L   L   L   M   M   M   M   M   P   P   P   Q   Q   Q   R   R   R   R   S   S   S   V   W         Sim     f      inst    f      trans    f      anim    f      minimap    f      
   onregenfn    onpickedfn    makeemptyfn    ontransplantfn    dig_up    burnfxdata ,                                    
                                                 %   )   W   W   W   W   W   W   W   Y   Y   Y   Y   Y   Y   Y   Y   	      assets 
   +      prefabs    +      ontransplantfn    +      dig_up    +      burnfxdata    +      onpickedfn    +   
   onregenfn    +      makeemptyfn    +      fn $   +       