LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\mandrake.lua           =      A@  @    A�  @ 
 �E�  �  �@ \����  �� � �����   AA ܀��  A �� �"@  J � �� b@� �   �@  $�  d�  �   ��A   �$�   �d� �   �  �            �B   �  � AC � �   � ��E �� ��   \    �       require    fonthelper    brains/mandrakebrain    Asset    ANIM    data/anim/mandrake.zip    SOUND    data/sound/mandrake.fsb    IMAGE "   data/inventoryimages/mandrake.tex (   data/inventoryimages/cookedmandrake.tex    cookedmandrake    Prefab    common/mandrake    common/cookedmandrake 
          ,     S   K @ �@  \@�K�@ ��  \@�K A �@ \@�F�A F@� K�� �  \@�F�A F@� I�K A �� \@�F�A F�� I@C�F�C K�� �  �@�\@�F�C K�� \@ F�C K�� �  � �\@�F�C K�� �  �@�\@�F�C K�� �  �@�\@�K�E �� � � \@  K�@ �  \@�K�@ �@ \@�E� �   �@ \@�F�F K � � � \@�K A �@ \@�E� K�� �  \��Z    ���� �@H�    ���� �@H��H   �@� � #      AddTag    picked    RemoveComponent 	   pickable    AddComponent    health    components    SetMaxHealth       4@
   nofadeout    combat    hiteffectsymbol    mandrake_root    Physics    SetCollisionGroup 
   COLLISION    CHARACTERS    ClearCollisionMask    CollidesWith    WORLD 
   OBSTACLES 	   SetBrain    MandrakeBrain 	   burnable    propagator    MakeSmallBurnableCharacter    DynamicShadow    Enable 	   follower    TheSim    FindFirstEntityWithTag    player    leader    AddFollower     S                                                                                                                                                         !   !   !   "   "   "   #   #   #   #   %   %   %   %   &   &   &   '   '   '   '   (   (   (   (   (   (   )   )   )   )   )   ,         inst     R      player G   R           .   G     T   K @ �@  \@�K�@ ��  \@�K�@ �  \@�K�@ �@ \@�K�@ �� \@�F�A K � �@ ƀ�\@�F�A K�� \@ F�A K � �@ �@�\@�F�A K � �@ ƀ�\@�F�A K�� �  \@�F�A K@� �� \@�F�A K�� �  \@�F�A K@� �� \@�F�E K � �   \@�F@F F�� I ǍF@F F�� K@� �   \@�F@F F�� K�� �@  \@�F@F F�� K�� �  \@�K�@ �  \@�K�@ �@ \@�E� �   \@ E� �   \@  � $      AddTag    item    RemoveComponent 	   pickable    combat 	   follower    health    Physics    SetCollisionGroup 
   COLLISION    ITEMS    ClearCollisionMask    CollidesWith    WORLD 
   OBSTACLES    SetMass       �?   SetFriction �������?   SetDamping            SetRestitution       �?   DynamicShadow    Enable    components    inventoryitem    canbepickedup    SetOnPickupFn    SetOnPutInInventoryFn    SetOnDroppedFn 	   burnable    propagator    MakeSmallBurnable    MakeSmallPropagator        >   >        F @ K@� ��  \@� �       sg 
   GoToState    item        >   >   >   >   >         inst                ?   ?        F @ K@� ��  \@� �       sg 
   GoToState    item        ?   ?   ?   ?   ?         inst                @   @        F @ K@� ��  \@� �       sg 
   GoToState    item        @   @   @   @   @         inst            T   /   /   /   0   0   0   1   1   1   2   2   2   3   3   3   4   4   4   4   4   5   5   5   6   6   6   6   6   7   7   7   7   7   8   8   8   8   9   9   9   9   :   :   :   :   ;   ;   ;   ;   <   <   <   <   =   =   =   >   >   >   >   >   ?   ?   ?   ?   ?   @   @   @   @   @   B   B   B   C   C   C   D   D   D   E   E   E   G         inst     S           I   `     N   K @ �@  \@�F�@ F�� Z@  � �K A ��  \@�F@A K�� �� � �\@�F@A K@� \@ F@A K�� �� ���\@�F C K@� �   \@�F�@ F�� I�C�F�@ F�� �   I� �E@ K�� �� \��Z   ����� � E�   ����� � E�@E   ����    ���� � E��E   �@���E  �@���E A �@���E � �@���E � �@���E  �@��@ �   �@ �� �   �@  �    
   RemoveTag    picked    components 	   pickable    AddComponent    Physics    SetCollisionGroup 
   COLLISION    ITEMS    ClearCollisionMask    CollidesWith    WORLD    DynamicShadow    Enable    canbepicked    onpickedfn    TheSim    FindFirstEntityWithTag    player    leader    IsFollower    RemoveFollower    RemoveComponent    combat 	   follower    health 	   burnable    propagator    MakeSmallBurnable    MakeSmallPropagator        T   T        F @ K@� ��  \@� �       sg 
   GoToState    picked        T   T   T   T   T         inst            N   J   J   J   L   L   L   L   M   M   M   O   O   O   O   O   P   P   P   Q   Q   Q   Q   Q   R   R   R   R   S   S   S   T   T   T   T   U   U   U   U   V   V   V   V   V   V   V   V   V   V   V   V   V   W   W   W   W   W   Y   Y   Y   Z   Z   Z   [   [   [   \   \   \   ]   ]   ]   ^   ^   ^   _   _   _   `         inst     M      player &   M           b   m     1   E  �A� ��@� \�  ��  �AB�F������ �� �   �@�C��B  ��C��B�B� ��C ��C��� ��  @�  ����D�C C�C��D�D� �CE � ��C  �  �� �       Vector3 
   Transform    GetWorldPosition    TheSim    FindEntities    x    y    z    pairs    components    sleeper    AddSleepiness       $@   HasTag    player    sg 
   GoToState    wakeup    talker    Say 
   GetString    prefab    ANNOUNCE_KNOCKEDOUT     1   c   c   c   c   c   d   d   d   d   d   d   d   e   e   e   e   f   f   f   f   g   g   g   g   g   g   g   h   h   h   h   h   h   h   i   i   i   i   j   j   j   j   j   j   j   j   e   k   m         inst     0      user     0      range     0      time     0   	   knockout     0      pos    0      ents    0      (for generator)    0      (for state)    0      (for control)    0      k    .      v    .           o   r       �   �    � E  FA��  ��@�@���� � AA �@� �       TUNING    MANDRAKE_SLEEP_RANGE    MANDRAKE_SLEEP_TIME    SoundEmitter 
   PlaySound $   dontstarve/creatures/mandrake/death        p   p   p   p   p   p   p   p   q   q   q   q   r         inst           eater              DoAreaEffect     t   x       �   �@@��@��@�@ �   �    � E FA�� ��A�� �@ ��� � BA �@� � 
      TheGlobalInstance    components    clock    MakeNextDay    TUNING    MANDRAKE_SLEEP_RANGE_COOKED    MANDRAKE_SLEEP_TIME    SoundEmitter 
   PlaySound $   dontstarve/creatures/mandrake/death        u   u   u   u   u   v   v   v   v   v   v   v   v   v   w   w   w   w   x         inst           eater              DoAreaEffect     z       	   	@@�ŀ  ���� ��@��@ �      @ �� ��AŁ ��� �@ �@Bˀ�A� �@� �    	   persists     TheGlobalInstance    components    clock 
   NextPhase    TUNING    MANDRAKE_SLEEP_RANGE_COOKED    MANDRAKE_SLEEP_TIME    SoundEmitter 
   PlaySound $   dontstarve/creatures/mandrake/death        {   |   |   |   |   |   }   }   }   }   }   }   }   }   }   ~   ~   ~   ~            inst           cooker           chef              DoAreaEffect     �   �      3      �� F@@ K�� \� �@@ ��@�� � A AA �@�ˀAAA �@���AAA �@�� B AA �@�ƀB �@�$  � ��� B A �@�ƀB � �� �C� ��� B A �@�� B AA �@�ƀB �@�� �D� �� B A �@�ƀB � �ɀŊ   �       CreateEntity    entity    AddTransform    AddAnimState    AddTag 	   mandrake    SetBank 	   SetBuild    AddComponent    inspectable    components 
   getstatus    researchvalue 
   basevalue    TUNING    RESEARCH_VALUE_SUPERRARE_ITEM    inventoryitem 
   stackable    maxsize    STACK_SIZE_SMALLITEM    edible 	   foodtype    VEGGIE        �   �        K @ �@  \��Z   � �A�  ^  ��K @ ��  \��Z   @ �A  ^   �       HasTag    picked    PICKED    dead    DEAD        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst            3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst    2      trans    2      anim    2           �   �     _      �� K @ �@  \@�F�@ K�� �  \@�F@A K�� \� �@A ��A�� � BAA �� �@ ��B � ��@ �@    A� �� �@ � D AA �@�ƀD �@�� ŉ�@E A� �@�ƀD ����@F�ƀD ƀ����D� �@�ƀD � �� �G� ��ƀD � �� AH� �ƀD � �ˀ�D �@�� D A� �@�ƀD ����@I�ƀD ���ˀ�D��@��   	����@     � 	� �� �   �@ ��  �� �� � �� � �	����@K A� ��      �� �@�   � 0      AddTag 
   character 
   AnimState    PlayAnimation    ground    entity    AddSoundEmitter    AddDynamicShadow    SetSize       �?      �?
   Transform    SetFourFaced    MakeCharacterPhysics       $@      �?   AddComponent 
   locomotor    components 
   walkspeed       @   SetStateGraph    SGMandrake.lua    inventoryitem    canbepickedup  
   stackable    SetOnDeStack    edible    healthvalue    TUNING    HEALING_HUGE    hungervalue    CALORIES_HUGE    SetOnEatenFn 	   cookable    product    cookedmandrake    SetOnCookedFn    OnSave    OnLoad    userfunctions    MakePlanted 	   MakeItem    MakeFollower    ListenForEvent    daytime    TheGlobalInstance        �   �        � @ A  ����   @ �I���@�� @ �  ����     �I��� �       HasTag    picked    item        �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           data                �   �       � � �   ���   �   �@ �@@ ��@�  �@�@�� � �   ��� � �   �@ �@A ��A� �@� �       picked    sg 
   GoToState    idle    item 
   AnimState    PlayAnimation    object        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           data              MakeFollower 	   MakeItem     �   �            @ @@    ��    @ @@ �@ � @   �   �@  A �@ @� �       components    health    IsDead    sg 
   GoToState    plant        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �             inst _   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst    ^      sound    ^      shadow    ^      	   commonfn 	   MakeItem    OnEaten 	   OnCooked    MakeFollower    MakePlanted     �   �           �� F @ F@� ��  � AI� �F @ F@� ��  ��AI���F @ F@� K�� � � \@�K B �@ \@�K B �� \@�F�B K � �@ \@�   �       components    edible    healthvalue    TUNING    MANDRAKE_HEALTH    hungervalue    MANDRAKE_HUNGER    SetOnEatenFn    AddTag    cooked    dead 
   AnimState    PlayAnimation        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst          	   commonfn    OnEaten_cooked =                                                            	   	   	   	   
            ,   G   `   m   r   r   x   x         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         assets    <      prefabs    <      MakeFollower    <   	   MakeItem    <      MakePlanted    <      DoAreaEffect    <      OnEaten !   <      OnEaten_cooked #   <   	   OnCooked %   <   	   commonfn &   <   
   defaultfn -   <   	   cookedfn 0   <       