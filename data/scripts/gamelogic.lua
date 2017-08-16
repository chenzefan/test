LuaQ  f   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\gamelogic.lua           9      A@  @    A�  @    A�  @    A  @ @ E� F�� �  @�   E@ K�� �� � �A \@ d       G� d@  ��    � �� ��      �   $   � $A d�       GA E� \�� G� d� G EA �� ��A�A \A�E� K��� \A� �       require    playerprofile    screens/mainscreen    screens/deathscreen    screens/popupdialog    Print 
   VERBOSITY    DEBUG    [Loading frontend assets]    TheSim    SetRenderPassDefaultEffect    RENDERPASS    BLOOM    data/shaders/anim_bloom.ksh    GetTimePlaying    SetUpPlayerCharacterCallbacks    PopulateWorld    DoInitGame    Profile    PlayerProfile    OnProfileLoad    [Loading profile]    Load                      @  @ �     @  �� D   @     �               GetTime                                                   start_game_time        Q     �   � @ �@@�   � �� @ �@@��@�� ��   ܀ A �A�� A�B ABA � @�BC� EA �� ��� ��\A E KA��� � F�� � \A EA �A \A E KA��� � @ � \A �   ��E� K��A $         \A ��E� �� �G\A EA \�� �� ��G���� @ �A �� � @��A �	 �A� �� �@��B�AIƁI ���܁ �@ � E� FB���Ƃ��� \�  ������� �   ��� DD�D ��  �A D �I �K��D��  ��ƂI ���@��B�� C @ �B�� � @��B�� �B�A� �� �  @� �B  � �B�E� �� \ �B  ƂI ����B �� ��A �C       ��B c   � 9      components    resurrectable    CanResurrect    require    progressionconstants 	   TheMixer    PushMix    death    HUD    Hide    TheGlobalInstance    clock    ToMetricsString    ProfileStatsAdd    killed_by_    cause    TheSim 
   LogMetric 	   GameStat 
   killed_by    1    deaths    player_death 
   scheduler    ExecuteInTime       @   EraseSaveGame    SAVE_NAMES    latest    GetTimePlaying    math    floor      @�@   SetTimingStat    time 	   scenario    SendTrackingStats 
   numcycles    profile    GetXP    GetXPForDays    min 	   GetXPCap    GetRewardsForTotalXP    pairs 
   GameEvent    UnlockCharacter    SetXP    ProfileStatsSet    xp_gain 	   xp_total 
   game_over 	   tostring    SubmitCompletedLevel    GetProfileStats    Save       @       '   ,           @@ ��  @�   �@  A @A @ � A� @   @B �� �� � A @  �    	   TheMixer    PopMix    death    components    resurrectable    DoResurrect    ProfileStatsAdd    resurrections    TheSim 
   LogMetric 	   GameStat    player_resurrect    1        (   (   (   (   )   )   )   )   )   *   *   *   +   +   +   +   +   +   +   ,             wilson 
   game_time     L   N           @@ ��  �   � � �@   �       TheFrontEnd    PushScreen    DeathScreen        M   M   M   M   M   M   M   N             days_survived 	   start_xp �                                                                                                            !   !   !   "   "   "   "   "   "   "   &   &   '   '   '   ,   ,   ,   '   ,   .   .   .   .   0   0   1   1   1   1   1   3   3   3   3   3   4   4   8   8   8   8   9   9   9   :   :   :   ;   ;   ;   ;   ;   ;   =   =   =   >   >   >   >   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   >   @   B   B   B   B   D   D   D   D   E   E   E   E   F   F   F   F   F   F   F   F   F   G   G   G   G   G   G   I   I   I   L   L   L   N   N   N   L   N   Q         wilson     �      data     �      will_resurrect    �      Progression    �   
   game_time    �   	   playtime =   �      days_survived M   �   	   start_xp P   �   
   reward_xp S   �      new_xp Y   �      all_rewards \   �      (for generator) _   m      (for state) _   m      (for control) _   m      k `   k      v `   k           T   �    &   K @ �@  $         \@ K @ ��  $A      \@ K @ ��  $�      E \@�K @ �@ $�      E \@�K @ �� $     E \@�K @ �� $A \@ K @ �  $� \@  � 	      ListenForEvent    death    quit    daycomplete    TheGlobalInstance    daytime 	   dusktime 
   builditem    buildstructure        V   V       �   � � �@ �   � �  � �@� �    
   dumptable        V   V   V   V   V   V   V   V         inst           data              OnPlayerDeath    wilson     X   j     2      E@  F�� ��  @�  @A �� @�   �A  B @ @ �� E� F�� � C \�   � E@ �� ��    \@ E  �@ �   \@�E� \@� E� \@� E  K@� �� � E FA�F��K��\� � \@ D   F@� K�� �   \@� �       Print 
   VERBOSITY    DEBUG    I SHOULD QUIT! 	   TheMixer    PushMix    death    HUD    Hide    GetTimePlaying    math    floor      @�@   SetTimingStat    time 	   scenario    ProfileStatsSet    time_played    SendTrackingStats    SendAccumulatedProfileStats    TheSim 
   LogMetric 	   GameStat    player_quit    TheGlobalInstance    components    clock    ToMetricsString    1    profile    Save        e   i            @@ J   � E�  K�� �   \@�E�  K � \@  �       json    encode    TheSim    SetInstanceParameters    Reset        f   f   f   f   g   g   g   g   h   h   h   i         params           2   Y   Y   Y   Y   Y   Z   Z   Z   Z   [   [   [   [   \   \   ]   ]   ]   ]   ]   _   _   _   _   _   `   `   `   `   a   a   b   b   c   c   c   c   c   c   c   c   c   c   c   e   e   e   i   e   j      	   playtime    1         wilson     m   q       �   � @�@@��@�� �@  � ���  �  �@  �       components    health    IsDead    ProfileStatsAdd    nights_survived_iar        n   n   n   n   n   n   n   o   o   o   q         it     
      data     
         wilson     t   }       �   � @�@@��@�� �@  @���  �  �@ �@ ŀ ����@ �   � B�@B�@ ��  �� �@  �       components    health    IsDead    print    Day has arrived... 	   SaveGame    SAVE_NAMES    latest    profile    Save    Day begin handled.        u   u   u   u   u   u   u   v   v   v   x   x   x   x   y   y   y   y   {   {   {   }         it           data              wilson     �   �       �   � @�@@��@�� �@  @���  �  �@�� �@��   ��A� B�@ ��  �  �@�A �@� � 
      components    health    IsDead    Print 
   VERBOSITY    DEBUG    Dusk has arrived...    profile    Save    Dusk handled.        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         it           data              wilson     �   �        �   �@@�  A�  �� �AAU���� ��A�B�AB�� �� �@  �       TheSim 
   LogMetric 	   GameStat    build_item_    item    prefab    TheGlobalInstance    components    clock    ToMetricsString    1        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           data                �   �        �   �@@�  A�  �� �AAU���� ��A�B�AB�� �� �@  �       TheSim 
   LogMetric 	   GameStat    build_structure_    item    prefab    TheGlobalInstance    components    clock    ToMetricsString    1        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           data            &   V   V   V   V   V   V   W   W   j   j   W   l   l   q   q   q   l   s   s   }   }   }   s         �   �   �      �   �   �   �   �   �   �   �   �         wilson     %         OnPlayerDeath     �   �       E   \�� H   E@  K�� ��   \@ E@ �   \@  �       GetTime    TheSim    LogView    InGame        SetUpPlayerCharacterCallbacks        �   �   �   �   �   �   �   �   �   �   �   �         wilson              start_game_time     �   �      �   A  �@A�  �@��  �@�J� �� bA� �@��� � ܀   EA  F��� A�
  C�   �:��A �� � A� �� �  �B   ���B C   ��B BC   ��B �CB    �� EB ��B �C� �B CC\� ���B �C  @ ��B ��C BA�� � �B� B�� @ � @  @��B B����� B��BE��E� B  ����B��BF�F�B� ��BF	�F��B   @��B G  @��B GJ�  IB��I�	A �G�� ��  ��FHKB�ƂH ����H I\B FHKB�ƂH Ƃ�\B�FHK��\B F�H F�	B�E� �B
 \� �����J�H �HE CF�H F�� N���B EB ��K \@
