LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\reeds.lua               
  E   �@  ��  \���   �@  �  ����    AA � �"@  J � �� b@� �   �@  $�  d�    �      �� �  �@  �� ���   � 	      Asset    ANIM    data/anim/grass.zip    data/anim/reeds.zip    SOUND    data/sound/common.fsb 	   cutreeds    Prefab    forest/objects/reeds                   F @ K@� ��  \@�F�@ K � �@ \@�F�@ K�� �� \@� �       SoundEmitter 
   PlaySound    dontstarve/wilson/pickup_reeds 
   AnimState    PlayAnimation    picking    PushAnimation    picked                                                     inst                        
   F @ K@� ��  \@�F @ K�� �  � \@  �    
   AnimState    PlayAnimation    grow    PushAnimation    idle     
                                       inst     	                      F @ K@� ��  \@� �    
   AnimState    PlayAnimation    picked                             inst                   D    ]   E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� ���� �A���B �A����� �A���B B� �A ���� D�� BD�A��� �D��� ��D������@ � � C �A ˁ� A� �A��� ���Ɂƌ�� ������A �B ��G�A �� ���  ����� ���� ���� ��� ����� �����H�ˁ� A	 �A�ˁ� AB	 �A��� �A�B �I���
  � EB F���A��A
  � �A ^   � *      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    AddMiniMapEntity    SetIcon 
   reeds.png    SetBank    grass 	   SetBuild    reeds    PlayAnimation    idle    SetTime    math    random        @      �?      �?   SetMultColour       �?   AddComponent 	   pickable    components 
   picksound    dontstarve/wilson/pickup_reeds    SetUp 	   cutreeds    TUNING    REEDS_REGROW_TIME 
   onregenfn    onpickedfn    makeemptyfn    SetRegenTime       ^@   inspectable    fuel 
   fuelvalue    SMALL_FUEL    MakeSmallBurnable    MakeSmallPropagator     ]                              !   !   !   "   "   "   $   $   $   &   &   &   '   '   '   (   (   (   (   )   )   )   )   )   )   *   *   *   *   *   +   +   +   +   +   +   .   .   .   /   /   /   0   0   0   0   0   0   0   1   1   1   1   2   2   2   2   3   3   3   3   5   5   5   7   7   7   ;   ;   ;   <   <   <   <   <   >   >   >   >   >   ?   ?   ?   C   D         Sim     \      inst    \      trans    \      anim    \      sound    \      minimap    \      color &   \      
   onregenfn    onpickedfn    makeemptyfn                                                                 D   D   D   D   F   F   F   F   F   F   F   F         assets          prefabs          onpickedfn       
   onregenfn          makeemptyfn          fn           