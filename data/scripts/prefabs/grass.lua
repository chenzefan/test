LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\grass.lua           0   
 � E   �@  ��  \���   ��   � �"@  J  �@ �� b@ �   �@  
� J�  � �A B AB �� I���I�B�"A� d�  ��  � $B d� ��   �     �  �        �   � C @ �  �� ���   �       Asset    ANIM    data/anim/grass.zip    SOUND    data/sound/common.fsb 	   cutgrass 
   dug_grass    pt    Vector3            lev       @   Prefab    forest/objects/grass                   F @ F@� K�� \@  �       components 	   pickable    MakeBarren                             inst                           � @ �@@�   ��� @ �@@��@�� �    �� @ ��@� AA �@���A �@ � @ ��@� A� ��� �       components 	   pickable    CanBePicked    lootdropper    SpawnLootPrefab 	   cutgrass    Remove 
   dug_grass                                                                                   inst           chopper           bush                        
   F @ K@� ��  \@�F @ K�� �  � \@  �    
   AnimState    PlayAnimation    grow    PushAnimation    idle     
                                        inst     	           "   $        F @ K@� ��  � \@  �    
   AnimState    PlayAnimation    idle        #   #   #   #   #   $         inst                &   (        F @ K@� ��  \@� �    
   AnimState    PlayAnimation 
   idle_dead        '   '   '   '   (         inst                +   5        F @ K@� ��  \@�F�@ K � �@ \@�F�A F�� K � \� Z    �F�@ K@� �� \@�� �F�@ K@� �� \@� �       SoundEmitter 
   PlaySound    dontstarve/wilson/pickup_reeds 
   AnimState    PlayAnimation    picking    components 	   pickable 	   IsBarren    PushAnimation 
   idle_dead    picked        ,   ,   ,   ,   -   -   -   -   /   /   /   /   /   /   0   0   0   0   0   2   2   2   2   5         inst                7   9        F @ K@� ��  \@� �    
   AnimState    PlayAnimation    picked        8   8   8   8   9         inst                =   n       E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� ���� �A���B �A����� �A���B B� �A ���� D�� BD�A��� �D��� ��D������@ � � C �A ˁ� A� �A��� ���Ɂƌ�� ������A �B ��G�A �� ���  ����� ���� ���� ��� ����� �������� ��� ����� ����AI��� ����AI��� �������ˁ� A
 �A�ˁ� AB
 �A�ˁ� A�
 �A��� Ɓ����E FB��A��� Ɓ�ˁ�D �A��� Ɓ����AB �A�ˁ� A �A��� ��Ɂ̘�� �������  � �A ^   � 5      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    AddMiniMapEntity    SetIcon 
   grass.png    SetBank    grass 	   SetBuild    grass1    PlayAnimation    idle    SetTime    math    random        @      �?      �?   SetMultColour       �?   AddComponent 	   pickable    components 
   picksound    dontstarve/wilson/pickup_reeds    SetUp 	   cutgrass    TUNING    GRASS_REGROW_TIME 
   onregenfn    onpickedfn    makeemptyfn    makebarrenfn    makefullfn    max_cycles       4@   cycles_left    ontransplantfn    inspectable    lootdropper 	   workable    SetWorkAction    ACTIONS    DIG    SetOnFinishCallback    SetWorkLeft 	   burnable 	   burntime       .@   fxdata    MakeSmallPropagator        >   >   ?   ?   ?   @   @   @   A   A   A   B   B   B   D   D   D   F   F   F   G   G   G   H   H   H   H   I   I   I   I   I   I   J   J   J   J   J   K   K   K   K   K   K   N   N   N   O   O   O   Q   Q   Q   Q   Q   Q   Q   R   R   R   R   S   S   S   S   T   T   T   T   U   U   U   U   V   V   V   V   W   W   W   X   X   X   Y   Y   Y   Y   [   [   [   ^   ^   ^   _   _   _   `   `   `   `   `   `   a   a   a   a   a   b   b   b   b   b   f   f   f   g   g   g   h   h   h   h   i   i   i   m   n         Sim     ~      inst    ~      trans    ~      anim    ~      sound    ~      minimap    ~      color &   ~      
   onregenfn    onpickedfn    makeemptyfn    makebarrenfn    makefullfn    ontransplantfn    dig_up    burnfxdata 0                                    
                                                 $   (   5   9   n   n   n   n   n   n   n   n   n   p   p   p   p   p   p   p   p         assets 
   /      prefabs    /      ontransplantfn    /      dig_up    /      burnfxdata    /   
   onregenfn    /      makefullfn    /      makebarrenfn    /      onpickedfn    /      makeemptyfn    /      fn (   /       