LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\chester.lua           E      A@  @    A�  @ �  A  � � �@ � A� ܀�A A� � ��@  � � A �@� $      dA    � ��  ��  $ dB �  �� � A �B��� � AD ��ń ���	  E ������D�ED΅��ͅ��E�� \ �D  �C����      �        �  �   � A ���  ��   �       require    prefabutil    brains/chesterbrain       ,@      @   Asset    ANIM    data/anim/chester.zip    data/anim/ui_chest_3x2.zip    chester_eyebone        @              �      �?   table    insert    Vector3       T@      d@   Prefab    common/chester                  E   �   \� Z@  @�F@@ F�� K�� �   \��S � ^   �       DefaultWakeTest    components 	   follower    IsNearLeader                                                     inst              WAKE_TO_FOLLOW_DISTANCE               E   �   \� Z   @�F@@ K�� ��  \��Z@  @�F A F@� K�� �   \��@ �B@  B � ^   �       DefaultSleepTest    sg    HasStateTag    open    components 	   follower    IsNearLeader                                                                             inst              SLEEP_NEAR_LEADER_DISTANCE                F @ F@� K�� \� Z@  � �F�@ K � �@ \@� �       components    health    IsDead    sg 
   GoToState    open                                               inst     
               $        F @ F@� K�� \� Z@  � �F�@ K � �@ \@� �       components    health    IsDead    sg 
   GoToState    close        !   !   !   !   !   !   "   "   "   "   $         inst     
           '   *        K @ �@  \@� �    
   RemoveTag 
   companion        )   )   )   *         inst                ,   /        K @ �@  \@� �       AddTag 
   companion        .   .   .   /         inst                9   �     �      �� K@@ ��  \@�K@@ ��  \@�K@@ �  \@�K@@ �@ \@�F�A K�� \@ F�A K � \@ F@B K�� �@ \@�F@B K�� �@ \@�F�A K � \@ F�A K@� \@ F�C K�� �  A \@ E� �   ��  \@ F@E K�� �� � �\@�F@E K@� \@ F@E K�� �� ���\@�F@E K�� �� � �\@�F@E K�� �� � �\@�F@G K�� \@ K�G �  \@�F@H F � I�H�K�G � 	 \@�F@H F � K@� ŀ	 ���\@�F@H F � K � ŀ	 �@��	 �J\@ K�G ��
 \@�K�G �  \@�F@H F � I�˖F@H F � I ̗K�G �@ \@�K�L ��   \@ K�L �  � \@ K�G �@ \@�E� �   �� \@�K�G �� \@�F@H F�� K � �  � �\@�F@H F�� � �I���F@H F�� �  I� �F@H F�� �  I���F@H F�� I@O�F@H F�� I@O�F@H F�� �  �@ � AA �� I���K�G �� \@�F@H F�� K � �� \@�F@H F�� �� ��  ���I���F@H F�� K � � �\@�F@H F�� K@� �  \@�K�R �� \@�F S K@� �� \@�K�S �  � � \@     � Q      CreateEntity    AddTag 
   companion 
   character    scarytoprey    chester    entity    AddTransform    AddAnimState 
   AnimState    SetBank 	   SetBuild    AddSoundEmitter    AddDynamicShadow    DynamicShadow    SetSize        @      �?   MakeCharacterPhysics      �R@      �?   Physics    SetCollisionGroup 
   COLLISION    CHARACTERS    ClearCollisionMask    CollidesWith    WORLD 
   OBSTACLES 
   Transform    SetFourFaced    AddComponent    combat    components    hiteffectsymbol    chester_body    health    SetMaxHealth    TUNING    CHESTER_HEALTH    StartRegen    CHESTER_HEALTH_REGEN_AMOUNT    CHESTER_HEALTH_REGEN_PERIOD    inspectable 
   locomotor 
   walkspeed       @	   runspeed       @	   follower    ListenForEvent    stopfollowing    startfollowing    knownlocations    MakeSmallBurnableCharacter 
   container    SetNumSlots 	   onopenfn 
   onclosefn    widgetslotpos    widgetanimbank    ui_chest_3x3    widgetanimbuild 
   widgetpos    Vector3              �f�   sleeper    SetResistance    testperiod    GetRandomWithVariance       @   SetSleepTest    SetWakeTest    SetStateGraph    SGchester.lua    sg 
   GoToState    idle 	   SetBrain    ChesterBrain     �   <   <   >   >   >   ?   ?   ?   @   @   @   A   A   A   C   C   C   F   F   F   G   G   G   G   H   H   H   H   K   K   K   N   N   N   O   O   O   O   O   R   R   R   R   R   U   U   U   U   U   V   V   V   W   W   W   W   W   X   X   X   X   X   Y   Y   Y   Y   Y   [   [   [   b   b   b   c   c   c   g   g   g   h   h   h   h   h   h   i   i   i   i   i   i   i   i   l   l   l   p   p   p   q   q   q   r   r   r   u   u   u   v   v   v   v   w   w   w   w   z   z   z   }   }   }   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst    �         OnStopFollowing    OnStartFollowing    slotpos    OnOpen    OnClose    ShouldSleep    ShouldWakeUp E                              	   	   	   	   
   
   
   
                              $   *   /   1   3   3   3   3   4   4   4   4   5   5   5   5   5   5   5   5   5   5   5   5   5   4   3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         WAKE_TO_FOLLOW_DISTANCE    D      SLEEP_NEAR_LEADER_DISTANCE    D      assets    D      prefabs    D      ShouldWakeUp    D      ShouldSleep    D      OnOpen    D      OnClose    D      OnStopFollowing    D      OnStartFollowing    D      slotpos    D      (for index) !   5      (for limit) !   5      (for step) !   5      y "   4      (for index) %   4      (for limit) %   4      (for step) %   4      x &   3      create_chester =   D       