LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\grass.lua           .   
 � E   �@  ��  \���   ��   � �"@  J  �@ �� b@ �   � � 
�  E �A �A B \� 	A��	�B��@� $A  d�  ��  � $B d�      �        �     �� �B  �@  �� ���   �       Asset    ANIM    data/anim/grass.zip    SOUND    data/sound/common.fsb 	   cutgrass 
   dug_grass    pt    Vector3            lev       @   Prefab    forest/objects/grass                   � @ �@@�   ��� @ �@@��@�� �    �� @ ��@� AA �@���A �@ � @ ��@� A� ��� �       components 	   pickable    CanBePicked    lootdropper    SpawnLootPrefab 	   cutgrass    Remove 
   dug_grass                                                                                   inst           chopper           bush                       
   F @ K@� ��  \@�F @ K�� �  � \@  �    
   AnimState    PlayAnimation    grow    PushAnimation    idle     
                                       inst     	              !        F @ K@� ��  � \@  �    
   AnimState    PlayAnimation    idle                            !         inst                #   %        F @ K@� ��  \@� �    
   AnimState    PlayAnimation 
   idle_dead        $   $   $   $   %         inst                (   2        F @ K@� ��  \@�F�@ K � �@ \@�F�A F�� K � \� Z    �F�@ K@� �� \@�� �F�@ K@� �� \@� �       SoundEmitter 
   PlaySound    dontstarve/wilson/pickup_reeds 
   AnimState    PlayAnimation    picking    components 	   pickable 	   IsBarren    PushAnimation 
   idle_dead    picked        )   )   )   )   *   *   *   *   ,   ,   ,   ,   ,   ,   -   -   -   -   -   /   /   /   /   2         inst                4   6        F @ K@� ��  \@� �    
   AnimState    PlayAnimation    picked        5   5   5   5   6         inst                :   j    {   E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� ���� �A���B �A����� �A���B B� �A ���� D�� BD�A��� �D��� ��D������@ � � C �A ˁ� A� �A��� ���Ɂƌ�� ������A �B ��G�A �� ���  ����� ���� ���� ��� ����� �������� ��� ����� ����AI��� ����AI�ˁ� A�	 �A�ˁ� A
 �A�ˁ� AB
 �A��� �A�ˁ�E�
 F��A��� �A��A�D��A��� �A�ˁ�AB �A�ˁ� A� �A��� ����AL��� ��� ����  � �A ^   � 4      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    AddMiniMapEntity    SetIcon 
   grass.png    SetBank    grass 	   SetBuild    grass1    PlayAnimation    idle    SetTime    math    random        @      �?      �?   SetMultColour       �?   AddComponent 	   pickable    components 
   picksound    dontstarve/wilson/pickup_reeds    SetUp 	   cutgrass    TUNING    GRASS_REGROW_TIME 
   onregenfn    onpickedfn    makeemptyfn    makebarrenfn    makefullfn    max_cycles       @   cycles_left    inspectable    lootdropper 	   workable    SetWorkAction    ACTIONS    DIG    SetOnFinishCallback    SetWorkLeft 	   burnable 	   burntime       .@   fxdata    MakeSmallPropagator     {   ;   ;   <   <   <   =   =   =   >   >   >   ?   ?   ?   A   A   A   C   C   C   D   D   D   E   E   E   E   F   F   F   F   F   F   G   G   G   G   G   H   H   H   H   H   H   K   K   K   L   L   L   N   N   N   N   N   N   N   O   O   O   O   P   P   P   P   Q   Q   Q   Q   R   R   R   R   S   S   S   S   T   T   T   U   U   U   W   W   W   Z   Z   Z   [   [   [   \   \   \   \   \   \   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   b   b   b   c   c   c   d   d   d   d   e   e   e   i   j         Sim     z      inst    z      trans    z      anim    z      sound    z      minimap    z      color &   z      
   onregenfn    onpickedfn    makeemptyfn    makebarrenfn    makefullfn    dig_up    burnfxdata .                                    
                                             !   %   2   6   j   j   j   j   j   j   j   j   l   l   l   l   l   l   l   l   
      assets 
   -      prefabs    -      dig_up    -      burnfxdata    -   
   onregenfn    -      makefullfn    -      makebarrenfn    -      onpickedfn    -      makeemptyfn    -      fn &   -       