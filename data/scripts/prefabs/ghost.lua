LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\ghost.lua              
  E   �@  ��  \���   �@  �  ����    AA � �"@  J   �   ŀ � @ �  �� � ��    �       Asset    ANIM    data/anim/ghost.zip    data/anim/ghost_build.zip    SOUND    data/sound/ghost.fsb    Prefab    common/monsters/ghost           B        E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� �A� ��A�A ��� �A��A� ��B� �A��A� �CB �A��A� ��C� D�A��A�� �A���� �A��A�� �A����� �A���� AB �� �A��� � �A �A� � � �A  ��� �A��A�� �A����	 B� �A �A� �	 �A���� 
 �A��A� �J��
 ������A� �J��
 �������A� �J��K��� B �A���� � �A���� � �A����  �A��A� �M�AM�
 �M�A���� � �A��A� ��M��D�
 N�A��A� ��M�AN�
 �N �A���� �OB A� �A ^   � ?      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter 	   AddLight    AddPhysics    SetBloomEffectHandle    data/shaders/anim.ksh    Physics 
   SetSphere �������?   SetMass       �?   SetCollisionGroup 
   COLLISION    CHARACTERS    SetIntensity 333333�?
   SetRadius       �?   SetFalloff    Enable 
   SetColour �������?xxxxxx�?<<<<<<�?   require    brains/ghostbrain 	   SetBrain    GhostBrain    SetBank    ghost 	   SetBuild    ghost_build    PlayAnimation    idle    AddTag    monster    AddComponent 
   locomotor    components 
   walkspeed    TUNING    GHOST_SPEED 	   runspeed    directdrive    SetStateGraph    SGghost.lua    inspectable    combat    health    SetMaxHealth    GHOST_HEALTH    aura    GHOST_RADIUS 	   SetDelta 
   GHOST_DPS    SoundEmitter 
   PlaySound    dontstarve/ghost/ghost_howl_LP    howl                                                                                                                                                                          !   !   !   !   #   #   #   $   $   $   %   %   %   %   (   (   (   *   *   *   +   +   +   +   +   ,   ,   ,   ,   ,   -   -   -   /   /   /   1   1   1   3   3   3   4   4   4   5   5   5   5   5   5   9   9   9   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   >   >   >   >   >   A   B         Sim     ~      inst    ~      trans    ~      anim    ~      sound    ~      light    ~                                                       B   D   D   D   D   D   D   D   D         assets          prefabs          fn           