��� ������  ��	�D  ����   ܄ W �	���	EE
�C	�E    ��� ƅC	�E    ��� FC	F    �� E���	��C	E�G	  @�G	J�  Iń���C	I���	A
��  @�a�  ��EB � \ ��C��CL  F���C a�   �E� F�F����B �  � ���B �BM�B    ��� I��F�B Z  ��F�B F������E� F�F��K��� \B���F�B Z  ��F�B F��@���E� F�F��K���� \B�@�E� F�F��K���� \B�F�B F�Z   �E� F�F����B �OI���@��  �A  Ɓ�� �A� � �  �A  Ɓ� �A�^  � A      Print 
   VERBOSITY    DEBUG    PopulateWorld    TheSim    LoadPrefabs    forest    SpawnPrefab    [Instantiating objects...]    Vector3            playerinfo    x    z    y    data    assert !   could not spawn player character    SetProfile    Profile 
   Transform    SetPosition    Get    SetPersistData    components    health    currenthealth       �?   id    entity    FindFirstEntityWithTag    ground 	   LevelMap    SetSize    map    width    height    SetFromString    tiles 	   Finalize 	   topology    waves    WaveComponent    Init    TILE_SCALE    pairs    ents    ipairs     LoadPostPass    TheGlobalInstance    clock 
   numcycles    day 	   dayphase    night    StartNight    dusk 
   StartDusk 	   StartDay    timeleftinera    timeLeftInEra    ERROR -   [MALFORMED SAVE DATA] PopulateWorld complete 5   [FINISHED LOADING SAVED GAME] PopulateWorld complete       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      	   savedata          profile          playercharacter          forest         newents         wilson         spawnpoint         playerdata         y -   5      ground m        waves �   �      (for generator) �   �      (for state) �   �      (for control) �   �      prefab �   �      ents �   �      (for generator) �   �      (for state) �   �      (for control) �   �      k �   �      v �   �      ent �   �      (for generator) �   �      (for state) �   �      (for control) �   �      k �   �      v �   �         deprecated     �       B   E   \�� �@� ��@�� ��@A �@��@ �A �  ��A���B���F��F������C����C����CB��C� � �AC �C��� ����C�F��B �   ��@ E � ���A FB�BF�A ���F����EBFCB���C����BF��F�����DC	���Ƅ�	�B �  @� �       CreateEntity    entity    AddDebugRender    SetZ �������?   pairs    nodes    Circle    x    y    r    c    g    b    a    String    (    ,    )    ts    edges    n1    n2    Line     B                                                                                                                                             graph     A      debugdrawmap    A      draw    A      (for generator)    '      (for state)    '      (for control)    '      id    %      node    %      (for generator) *   A      (for state) *   A      (for control) *   A      k +   ?      edge +   ?      n1 .   ?      n2 1   ?             y   �     EA  F����  A� FA� �� A� FA� F��� A� FA� FA��� A� FA� F��� A� FA� FA��� A� F�� � A� F�� FA��� A� F�� F��� A� F�� FA��� A� F�� � A� EA ��@ ��   � EA K��� $  A� � �BH��  ��H��BI�� �� \A  E  �A  ��@��	 \A�EA K���B
 A�
 ��
 �A�\A�E  �A  ��@� \A�EA K����  \A E  �A  ��@�A \A�E� �� �    \� Z  @��� �M ��A��  ���A �� �AM�A �� ��M�A  ��  �A  ��� �A��A ��N��N O@��A� �AO�O@��  �A  ��� �A�� ��� �A� �A��A �A  �A ܁� � �P��B����B�B B� B �   � �  B�  �� B� B � �P�� � C J� ��  ��R��     ���bC� � B    EB  F���B B� � N      Print 
   VERBOSITY    DEBUG    DoInitGame    assert    map "   Map missing from savedata on load    prefab )   Map prefab missing from savedata on load    tiles (   Map tiles missing from savedata on load    width (   Map width missing from savedata on load    height )   Map height missing from savedata on load    playerinfo )   Playerinfo missing from savedata on load    x +   Playerinfo.x missing from savedata on load    z +   Playerinfo.z missing from savedata on load    day -   Playerinfo day missing from savedata on load    ents &   Entites missing from savedata on load 	   PLATFORM    NACL 
   /inst/get 
   /anon/new    TheSim    QueryServer    POST    json    encode    name 
   Test name    size    small 
   character    DoInitGame Loading prefabs...    LoadPrefabs    maxwell    fire    waves    DoInitGame Adjusting audio... 	   TheMixer 	   SetLevel    master            DoInitGame Populating world...    PopulateWorld 
   TheCamera 
   SetTarget    SetDefault    Snap    WARNING    DoInitGame NO WILSON?    Profile    persistdata    debug_world       �?	   topology     ERROR    OI! Where is my topology info! 
   PlayerHud    TheFrontEnd    PushScreen    SetMainCharacter    GetProfileStats    SetHUDPause    PopupDialogScreen    Ready to play!    How long will you survive?    text    Start    cb    DoInitGame complete        1  4       �   �@  ƀ��  @� �  �@� �       Print 
   VERBOSITY    DEBUG (   DoInitGame TheSim:QueryServer /inst/get        3  3  3  3  3  3  3  4        result           isSuccessful                Z  g     3      E@  F�� ��  @�  @A �� �� @    B �@ @�   E@  F�� �� @�� B   @   @C �C �C  D  �  @C �C @D �    @�  @C �C �D �  D � �� A  @    E@  F�� �@ @� �       Print 
   VERBOSITY    DEBUG 1   DoInitGame OnStart Callback... turning volume up 	   TheMixer 	   SetLevel    master       �?   PushMix    normal -   DoInitGame OnStart Callback... unpausing HUD    SetHUDPause    TheGlobalInstance    components    clock 
   numcycles            IsDay    GetNormTime    PlayNIS    maxwellintro (   DoInitGame OnStart Callback... complete     3   [  [  [  [  [  ]  ]  ]  ]  ]  ^  ^  ^  ^  `  `  `  `  `  b  b  b  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  c  d  d  d  f  f  f  f  f  g              t  t          @�  �            t  t  t            OnStart �                                                             !  !  !  !  "  "  "  "  "  $  $  $  $  $  %  %  %  %  %  '  '  '  '  )  *  *  *  +  +  -  0  0  0  4  5  6  6  6  7  8  9  6  0  >  >  >  >  >  ?  ?  ?  ?  ?  ?  ?  ?  A  A  A  A  A  B  B  B  B  B  F  F  F  F  F  G  G  G  G  G  I  I  J  J  J  J  K  K  K  L  L  L  M  M  M  M  O  O  O  O  O  R  R  R  R  R  S  S  S  S  T  T  T  T  T  T  V  V  V  V  g  i  i  j  j  j  j  k  k  k  n  n  n  p  p  q  q  q  s  s  s  t  t  t  t  t  t  t  t  t  t  t  t  t  t  x  x  x  x  x  y        playercharacter     �   	   savedata     �      profile     �      fast     �      query 5   �      wilson i   �      OnStart �   �      hud �   �      
   StartGame    DrawDebugGraph     }  �    &   E   �@  ��@��     \@ E  @�  �E� W�� @�E  F@� F�� Z    �E� F � ��  �  �@�ƀ��@������  �@�ƀ�ƀ��� �\� �� � � �@ E  �   \@  �       Print 
   VERBOSITY    DEBUG    [Profile loaded] 	   PLATFORM    WIN32    CONFIGURATION    PRODUCTION    Profile    persistdata    debugparams    json    encode 
   character 	   savefile    SetInstanceParameters    UpdateGamePurchasedState        �  �           @@    ��   �@    ���   A �   ��@�   @ @�@ �A �� �  �  @   � 	   	   Settings 
   character 	   savefile    TheSim    GetPersistentString    TheFrontEnd    ShowScreen    MainScreen    Profile        �  �       E   �   \� Z   @��   ���@  ˀ�B� ��  �@ �  A �A@ �� �@ @��@  � �EA �� \ �@   � 
      RunInSandbox    TheFrontEnd    Fade        @   DoInitGame 	   Settings 
   character    Profile    ShowScreen    MainScreen        �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �        str           success       	   savedata              �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �          &   ~  ~  ~  ~  ~  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �        profile_load_success     %      params    "       9                                                         
   
   
   
   
   
            Q   �   �   T   �   �   �   �   �   �     y  y  y    {  {  {  �  }  �  �  �  �  �  �  �  �  �  �        start_game_time    8      OnPlayerDeath    8   
   StartGame !   8      deprecated "   8      DrawDebugGraph &   8       