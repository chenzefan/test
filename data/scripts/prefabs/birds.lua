LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\birds.lua           	   
 � A   "@� d   �@  �  $�  d       �        � ���A  �� ���  � �   �    
   smallmeat    crow    robin                   E   K@� ��  \��Z    ���� � A�    ���� � A�@A   �@� �       TheSim    FindFirstEntityWithTag    ground    components    birdspawner    StartTracking                                                              inst           ground                          E   K@� ��  \��Z    ���� � A�    ���� � A�@A   �@� �       TheSim    FindFirstEntityWithTag    ground    components    birdspawner    StopTracking                                                              inst           ground                          E   �   \� Z    �F@@ K�� ��  \��S � ^   �       DefaultSleepTest    sg    HasStateTag    flying                                                  inst                !   #        F @ K@� ��  \@� �       sg 
   GoToState    stunned        "   "   "   "   #         inst                %   �    =   J ��   �@  �  ����   A  A�  �  � U��܀�  AA �� �  � ���E  � �A \�b@  � ��� � A �  U���@�ʀ  � @  A� �� @  A� ��$      dA    �        �       �  �A ��    �� �@� � ���   �       Asset    ANIM    data/anim/crow.zip    data/anim/    _build.zip    IMAGE    data/inventoryimages/    .tex    SOUND    data/sound/birds.fsb    seeds 
   smallmeat 	   feather_    takeoff    dontstarve/birds/takeoff_    chirp    dontstarve/birds/chirp_    Prefab    forest/animals/        ;   ?       � � �    �� � �@@��@�  D  � U����  �@� �       trapper 
   AnimState    OverrideSymbol    trapped    _build        <   <   <   =   =   =   =   =   =   =   =   =   ?         inst           data              name     A   ~     	�      �� F@@ K�� \� �@@ ��@�� �@@ � �܀   	 ��A@ �AA �A BA A@ AB� K�B��  \A KAC�  \A�F�C K��� �A�\A�F�C K��\A F�C K��� ��\A�F�C KA��� \A�F�C K���� \A�KF �A \A�KF �� \A�KF �� \A�K�F� \A�KAG�� \A�K�G��  ��\A�KAH �� \A�K�H �	 \A�FAI F�K��� \A�FAI F�K���
 � ��B
 \A K�H ��
 \A�K�H ��
 \A�FAI F��K�\A K�H �A \A�FAI FA�K����\A�K�H �� \A�FAI F��IAL�FAI F��I�L�FAI F��K�� \A�K�H �A \A�K�H �� \A�FAI F��K��� �A�\A�K�H �� \A�K�H �� \A�E �A \A K�O �� �� \A  KP �A �\A KP ��  \A KP ��  \A KP � �\A    � E      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    sounds    AddPhysics 
   Transform    SetTwoFaced    AddDynamicShadow    SetSize       �?      �?   Enable    Physics    SetCollisionGroup 
   COLLISION    CHARACTERS    ClearCollisionMask    CollidesWith    WORLD 
   SetSphere       �?   SetMass    AddTag    bird    smallcreature    SetBank    crow    PlayAnimation    idle 	   SetBuild    _build    SetStateGraph    SGbird.lua    AddComponent    lootdropper    components    SetLoot    AddChanceLoot 	   feather_       �?	   occupier    eater    SetBird    sleeper    SetSleepTest    inventoryitem 	   nobounce    canbepickedup     SetOnDroppedFn    combat    health    SetMaxHealth    TUNING    BIRD_HEALTH    inspectable 
   locomotor    require    brains/birdbrain 	   SetBrain 
   BirdBrain    ListenForEvent 
   ontrapped 	   onremove    enterlimbo 
   exitlimbo     �   B   B   C   C   C   D   D   D   E   E   E   F   F   G   G   G   H   H   H   I   I   I   J   J   J   J   K   K   K   M   M   M   M   M   N   N   N   O   O   O   O   O   Q   Q   Q   Q   R   R   R   R   T   T   T   U   U   U   V   V   V   X   X   X   Y   Y   Y   Z   Z   Z   Z   Z   [   [   [   ]   ]   ]   ^   ^   ^   ^   ^   _   _   _   _   _   _   _   _   a   a   a   c   c   c   d   d   d   d   f   f   f   g   g   g   g   g   i   i   i   j   j   j   k   k   k   l   l   l   l   l   n   n   n   o   o   o   p   p   p   p   p   p   r   r   r   t   t   t   v   v   v   w   w   w   w   y   y   y   y   z   z   z   z   {   {   {   {   |   |   |   |   }   ~         inst    �      trans    �      anim    �      sound    �      shadow    �         sounds    name    loot    ShouldSleep    ondrop 
   OnTrapped    StopTrackingInSpawner    TrackInSpawner =   &   (   (   (   (   )   )   )   )   )   )   )   *   *   *   *   *   *   *   +   +   +   +   ,   .   0   1   2   2   2   3   5   7   7   7   7   8   8   8   8   ?   ?   ~   ~   ~   ~   ~   ~   ~   ~   ~   �   �   �   �   �   �   �   �   �   �         name     <      assets    <      prefabs    <      sounds (   <   
   OnTrapped *   <      fn 3   <         loot    ShouldSleep    ondrop    StopTrackingInSpawner    TrackInSpawner    
                  #   �   �   �   �   �   �   �   �   �   �   �   �   �   �         loot          TrackInSpawner          StopTrackingInSpawner          ShouldSleep          ondrop       	   makebird           