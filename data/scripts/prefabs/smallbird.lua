LuaQ  n   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\smallbird.lua                 A@  @    A�  @ �  A  �   �@ � A� � ��@  �   $A  d�       �  �     � �A  �@ �� ���   �       require    fonthelper    brains/smallbirdbrain       4@      @   Asset    ANIM    data/anim/smallbird_basic.zip    Prefab    common/smallbird    prefabs                   E   �@  \@ E�  K�� �  \��Z   ���@� ��A�   ���   �� �@ �@� ��A� B   �@� � 	      print    smallbird - FollowPlayer    TheSim    FindFirstEntityWithTag    player    components    leader       adding follower    AddFollower                                                                                inst           player                  -      "      A@  @ �  �� F�@ K � \� ��@ �@A�� ˀA A� �@�ˀA A �@�ˀA AA �@�ˀA A� �@���BAA �@�� CAA �@�ˀC A� �@�   �       print    smallbird - commonfn    CreateEntity    entity    AddTransform    AddAnimState    AddTag    animal 
   companion 
   smallbird    smallcreature    SetBank 	   SetBuild    smallbird_basic    AddComponent    inspectable     "                                                !   !   !   "   "   "   #   #   #   %   %   %   &   &   &   )   )   )   ,   -         inst    !      trans    !      anim    !           /   n     �      A@  @    �� K�@ ��  \@�F A K@� \� � A ��A�� ��A � ��@ �@    A� �� �@ � C AA �@�ƀC �@�� ć�@D A� �@�� C A� �@�ƀC ���� �EA F���@�� C A� �@�ƀC ���A AF� �ƀC ���ˀ�EA F���@�ƀC ���� �EA FA��@�ƀG ���E FA��@�ƀG ˀ��@ ƀG ���E F��@�ƀG ���E FA��@�ƀG ���E FA��@�ˀI E�	 \� �@  � J �@�A�
 �� �@ � C A�
 �@��@  � � ��	� �� C A� �@�ƀC ƀ����A �@�ƀC ƀ�� A �� ��� ��ƀC ƀ�� �d        �@�ƀC ƀ��@�dA       ��@�   � 6      print    smallbird - defaultfn    AddTag 
   character    entity    AddSoundEmitter    AddDynamicShadow 
   Transform    SetFourFaced    MakeCharacterPhysics       $@      �?   AddComponent 
   locomotor    components 
   walkspeed       @   SetStateGraph    SGsmallbird.lua    health    SetMaxHealth    TUNING    SMALLBIRD_HEALTH    combat    range    SMALLBIRD_ATTACK_RANGE    SetDefaultDamage    SMALLBIRD_DAMAGE    SetAttackPeriod    SMALLBIRD_ATTACK_PERIOD    Physics    SetCollisionGroup 
   COLLISION    CHARACTERS    ClearCollisionMask    CollidesWith    WORLD 
   OBSTACLES 	   SetBrain    SmallBirdBrain    DynamicShadow    SetSize       �?	   follower    userfunctions    FollowPlayer    sleeper    SetResistance       @   testperiod    GetRandomWithVariance        @   SetSleepTest    SetWakeTest        c   f           D   �    ��   @@ �@ �@    @�   @@ �@ �@  A �   ��D � � � N�� Y@    �@   �    �       DefaultSleepTest    components 	   follower    leader    GetDistanceSqToInst        d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   d   e   f         sleep             inst    SLEEP_NEAR_LEADER_DISTANCE     h   k           D   � @  ��   @@ �@ �@    @�   @@ �@ �@  A �   ��D � � � N�� Y �   �@   �    �       DefaultWakeTest    components 	   follower    leader    GetDistanceSqToInst        i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   j   k         wake             inst    WAKE_TO_FOLLOW_DISTANCE �   0   0   0   2   2   4   4   4   6   6   6   7   7   7   8   8   8   9   9   9   9   9   ;   ;   ;   <   <   <   >   >   >   C   C   C   D   D   D   D   D   D   F   F   F   G   G   G   G   G   H   H   H   H   H   H   I   I   I   I   I   I   N   N   N   N   N   O   O   O   P   P   P   P   P   Q   Q   Q   Q   Q   R   R   R   R   R   T   T   T   T   V   V   V   V   V   X   X   X   [   ]   ]   ^   `   `   `   a   a   a   a   a   b   b   b   b   b   b   b   c   c   c   f   f   f   c   h   h   h   k   k   k   h   m   n         inst    �      sound    �      shadow    �      	   commonfn    FollowPlayer    SLEEP_NEAR_LEADER_DISTANCE    WAKE_TO_FOLLOW_DISTANCE                               	   	   	   	         -   n   n   n   n   n   p   p   p   p   p   p   p   p         WAKE_TO_FOLLOW_DISTANCE          SLEEP_NEAR_LEADER_DISTANCE          assets          FollowPlayer       	   commonfn       
   defaultfn           