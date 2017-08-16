LuaQ  k   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\pigman.lua           c      A@  @ 
  E�  ��  �  \����  ��  A ���ŀ  �  A� ܀��  A�  �� ��E�  ��  � \����  ��  B ���Ł  �  A� ܁��  A�  �� ��E�  � �B \�"@  J  �� ��  AA �� �� b@ � � ʀ  �@E�� � ��@� �     @ �@��   $A  d�  ��  � B A� �A $ dB �� �� $ � $C  $�      �d� �   �  �   �C   �           �     �D A� ���   � �   �       require    fonthelper    Asset    ANIM    data/anim/ds_pig_basic.zip    data/anim/ds_pig_actions.zip    data/anim/ds_pig_attacks.zip    data/anim/pig_build.zip    data/anim/pigspotted_build.zip    data/anim/werepig_build.zip    data/anim/werepig_basic.zip    data/anim/werepig_actions.zip    SOUND    data/sound/pig.fsb    meat    monstermeat    poop    tophat 	   strawhat    pigskin 	   filename    data/fonts/opensans50.zip    alias    DIALOGFONT    AddFontAssets 
   pig_build    pigspotted_build    WerepigSleepTest    WerepigWakeTest    Prefab    common/characters/pigman            5     <   � � �@@�    �� � �@@��@��  � �� @ �� � �  � � �@A�   @
