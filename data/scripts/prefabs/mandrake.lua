LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\mandrake.lua           8      A@  @    A�  @ 
 �E�  �  �@ \����  �� � �����   AA ܀��  A �� �"@  J � �� b@� �   �@  $�  d�  �   ��A $�   �  �  �         d�   �� �B   @  �� ���� � @��  � �   �       require    fonthelper    brains/mandrakebrain    Asset    ANIM    data/anim/mandrake.zip    SOUND    data/sound/mandrake.fsb    IMAGE "   data/inventoryimages/mandrake.tex (   data/inventoryimages/cookedmandrake.tex    cookedmandrake    Prefab    common/mandrake    common/cookedmandrake           '     G   K @ �@  \@�K�@ ��  \@�K A �@ \@�F�A F@� K�� �  \@�F�A F@� I�K A �� \@�F C K@� ŀ ���\@�F C K � \@ F C K@� ŀ ƀ�\@�F C K@� ŀ ���\@�F C K@� ŀ ���\@�K E �@ � � \@  F�E K�� �  A \@ K A �� \@�E� K � �@ \��Z    ���� ��G�    ���� ��G��G   �@� �        AddTag    picked    RemoveComponent 	   pickable    AddComponent    health    components    SetMaxHealth       4@
   nofadeout    combat    Physics    SetCollisionGroup 
   COLLISION    CHARACTERS    ClearCollisionMask    CollidesWith    WORLD 
   OBSTACLES 	   SetBrain    MandrakeBrain    DynamicShadow    SetSize       �?      �?	   follower    TheSim    FindFirstEntityWithTag    player    leader    AddFollower     G                                                                                                                                                                    !   !   !   "   "   "   "   #   #   #   #   #   #   $   $   $   $   $   '         inst     F      player ;   F           )   ;     D   K @ �@  \@�K�@ ��  \@�K�@ �  \@�K�@ �@ \@�K�@ �� \@�F�A K � �@ ƀ�\@�F�A K�� \@ F�A K � �@ �@�\@�F�A K � �@ ƀ�\@�F�A K�� �  \@�F�A K@� �� \@�F�A K�� �  \@�F�A K@� �� \@�F�E K � �   \@ F@F F�� I ǍF@F F�� K@� �   \@�F@F F�� K�� �@  \@� �       AddTag    item    RemoveComponent 	   pickable    combat 	   follower    health    Physics    SetCollisionGroup 
   COLLISION    ITEMS    ClearCollisionMask    CollidesWith    WORLD 
   OBSTACLES    SetMass       �?   SetFriction �������?   SetDamping            SetRestitution       �?   DynamicShadow    SetSize    components    inventoryitem    canbepickedup    SetOnPickupFn    SetOnDroppedFn        9   9        F @ K@� ��  \@� �       sg 
   GoToState    item        9   9   9   9   9         inst                :   :        F @ K@� ��  \@� �       sg 
   GoToState    item        :   :   :   :   :         inst            D   *   *   *   +   +   +   ,   ,   ,   -   -   -   .   .   .   /   /   /   /   /   0   0   0   1   1   1   1   1   2   2   2   2   2   3   3   3   3   4   4   4   4   5   5   5   5   6   6   6   6   7   7   7   7   7   8   8   8   9   9   9   9   9   :   :   :   :   :   ;         inst     C           =   P     C   K @ �@  \@�F�@ F�� Z@  � �K A ��  \@�F@A K�� �� � �\@�F@A K@� \@ F@A K�� �� ���\@�F C K@� �� � \@ F�@ F�� I ćF�@ F�� �   I���E� K�� �  \��Z   ����� �@E�   ����� �@E��E   ����    ���� �@E��E   �@�� F A �@�� F � �@�� F � �@� �    
   RemoveTag    picked    components 	   pickable    AddComponent    Physics    SetCollisionGroup 
   COLLISION    ITEMS    ClearCollisionMask    CollidesWith    WORLD    DynamicShadow    SetSize            canbepicked    onpickedfn    TheSim    FindFirstEntityWithTag    player    leader    IsFollower    RemoveFollower    RemoveComponent    combat 	   follower    health        H   H        F @ K@� ��  \@� �       sg 
   GoToState    picked        H   H   H   H   H         inst            C   >   >   >   @   @   @   @   A   A   A   C   C   C   C   C   D   D   D   E   E   E   E   E   F   F   F   F   F   G   G   G   H   H   H   H   I   I   I   I   J   J   J   J   J   J   J   J   J   J   J   J   J   K   K   K   K   K   M   M   M   N   N   N   O   O   O   P         inst     B      player '   B           R   [     $   � @ �@@�  �@���  � � �@��  ��  ŀ ���FB�ABƁB� C܀ A @���W@ @�F�CF��Z  @�F�CF��K��� �B�\B�!�  @� �       SoundEmitter 
   PlaySound $   dontstarve/creatures/mandrake/death    Vector3 
   Transform    GetWorldPosition    TheSim    FindEntities    x    y    z    TUNING    MANDRAKE_SLEEP_RANGE    pairs    components    sleeper 
   GoToSleep    MANDRAKE_SLEEP_TIME     $   S   S   S   S   T   T   T   T   T   U   U   U   U   U   U   U   U   V   V   V   V   W   W   W   W   W   W   X   X   X   X   X   X   V   Y   [   	      inst     #      eater     #      pos 	   #      ents    #      (for generator)    #      (for state)    #      (for control)    #      k    !      v    !           ]   d       �      @ �@�� @ �@�A�  �@���  � ��@�ˀ��@ ��A� �AA �@�� Aƀ����E �AC �� \��@   �       SoundEmitter 
   PlaySound $   dontstarve/creatures/mandrake/death    TheGlobalInstance    components    clock    MakeNextDay    sg 
   GoToState    wakeup    talker    Say 
   GetString    prefab    ANNOUNCE_KNOCKEDOUT        ^   ^   ^   ^   `   `   `   `   a   a   a   a   a   b   b   b   b   c   c   c   c   c   c   c   c   d         inst           cooker           chef              OnEaten     f   �      3      �� F@@ K�� \� �@@ ��@�� � A AA �@�ˀAAA �@���AAA �@�� B AA �@�ƀB �@�$  � ��� B A �@�ƀB � �� �C� ��� B A �@�� B AA �@�ƀB �@�� �D� �� B A �@�ƀB � �ɀŊ   �       CreateEntity    entity    AddTransform    AddAnimState    AddTag 	   mandrake    SetBank 	   SetBuild    AddComponent    inspectable    components 
   getstatus    researchvalue 
   basevalue    TUNING    RESEARCH_VALUE_SUPERRARE_ITEM    inventoryitem 
   stackable    maxsize    STACK_SIZE_SMALLITEM    edible 	   foodtype    VEGGIE        s   y        K @ �@  \��Z   � �A�  ^  ��K @ ��  \��Z   @ �A  ^   �       HasTag    picked    PICKED    dead    DEAD        t   t   t   t   t   u   u   u   v   v   v   v   v   w   w   y         inst            3   h   h   i   i   i   j   j   j   l   l   l   n   n   n   o   o   o   r   r   r   s   s   y   y   z   z   z   {   {   {   {   {   |   |   |   }   }   }   ~   ~   ~   ~   ~   �   �   �   �   �   �   �   �         inst    2      trans    2      anim    2           �   �     [      �� K @ �@  \@�F�@ K�� �  \@�F@A K�� \� �@A ��A�� � B �@��@ ŀ    A� � �@ �@C A� �@���C ƀ��@D�ˀD A� �@���C � �ɀŊ��C ���� �D� �@���C �@�� G� ���C �@�� �G� ����C �@����D �@��@C A �@���C � �ɀȐ��C � ����D��@��   	� ��@     � 	���� �   �@ ��  �� ��� � � � ��	� �ˀJ A�
 ��      � �@�   � -      AddTag 
   character 
   AnimState    PlayAnimation    ground    entity    AddSoundEmitter    AddDynamicShadow 
   Transform    SetFourFaced    MakeCharacterPhysics       $@      �?   AddComponent 
   locomotor    components 
   walkspeed       @   SetStateGraph    SGMandrake.lua    inventoryitem    canbepickedup  
   stackable    SetOnDeStack    edible    healthvalue    TUNING    MANDRAKE_HEALTH    hungervalue    MANDRAKE_HUNGER    SetOnEatenFn 	   cookable    product    cookedmandrake    SetOnCookedFn    OnSave    OnLoad    userfunctions    MakePlanted 	   MakeItem    MakeFollower    ListenForEvent    daytime    TheGlobalInstance        �   �        � @ A  ����   @ �I���@�� @ �  ����     �I��� �       HasTag    picked    item        �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           data                �   �       � � �   ���   �   �@ �@@ ��@�  �@�@�� � �   ��� � �   �@ �@A ��A� �@� �       picked    sg 
   GoToState    idle    item 
   AnimState    PlayAnimation    object        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           data              MakeFollower 	   MakeItem     �   �            @ @@    ��    @ @@ �@ � @   �   �@  A �@ @� �       components    health    IsDead    sg 
   GoToState    plant        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �             inst [   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst    Z      sound    Z      shadow    Z      	   commonfn 	   MakeItem    OnEaten 	   OnCooked    MakeFollower    MakePlanted     �   �           �� F @ F@� ��  � AI� �F @ F@� ��  ��AI���K�A �  \@�K�A �@ \@�F�B K�� �  \@�   �       components    edible    healthvalue    TUNING    MANDRAKE_HEALTH    hungervalue    MANDRAKE_HUNGER    AddTag    cooked    dead 
   AnimState    PlayAnimation        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst          	   commonfn 8                                                            	   	   	   	   
            '   ;   P   [   d   d   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
      assets    7      prefabs    7      MakeFollower    7   	   MakeItem    7      MakePlanted    7      OnEaten    7   	   OnCooked !   7   	   commonfn "   7   
   defaultfn )   7   	   cookedfn +   7       