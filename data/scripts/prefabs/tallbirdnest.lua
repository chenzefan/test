LuaQ  q   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\tallbirdnest.lua           -   
   E   �@  ��  \ �"@  J ���  �  A b@��� ��A�� ��@ $  dA    ���       ���  $ dB    �� ��    $    dC   �  �        �   �� ��  �@  �� ���   �       Asset    ANIM    data/anim/tallbird_egg.zip 
   smallbird 	   tallbird    tallbirdegg    TUNING 	   DAY_TIME ffffff�?      0@   Prefab    common/objects/tallbirdnest 
                  F @ Z   � �F @ K@� \@ 	�@� �    	   nesttask    Cancel                                       inst                        '   F @ F@� Z   @�F @ F�� Z   @�E�  � @ �@@� A\ @��A Ł ��B ܁  � F�A K�\   ��  �    ��� ��@ ��@�AB�A @ �a�  �� � 
      components    childspawner 	   pickable    pairs    childrenoutside    distsq    Vector3 
   Transform    GetWorldPosition    Regen     '                                                                                                                               inst     &      (for generator)    &      (for state)    &      (for control)    &      k    $      v    $         TALLBIRD_LAY_DIST     "   $       K@@ �   � \� 	@ � �    	   nesttask    DoPeriodicTask        #   #   #   #   #   $         inst           
   NEST_TIME 
   DoNesting     &   1     
    	@ ��@@ ��@�  �@�� A �@A��A�� A �@A�   ��Z    ��  � A �@��@��  ��AƁ��   ��AƁ����@� �A���   � �       thief 
   AnimState    PlayAnimation    nest    components    childspawner    noregen    pairs    childrenoutside    combat    SuggestTarget         '   (   (   (   (   )   )   )   *   *   *   *   *   *   +   +   +   +   +   +   ,   ,   ,   ,   -   -   -   -   -   +   .   1         inst           picker           (for generator)          (for state)          (for control)          k          v               3   6        F @ K@� ��  \@�F�@ F � I��� �    
   AnimState    PlayAnimation    nest    components    childspawner    noregen        4   4   4   4   5   5   5   6         inst                8   =       F @ K@� ��  \@�F�@ F � I���D   �   \@ 	  � 	   
   AnimState    PlayAnimation    eggnest    components    childspawner    noregen     thief         9   9   9   9   :   :   :   ;   ;   ;   <   =         inst              StopNesting     ?   C     
   F @ F@� Z    �F @ F@� K�� � �\@� �       components 	   pickable    Pick     
   @   @   @   @   A   A   A   A   A   C         inst     	           E   I       F @ F@� Z    �F @ F@� K�� \� Z@  � �D   �   \@  �       components 	   pickable    CanBePicked        F   F   F   F   F   F   F   F   F   F   G   G   G   I         inst              StartNesting     K   M       D   �   \@  �            L   L   L   M         inst              StopNesting     P   w    	_   E   \�� �@� ��@�� �@� ���܀ A� A� KAA�� \A�K��� \A�KA��� \A�K���   \A KA� �� \A�F�� F��K��A  \A F�� F��K���  \A�F�� F��K���� \A�F�� F��K�� \A�EA �� \A E� �� \A KA� �� \A�F�� F��IAF�F�� F���� �GI��F�� F��I�ǎF�� F��K����\A�F�� F��K��A \A�F�� F��K��\A KA� �� \A�K� �A	  \A K� ��	 �\A ^   � '      CreateEntity    entity    AddTransform    AddAnimState    AddMiniMapEntity    SetIcon    tallbirdnest.png 	   SetBuild    tallbird_egg    SetBank    egg    PlayAnimation    eggnest    AddComponent 	   pickable    components    SetUp    tallbirdegg    SetOnPickedFn    SetOnRegenFn    SetMakeEmptyFn    MakeMediumBurnable    MakeSmallPropagator    childspawner 
   childname 	   tallbird    regenperiod    TUNING 	   DAY_TIME    spawnperiod            SetSpawnedFn    SetMaxChildren       �?   StartSpawning    inspectable    ListenForEvent    entitysleep    entitywake     _   Q   Q   R   R   R   S   S   S   U   U   U   V   V   V   X   X   X   Y   Y   Y   Z   Z   Z   Z   \   \   \   ^   ^   ^   ^   ^   ^   _   _   _   _   _   `   `   `   `   `   a   a   a   a   a   d   d   d   e   e   e   h   h   h   i   i   i   j   j   j   j   j   k   k   k   l   l   l   l   l   m   m   m   m   m   n   n   n   n   q   q   q   r   r   r   r   s   s   s   s   v   w         Sim     ^      inst    ^      trans    ^      anim    ^      minimap    ^      	   onpicked 	   onregrow    onmakeempty 	   onvacate    onsleep    onwake -                           	                                $   $   $   1   6   =   =   C   I   I   M   M   w   w   w   w   w   w   w   y   y   y   y   y   y   y   y         assets    ,      prefabs    ,   
   NEST_TIME    ,      TALLBIRD_LAY_DIST    ,      StopNesting    ,   
   DoNesting    ,      StartNesting    ,   	   onpicked    ,      onmakeempty    ,   	   onregrow    ,   	   onvacate    ,      onsleep    ,      onwake    ,      fn %   ,       