�� � �@A��AW�A �� � �@A��A B �� @ �@B��B�   ��� @ �@B��B�� � �@ ��   �  � � �@A��A@C��� @ ��C��C�� �   @��  �@�� @ ��   �  � � �   �       components    equippable 
   equipslot    EQUIPSLOTS    HEAD    edible 	   foodtype    MEAT 	   HORRIBLE 	   follower    leader    GetLoyaltyPercent �������?   VEGGIE    eater    TimeSinceLastEating    TUNING    PIG_MIN_POOP_PERIOD     <   !   !   !   !   !   !   !   !   !   !   !   "   "   $   $   $   $   &   &   &   &   &   &   &   &   &   &   '   '   '   (   (   (   (   (   (   (   (   )   )   ,   ,   ,   ,   ,   -   -   -   -   .   .   .   .   .   .   /   /   3   3   5         inst     ;      item     ;      last_eat_time 1   9           7   W     b   � @�@��   ��� @�@�ƀ�W�� �� @�@�ƀ� �@�� @ �@�ƀ��   ��� @ �@�ƀ�@�@�� @ �@����C��@���� � � ��   ���@B ˀ�A� �@�� � � �� �@  �@�� @ �@�ˀ�F@FA�K��\� � �ADN���@�� @ ƀ����܀ �   � �� @ ƀ�� ��@ � @�@��    �� @�@�ƀ�� F �@�� @ �@�ˀ�E� F�܀��    �@ AF�F��A�@ AFG� A�AG �G�� A� �        components    edible 	   foodtype    MEAT 	   HORRIBLE    combat    target 
   SetTarget    leader    SoundEmitter 
   PlaySound    dontstarve/common/makeFriend    AddFollower 	   follower    AddLoyaltyTime 
   GetHunger    TUNING    PIG_LOYALTY_PER_HUNGER    sleeper 	   IsAsleep    WakeUp    equippable 
   equipslot    EQUIPSLOTS    HEAD 
   inventory    GetEquippedItem 	   DropItem    Equip 
   AnimState    Show    hat     b   :   :   :   :   =   =   =   =   =   =   =   =   =   =   >   >   >   >   >   >   >   >   >   >   ?   ?   ?   ?   ?   ?   @   @   @   @   A   A   A   A   B   B   B   B   B   C   C   C   C   C   C   C   C   C   C   C   F   F   F   F   F   F   G   G   G   G   N   N   N   N   N   N   N   N   N   N   N   O   O   O   O   O   O   P   P   Q   Q   Q   Q   Q   T   T   T   T   T   U   U   U   U   W         inst     a      giver     a      item     a      current Q   a           Y   [        � @ �@@�  �@� �       sg 
   GoToState    refuse        Z   Z   Z   Z   [         inst           item                ]   l     1   � � �@@�   @�� � �@@��@�@ �� @ � A�    �� @ � A�@A�� �@  ��� � �@@��A�� �A �� @ � A� BA �@�� � �@@�   @�� � �@@��@�B ��� �  �� �@Cˀ�FAC K��\ �@   �       components    edible 	   foodtype    MEAT 
   werebeast    IsInWereState 
   GetHealth            TriggerDelta       �?   VEGGIE    SpawnPrefab    poop 
   Transform    SetPosition    GetWorldPosition     1   ^   _   _   _   _   _   _   _   _   `   `   a   a   a   a   a   a   a   a   b   b   b   b   b   b   c   c   c   c   c   g   g   g   g   g   g   g   g   g   h   h   h   i   i   i   i   i   i   l         inst     0      food     0      poo *   0           q   �     *   F @ F@� Z   @�F @ F@� K�� \� Z@  ��F @ F�� F � �@ �   � �Ad      �� �   ��W@  �Z   @�� � AA ܀��   @�� BAA ܀��@   �� @ ���ˀ�@ �@� �       components    health    IsDead    combat    target    FindEntity    TUNING    PIG_TARGET_DIST    HasTag 
   structure 
   SetTarget        w   {    "   F @ Z    �F @ K@� \� Z    �K�@ ��  \��Z   ��F A F@� Z   ��F A F@� K�� \� Z@  ��D   F � F�� K � �   \��@ �B@  B � ^   � 	      LightWatcher 
   IsInLight    HasTag    monster    components    health    IsDead    combat 
   CanTarget     "   x   x   x   x   x   x   x   x   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   y   {         guy     !         inst *   r   r   r   r   r   r   r   r   r   r   t   t   t   v   v   v   v   {   {   v   }   }   }   }   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~   ~                  �         inst     )   
   oldtarget    )   
   newtarget    )           �   �        � @ �@@��@ � ����   ����� �    ���� � A�� �   ���@� �   ���@� ��A� ����  @ ��@  � � �   �       components    combat 
   CanTarget    LightWatcher 
   IsInLight    sg    HasStateTag 
   transform        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           target                �   �     *   F @ F@� Z   @�F @ F@� K�� \� Z@  ��F @ F�� F � �@ �   � �Ad      �� �   ��W@  �Z   @�� � AA ܀��   @�� BAA ܀��@   �� @ ���ˀ�@ �@� �       components    health    IsDead    combat    target    FindEntity    TUNING    PIG_TARGET_DIST    HasTag 
   structure 
   SetTarget        �   �       D   F � F@� K�� �   \��Z    �K�@ �  \��Z@  @�F@A Z   @�F@A K�� �� \��Z@   �K�@ �  \��S � @ �B@  B � ^   � 	      components    combat 
   CanTarget    HasTag    werepig    sg    HasStateTag 
   transform    alwaysblock        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         guy              inst *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst     )   
   oldtarget    )   
   newtarget    )           �   �        � @ �@@��@ � ����   �����  ����@   ��@� �   ���@� ��A� ����  @ ��@  � � �   �       components    combat 
   CanTarget    HasTag    werepig    sg    HasStateTag 
   transform        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           target                �   �        B   ^   �            �   �   �         inst                �   �        B � ^   �            �   �   �         inst                �   �    i   E   �@  \@ K�@ ��  \@�K A �@ � � \@  K�A �� \@�F B K@� �� \@�F�B F � K@� ŀ ���\@�F�B F � K � ŀ �@�\@�F�B F�� �� � EI���F�B F�� �� ��EI���F�B F�� K � �@ \@�F�B F�� K�� �� \@�F�B F � K@� � �� A� �� �@�\@�F�B F � I@H�F�B F�� K�� ŀ � �\@�F�B F � K@� � �\@�F�B F � K�� ��	   \@ F�B F � K � � � \@�F�B F@� K�� \@ F�B F�� K � � �\@�F�B F@� K�� \@ F�K K � �   \@�F�K K@� �� \@� � 3      require    brains/werepigbrain    AddTag    werepig 	   SetBrain    WerePigBrain    SetStateGraph    SGwerepig.lua 
   AnimState 	   SetBuild    werepig_build    components    combat    SetDefaultDamage    TUNING    WEREPIG_DAMAGE    SetAttackPeriod    WEREPIG_ATTACK_PERIOD 
   locomotor 	   runspeed    WEREPIG_RUN_SPEED 
   walkspeed    WEREPIG_WALK_SPEED    sleeper    SetSleepTest    WerepigSleepTest    SetWakeTest    WerepigWakeTest    lootdropper    SetLoot    meat    pigskin    numrandomloot            health    SetMaxHealth    WEREPIG_HEALTH 
   SetTarget    SetRetargetFunction       @   SetKeepTargetFunction    trader    Disable 	   follower 
   SetLeader    talker 
   IgnoreAll    Label    Enable    SetText         i   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst     h         WerepigRetargetFn    WerepigKeepTargetFn     �   �     (   F @ F@� Z   ��F @ F@� F�� Z   @�E�  �   �  $  J� �A bA� \���� �   �� �   ��� �  ���A �    ���A � B�� @ ��@  � � �  � �E� �   ]  ^    � 	      components 	   follower    leader    FindEntity       @	   campfire    DefaultSleepTest    LightWatcher 
   IsInLight        �   �     
   F @ F@� Z   � �F @ F@� K�� \� ^   �       components 	   burnable 
   IsBurning     
   �   �   �   �   �   �   �   �   �   �         ent     	       (   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst     '      fire    "           �   �    h   K @ �@  \@�E�  ��  \@ K A �@ � � \@  K�A �� \@�F B K@� ƀB \@�F�B F � K@� ŀ ���\@�F�B F � K � ŀ �@�\@�F�B F � K�� �   \@�F�B F�� �� �@EI� �F�B F�� �� ��EI� �F�B F � K@� � � \@�F�B F � K�� �� \@�F�B F � K@� �   \@�F�B F � K�� ��  \@ F�B F � K�� �@ � \@ F�B F � I�ȑF�B F � K@� ŀ ƀ�\@�F�B F � K�� �   \@ F�B F � K � � �\@�F�B F@� K�� \@ F�J K�� � � \@�F�B F � K@� \@  � .   
   RemoveTag    werepig    require    brains/pigbrain 	   SetBrain 	   PigBrain    SetStateGraph 
   SGpig.lua 
   AnimState 	   SetBuild    build    components    combat    SetDefaultDamage    TUNING    PIG_DAMAGE    SetAttackPeriod    PIG_ATTACK_PERIOD    SetKeepTargetFunction 
   locomotor 	   runspeed    PIG_RUN_SPEED 
   walkspeed    PIG_WALK_SPEED    sleeper    SetSleepTest    SetWakeTest    DefaultWakeTest    lootdropper    SetLoot    AddRandomLoot    meat       @   pigskin       �?   numrandomloot    health    SetMaxHealth    PIG_HEALTH    SetRetargetFunction 
   SetTarget    trader    Enable    Label    talker    StopIgnoringAll     h   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst     g         NormalKeepTargetFn    NormalShouldSleep    NormalRetargetFn     �   s   �   E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� ���� A �A �A� ��B�A �A� ��B�A �A� �C�A �A� ��C� �A��A� �DB �A��A� ��D� A �� �A��A� �AE� A� � �A��A� �AF  �A��� �� � A �A �A� � �A��A� � �A��A�  �A��  Ł ���   ܁ ��I����� �AIB� �A�����	 �A���B
 �A�����
 �A��� B �A���� �AK��K�A ��� �AK�L�A ��� �AK��̘��� �AK��L� �A���  �A���� �M��͚�� �� � �A���  �A���� �NŁ ���������� �N�O�A �� B �A���� �AO��O �A���� �AO��O��A���� �AO�PB �A��� � �A���� ��P� �A������� � �A��� � �A���  �A��� B �A���� �AR� ��������� �AR� �A������ � �A��� � �A���  �A���� �T�AT �A���� �T�������� �T� ������  �A���� �U�AU� �A��� � �A���� ��U�  ����A  I�����     I������ �A ^   � [      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    AddDynamicShadow    SetSize       �?      �?
   Transform    SetFourFaced    AddLightWatcher 	   AddLabel    Label    SetFontSize       9@   SetFont    DEFAULTFONT    SetPos               @
   SetColour \���(\�?�������?{�G�z�?   Enable    MakeCharacterPhysics       I@      �?   AddTag 
   character    pig    scarytoprey    build    math    random 
   AnimState 	   SetBuild    SetBank    pigman    PlayAnimation 
   idle_loop    Hide    hat    AddComponent    eater    components    SetOmnivore    SetCanEatHorrible    strongstomach    SetOnEatFn    combat    hiteffectsymbol 
   pig_torso    MakeMediumBurnableCharacter    named    possiblenames    STRINGS 	   PIGNAMES    PickNewName 
   werebeast    SetOnWereFn    SetOnNormalFn    SetTriggerLimit       @	   follower    maxfollowtime    TUNING    PIG_LOYALTY_MAXTIME    health 
   inventory    lootdropper 
   locomotor 	   runspeed    PIG_RUN_SPEED 
   walkspeed    PIG_WALK_SPEED    knownlocations    talker    trader    SetAcceptTest 	   onaccept 	   onrefuse    sleeper    SetResistance        @   inspectable 
   getstatus    OnSave    OnLoad        Z  `       K @ �@  \��Z   � �A�  ^  ��F�@ F � F@� W�� @ �A� ^   �       HasTag    werepig    WEREPIG    components 	   follower    leader  	   FOLLOWER        [  [  [  [  [  \  \  \  ]  ]  ]  ]  ]  ^  ^  `        inst                e  g       � @ I� � �       build        f  f  g        inst           data                i  n      � � �@  @ ��   �@@	� ���@ ��@� A�� �@  � ��@A ��A@ �@� �       build       �?   components 
   werebeast    IsInWereState 
   AnimState 	   SetBuild        j  j  j  j  j  j  k  k  k  k  k  k  l  l  l  l  n        inst           data              builds �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                                                                                                                                    !  !  !  #  #  #  #  %  %  %  &  &  &  &  &  '  '  '  '  *  *  *  +  +  +  +  +  ,  ,  ,  ,  ,  -  -  -  -  -  0  0  0  1  1  1  1  1  3  3  3  7  7  7  ;  ;  ;  ?  ?  ?  @  @  @  @  @  A  A  A  A  A  E  E  E  F  F  F  J  J  J  K  K  K  K  K  L  L  L  L  M  M  M  M  S  S  S  T  T  T  T  T  Y  Y  Y  Z  Z  `  `  g  g  n  n  n  p  p  p  r  s        Sim     �      inst    �      trans    �      anim    �      sound    �      shadow    �         builds    OnEat    SetWerePig    SetNormalPig    ShouldAcceptItem    OnGetItemFromPlayer    OnRefuseItem c                                                               	   	   	   	   
   
   
   
                                                                                                5   W   [   l   n   n   n   n   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   s  s  s  s  s  s  s  s  u  u  u  u  u  u  u  u        assets )   b      prefabs 1   b      FONTS 7   b      ShouldAcceptItem <   b      OnGetItemFromPlayer =   b      OnRefuseItem >   b      OnEat ?   b      builds C   b      NormalRetargetFn D   b      NormalKeepTargetFn E   b      WerepigRetargetFn F   b      WerepigKeepTargetFn G   b      SetWerePig N   b      NormalShouldSleep O   b      SetNormalPig S   b      fn [   b       