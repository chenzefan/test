LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\abigail.lua              
  E   �@  ��  \���   �@  �  ����    AA � �"@  J   �   ŀ � @ �  �� � ��    �       Asset    ANIM    data/anim/ghost.zip     data/anim/ghost_wendy_build.zip    SOUND    data/sound/ghost.fsb    Prefab    common/monsters/abigail           M     �   E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� �A� ��A�A ��� �BB �A���� ��B� �A���� �CB �C�A���� �A��A�� �A���� �A���� �A��A�� A� � �A��A �� �A ���  � �A  �A�� �A���� �A��A�� �A����	 B� �A �A� �	 �A���� 
 �A��A� �J��
 ������A� �J��
 �������A� �J��K��� B �A���� � �A���� � �A����  �A��A� �M�AM�
 �M�A���� � �A��A� ��M�AD�
 N�A��A� ��M�AN�
 �N �A��A� ��M��
 ���
 �N�������A� ��O� A �A ��� B �A��� ��P ����   ��AJ�A��   ��AJ�A�ˁ�@� �A���� A �    � �B �A�^   � J      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter 	   AddLight    AddPhysics    Physics 
   SetSphere �������?   SetMass       �?   SetCollisionGroup 
   COLLISION    CHARACTERS    SetIntensity 333333�?
   SetRadius       �?   SetFalloff    Enable 
   SetColour �������?xxxxxx�?<<<<<<�?   require    brains/abigailbrain 	   SetBrain    AbigailBrain    SetBloomEffectHandle    data/shaders/anim.ksh    SetBank    ghost 	   SetBuild    ghost_wendy_build    PlayAnimation    idle    AddTag    monster    AddComponent 
   locomotor    components 
   walkspeed    TUNING    ABIGAIL_SPEED 	   runspeed    directdrive    SetStateGraph    SGghost.lua    inspectable    combat    health    SetMaxHealth    ABIGAIL_HEALTH    aura    GHOST_RADIUS 	   SetDelta    ABIGAIL_DPS    playerdamagepercent 
   GHOST_DPS    SoundEmitter 
   PlaySound $   dontstarve/ghost/ghost_girl_howl_LP    howl 	   follower    TheSim    FindFirstEntityWithTag    player    leader    AddFollower    ListenForEvent    daytime    TheGlobalInstance        I   I       �   � @�@@��@�  �@� �       components    health    SetVal                I   I   I   I   I   I   I         tgi           data              inst �                                                                                                                                                                         "   "   "   #   #   #   $   $   $   %   %   %   %   (   (   (   *   *   *   +   +   +   +   +   ,   ,   ,   ,   ,   -   -   -   /   /   /   1   1   1   3   3   3   4   4   4   5   5   5   5   5   5   :   :   :   ;   ;   ;   ;   ;   ;   <   <   <   <   <   <   <   =   =   =   =   =   =   =   =   A   A   A   A   A   C   C   C   D   D   D   D   E   E   E   E   E   E   F   F   F   F   F   I   I   I   I   I   I   L   M         Sim     �      inst    �      trans    �      anim    �      sound    �      light    �      player �   �                                                       M   O   O   O   O   O   O   O   O         assets          prefabs          fn           