LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\sapling.lua           !   
 � E   �@  ��  \���   ��   � �"@  J  �@ �� b@ �   �@  $�  d�  � �A   �           �� A ���   � �   � 	      Asset    ANIM    data/anim/sapling.zip    SOUND    data/sound/common.fsb    twigs    dug_sapling    Prefab    forest/objects/sapling                   F @ F@� K�� \@  �       components 	   pickable 
   MakeEmpty                             inst                           � @ �@@�   ��� @ �@@��@�� �    �� @ ��@� AA �@���A �@ � @ ��@� A� ��� �       components 	   pickable    CanBePicked    lootdropper    SpawnLootPrefab    twigs    Remove    dug_sapling                                                                                   inst           chopper           bush                       
   F @ K@� ��  \@�F @ K�� �    \@  �    
   AnimState    PlayAnimation    rustle    PushAnimation    picked     
                                       inst     	               #     
   F @ K@� ��  \@�F @ K�� �  � \@  �    
   AnimState    PlayAnimation    grow    PushAnimation    sway     
   !   !   !   !   "   "   "   "   "   #         inst     	           %   '        F @ K@� ��  \@� �    
   AnimState    PlayAnimation    empty        &   &   &   &   '         inst                +   S    	`   E   \�� �@� ��@�� �@� ���܀ A� A� FA� K���� \A�K��� \A�KA�� \A�K���� � \A K��A Ɓ�܁� ���\A�KD�A \A�K�� �� \A�F� F��I�ŊF� F��K��� B �F\A F� F���  I���F� F���� I��F� F��� I���F� F����I��K�� �� \A�K�� � \A�K�� �A \A�F� FA�K���� ��\A�F� FA�KA�� \A�F� FA�K����	 \A�E
 �� \A EA
 �� \A ^   � *      CreateEntity    entity    AddTransform    AddAnimState    AddMiniMapEntity 
   AnimState    SetRayTestOnBB    SetBank    sapling 	   SetBuild    PlayAnimation    sway    SetTime    math    random        @   SetIcon    sapling.png    AddComponent 	   pickable    components 
   picksound !   dontstarve/wilson/harvest_sticks    SetUp    twigs    TUNING    SAPLING_REGROW_TIME 
   onregenfn    onpickedfn    makeemptyfn    ontransplantfn    inspectable    lootdropper 	   workable    SetWorkAction    ACTIONS    DIG    SetOnFinishCallback    SetWorkLeft       �?   MakeMediumBurnable    MakeSmallPropagator     `   ,   ,   -   -   -   .   .   .   /   /   /   0   0   0   0   2   2   2   3   3   3   4   4   4   4   5   5   5   5   5   5   7   7   7   :   :   :   ;   ;   ;   =   =   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   @   @   @   @   A   A   A   A   C   C   C   G   G   G   H   H   H   I   I   I   I   I   I   J   J   J   J   J   K   K   K   K   K   N   N   N   O   O   O   R   S         Sim     _      inst    _      trans    _      anim    _      minimap    _      
   onregenfn    onpickedfn    makeemptyfn    ontransplantfn    dig_up !                                    
                  #   '   S   S   S   S   S   S   U   U   U   U   U   U   U   U         assets 
          prefabs           ontransplantfn           dig_up           onpickedfn        
   onregenfn           makeemptyfn           fn            