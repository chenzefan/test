LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\grass.lua           %   
 � E   �@  ��  \���   ��   � �"@  J  �@ �� b@ �   �@  $�  d�  � �A $� d�      �        �     ��� �  �@  �� ���   � 	      Asset    ANIM    data/anim/grass.zip    SOUND    data/sound/common.fsb 	   cutgrass 
   dug_grass    Prefab    forest/objects/grass                   F @ F@� K�� \@  �       components 	   pickable    MakeBarren                             inst                           � @ �@@�   ��� @ �@@��@�� �    �� @ ��@� AA �@���A �@ � @ ��@� A� ��� �       components 	   pickable    CanBePicked    lootdropper    SpawnLootPrefab 	   cutgrass    Remove 
   dug_grass                                                                                   inst           chopper           bush                       
   F @ K@� ��  \@�F @ K�� �  � \@  �    
   AnimState    PlayAnimation    grow    PushAnimation    idle     
                                       inst     	               "        F @ K@� ��  � \@  �    
   AnimState    PlayAnimation    idle        !   !   !   !   !   "         inst                $   &        F @ K@� ��  \@� �    
   AnimState    PlayAnimation 
   idle_dead        %   %   %   %   &         inst                )   3        F @ K@� ��  \@�F�@ K � �@ \@�F�A F�� K � \� Z    �F�@ K@� �� \@�� �F�@ K@� �� \@� �       SoundEmitter 
   PlaySound    dontstarve/wilson/pickup_reeds 
   AnimState    PlayAnimation    picking    components 	   pickable 	   IsBarren    PushAnimation 
   idle_dead    picked        *   *   *   *   +   +   +   +   -   -   -   -   -   -   .   .   .   .   .   0   0   0   0   3         inst                5   7        F @ K@� ��  \@� �    
   AnimState    PlayAnimation    picked        6   6   6   6   7         inst                ;   j    x   E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� ���� �A���B �A����� �A���B B� �A ���� D�� BD�A��� �D��� ��D������@ � � C �A ˁ� A� �A��� ���Ɂƌ�� ������A �B ��G�A �� ���  ����� ���� ���� ��� ����� �������� ��� ����� ����AI��� ����AI��� �������ˁ� A
 �A�ˁ� AB
 �A�ˁ� A�
 �A��� Ɓ����E FB��A��� Ɓ�ˁ�D �A��� Ɓ����AB �A��  � �A �A  � �A ^   � 2      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    AddMiniMapEntity    SetIcon 
   grass.png    SetBank    grass 	   SetBuild    grass1    PlayAnimation    idle    SetTime    math    random        @      �?      �?   SetMultColour       �?   AddComponent 	   pickable    components 
   picksound    dontstarve/wilson/pickup_reeds    SetUp 	   cutgrass    TUNING    GRASS_REGROW_TIME 
   onregenfn    onpickedfn    makeemptyfn    makebarrenfn    makefullfn    max_cycles       4@   cycles_left    ontransplantfn    inspectable    lootdropper 	   workable    SetWorkAction    ACTIONS    DIG    SetOnFinishCallback    SetWorkLeft    MakeMediumBurnable    MakeSmallPropagator     x   <   <   =   =   =   >   >   >   ?   ?   ?   @   @   @   B   B   B   D   D   D   E   E   E   F   F   F   F   G   G   G   G   G   G   H   H   H   H   H   I   I   I   I   I   I   L   L   L   M   M   M   O   O   O   O   O   O   O   P   P   P   P   Q   Q   Q   Q   R   R   R   R   S   S   S   S   T   T   T   T   U   U   U   V   V   V   W   W   W   W   Y   Y   Y   \   \   \   ]   ]   ]   ^   ^   ^   ^   ^   ^   _   _   _   _   _   `   `   `   `   `   d   d   d   e   e   e   i   j         Sim     w      inst    w      trans    w      anim    w      sound    w      minimap    w      color &   w      
   onregenfn    onpickedfn    makeemptyfn    makebarrenfn    makefullfn    ontransplantfn    dig_up %                                    
                  "   &   3   7   j   j   j   j   j   j   j   j   l   l   l   l   l   l   l   l   
      assets 
   $      prefabs    $      ontransplantfn    $      dig_up    $   
   onregenfn    $      makefullfn    $      makebarrenfn    $      onpickedfn    $      makeemptyfn    $      fn    $       