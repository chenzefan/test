LuaQ  a   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\main.lua           �  @        �    @A   �@   � �    �A   �@   � � 
�  E  �� � �A@ Z@  � �A� �  U�� 	@��E  �� � �A� Z@  � �A  �  U�� 	@��E  �� � �A@ Z@  � �A� �  U�� 	@��  $   E� F � �@ ��D�@     \@ A� �  �   � �A@ �@  �� ��  F� ��@ ��D��ƌ� ��� �F���  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �  �� �@ �  �� �@ �  � 	 �@ �  �@	 �@ �  ��	 �@ �  ��	 �@ �  � 
 �@ �  �@
 �@ �  ��
 �@ �  ��
 �@ �  �  �@ �  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �� �� �@ �@ ��P�  �� W Q� ��@ �@Q�  �@ ��Q�  ��  �� �  �@R�  ˀ��  �@  �  ��� �� �  �@ �� ��S܀� ǀ �   �@ ŀ �@�A� �@��   �� ��  $   � 
  A 
  � 
  � A  A � $A � 
A  	AW�d�    G� d� G� C��   �� �A �A �� �� �� ��� ��    �� � � �A �A �  $�   �� $� � $  $B   �B $�   �� $� � $  $B B � �� � � �[\�  B�� �[B\B � �\�� B�� ]�\B]�� ��]ł ��� C^B� �^�� �� �B� B�� �[B_�  � �[�_� � � `�B  B�� �[�`� �  �  a�B! B��  �a��! �" B � �[�b� B" � �[c� �" � �[�c� B# $� �# $� $ 
  B$ $ �$ $B �$ $� % $� B% $ �% � �F@��    � � A�% B  & B& �� B&  A�& B $B �&   ' $� B' $� �'  � �      MAIN       �?   USE_TELNET    ENCODE_SAVES    BRANCH    dev    CHEATS_ENABLED    release    SAVE_NAMES    latest    latest_    restart 	   restart_    profile 	   profile_    table    insert    package    loaders    ./    TheSim    data/scripts/ 	   loadfile 	   PLATFORM    NACL        @    WIN32    require    strict    json    vector3    tuning    strings 
   constants    class    actions    debugtools    simutil    util 
   scheduler    stategraph    behaviourtree    prefabs    entityscript 	   profiler    recipes    brain 	   emitters    dumper    input    upsell    stats 	   frontend    widget    image    text 	   textedit    standardcomponents    cameras\followcamera    update    seasonmanager    print    running main.lua
    VERBOSITY_LEVEL 
   VERBOSITY    ERROR    CONFIGURATION    Production    DEBUG    WARNING    Print    math    randomseed    GetRealTime 
   TheCamera    FollowCamera    mixer 	   TheMixer    Mixer    mixes    PushMix    start    Prefabs    LoadPrefabFile    Ents 
   AwakeEnts    UpdatingEnts    num_updating_ents            NumEnts    SpawnPrefabFromSim    feather    feather_crow    SpawnPrefab    CreateEntity    OnRemoveEntity    PushEntityEvent    GetTickTime    GetTime    GetTick    GetTimeReal    LoadScript 
   RunScript    GetEntityString    GetDebugString    SetDebugEntity    OnEntitySleep    OnEntityWake    PlayNIS    TheGlobalInstance    entity    SetCanSleep    AddTransform    AddComponent    clock    components    Run    TUNING 	   DAY_TIME 
   DUSK_TIME    NIGHT_TIME    LoadPrefabs    global    SplatManager    AddSplatManager    ShadowManager    AddShadowManager    SetTexture    data/images/shadow.tex    RoadManager    AddRoadManager    SetGlobalEffect    data/shaders/road.ksh    SetGlobalTextures    data/images/roadedge.tex    data/images/square.tex    EnvelopeManager    AddEnvelopeManager    PostProcessor    AddPostProcessor    FontManager    AddFontManager    IsHUDPaused    SetHUDPause 	   Settings    SetInstanceParameters    EraseSaveGame 	   SaveGame    ShowHUD    ProcessJsonMessage    telnet    TheFrontEnd    SeasonManager    fonts    Start    exiting_game    RequestShutdown 	   Shutdown                 *   A   �@  ��@�   �  A �� �@  �@�� �AA � ����A  Ɓ�  AB � ܁ B  �@@��� � � � � @��     � @� � ��C U ��@  @�^   �           string    gsub    %.    /    gmatch    package    path    ([^;]+)    %?    \    kleiloadlua    
	no file '    ' (checked with custom loader)     *                                                                                                                                 	      modulename     )      errmsg    )      modulepath    )      (for generator)    (      (for state)    (      (for control)    (      path    &   	   filename    &      result    &           %   '        E   �   ]  ^    �       kleiloadlua        &   &   &   &   '      	   filename                s   w       �   �  � ��@  �   �@   �       VERBOSITY_LEVEL    print        t   t   t   u   u   u   w         msg_verbosity           arg                �   �     	   E   �   \ � ����A  �@Ɂa�  @� �       ipairs    Prefabs    name        �   �   �   �   �   �   �   �   �   �   �         arg     
      (for generator)    
      (for state)    
      (for control)    
      k          v          prefab               �   �       E   �   \� �@  � � �  @  A�@��@  ��   � ܀ W �  ��@  � � A @  A�@�Z   � ��   � � � � �@   �    	   loadfile    assert    Could not load file     type 	   function -   Prefab file doesn't return a callable chunk         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      	   filename           fn             RegisterPrefabs     �   �     3   E   F@� �   �   ƀ�   A�  � �\�    � E  F � @�  ��� ��  @  � � ��@ �@ �  Z    ���� �� �� W@A@�� C�   � ��@CA� �@���C@  �@�� D�@��  �   @�ŀ � @  �@��@ �   �       string    sub    find    [^/]*$    Prefabs     print    Can't find prefab  	   tostring       �   fn    TheSim 
   AnimState    AddComponent 
   highlight    SetPrefabName    entity    GetGUID    Failed to spawn     3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         name     2      prefab    2      inst    2           �   �       E   F@� �   �   ƀ�   A�  � �\�    � D   F � @� ��E  K@� �   \���� �@ �   �       string    sub    find    [^/]*$    TheSim    SpawnPrefab    Ents        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         name           guid             renames     �   �            @@ � K�@ \� ��  �   �� �  ɀ� �@ ̀��@ ��  A � � �   �       TheSim    CreateEntity    GetGUID    EntityScript    Ents    NumEnts       �?
   AwakeEnts        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         ent          guid          scr               �   �    '   E   F � Z   @��   @ @ ��  �   �@� ��@�� ��  � �@� �@��@ � �@� �@�ˀ� �@ �� � ��� �   �@B ŀ � ��    �ŀ �@B �� � ��� �  �@B  �       Ents    entity    GetPrefabName    BrainManager    OnRemoveEntity 
   SGManager 
   KillTasks    NumEnts       �?    UpdatingEnts    num_updating_ents 
   AwakeEnts     '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         entityguid     &      ent    &      name    &         debug_entity     �   �     	   �   � ��   � �A��� � A  �       Ents 
   PushEvent     	   �   �   �   �   �   �   �   �   �         guid           event           data           inst               �   �            @@       �       TheSim    GetTickTime        �   �   �   �   �               �   �           @@ � D   @     �       TheSim    GetTick        �   �   �   �   �   �   �          	   ticktime                   @@       �       TheSim    GetTick                                           @@       �       TheSim    GetRealTime                                      D   F � Z@  ��E   �@  �   �� \� ��  ��   � ܀ W �  ��@  � �  � �@��   � � ܀� ��  D   F � ^   �    	   loadfile    data/scripts/    assert    type 	   function                                                                 	   filename        	   scriptfn 	            Scripts              E   �   \� Z   @ �� � �@�  �       LoadScript                           	   filename           fn                 $    
   E   F � Z   � ��@� �  �   ��  �   �       Ents    GetDebugString         
                    #  #  $        guid     	      ent    	           &  1       
   E   F@� �   ŀ  �  �  \@  D   Z   ��E   F@� �   �  \@�E   F@� �   �   �@��  \@  E   F�� �   ]  ^    �       table    insert 	   tostring 
   scheduler -   
-------DEBUG-ENTITY-----------------------
    GetDebugString    concat        (  )  )  )  )  )  )  )  +  +  +  ,  ,  ,  ,  ,  -  -  -  -  -  -  -  0  0  0  0  0  1        str             debug_entity     3  ;      D   Z    �D   F � K@� �   \@�      � �F @ K@� � � \@� �       entity    SetSelected        4  4  4  5  5  5  5  5  7  8  8  9  9  9  9  ;        inst              debug_entity     =  V    	'   E   I@@ E�  F � Z   ����� �   � ��  �@A�� �@���� �   � ��� �@A�� �@�� � �   � ��@ �@A� �@��� ��� �  ��C�  @ ��C�A ��   � �    
   AwakeEnts     Ents    brain    BrainManager 
   Hibernate    sg 
   SGManager    emitter    EmitterManager    pairs    components    OnEntitySleep     '   >  >  ?  ?  @  @  B  B  B  C  C  C  C  F  F  F  G  G  G  G  J  J  J  K  K  K  K  N  N  N  N  O  O  O  Q  Q  N  R  V        guid     &      inst    &      (for generator)    &      (for state)    &      (for control)    &      k    $      v    $           X  n    	)   E   �@  �  I�  E@  F � Z   ����� �   � ���  � A�� �@��@� �   � ��� � AA� �@���� �   � ��  � A�� �@��@ ƀ� �  ���B�  @ ���B�A ��   � �    
   AwakeEnts    Ents    brain    BrainManager    Wake    sg 
   SGManager    emitter    EmitterManager    pairs    components    OnEntityWake     )   Y  Y  Y  Y  Z  Z  [  [  \  \  \  ]  ]  ]  ]  `  `  `  a  a  a  a  d  d  d  e  e  e  e  h  h  h  h  i  i  i  j  j  h  k  n        guid     (      inst    (      (for generator)     (      (for state)     (      (for control)     (      k !   &      v !   &           r  ~    '   E   �@  �   �� \� ��  ��� ��@A �@��@A� �ˀ�@  �@��@A� ����F� �@��@A� ��@�F�� �@��@A� ����F� �@��@Cˀ��@ �@A� �����@ �   �       require    nis/    CreateEntity    AddComponent    nis    components    SetName    SetInit    init 
   SetScript    script 
   SetCancel    cancel    entity    CallPrefabConstructionComplete    Play     '   s  s  s  s  s  t  t  v  v  v  w  w  w  w  w  x  x  x  x  x  y  y  y  y  y  z  z  z  z  z  {  {  {  |  |  |  |  }  ~        nisname     &      nis    &      inst    &           �  �     	      @@ � Y�@   �@   �    �       TheSim    GetTimeScale             	   �  �  �  �  �  �  �  �  �              �  �    $   E   W@  ��   @�E@  ��  ��@�  \@�E@ K�� �� \@�E  K@� �  \@���E@  ��  ��@�� \@�E@ K�� �� \@�E  K � �  \@�E@ � � \@  �       IsHUDPaused    Print 
   VERBOSITY    INFO    pause    TheSim    SetTimeScale         	   TheMixer    PushMix    unpause       �?   PopMix    ShowHUD     $   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �        val     #           �  �       W @ ��E�  F�� �   \� G@  E@  �@  � A�@  @ ��@ ��AI� �E@  �@  ��A�@    ��  I��� �        	   Settings    json    decode 	   savedata    SAVE_NAMES    latest 
   character        �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     	   settings                �  �       E   K@� �   \@� �       TheSim    ErasePersistentString        �  �  �  �  �     	   savename                �      �   J   �   I� ��@  ŀ  �  � ���   �B�  @���  �
���B� @B@	����B  @����BC� B  ��B��   �����C���܂ �B� FC�C@B� �� FC��  	�� CDF� �C�F����C��B��D�  @�ʀ  �@E��@E�I����� � �AA ܀�� @��� A��   @��� FA�	A���� F�KA�\� 	A��� F�� ���H�� I���	���� FA�	A��� F�� ��E� � �� \A�  ��J  I@�K�C\� I@�F� ��	 ��B��I�JI���F� ��	 ��B��I��JI���F� ��	 ��B��I�KI���E� ��� �A \A�E� ��� �AA�� \A�E� ��� ��E�� \A�E� ��� ��G� \A�E� ��� ��G�A \A�E� �� �� \A�E� �� ��L� \A�E� �� �AM�� \A�E� �� �AI�� \A�E� �� � \A�EA �� ��� W�N  �B  � \� �� �O   @��B ���� A� �  ��B P  � �BP�� B� � C      ents            pairs    Ents 	   persists    prefab 
   Transform    entity 
   GetParent     components    health    IsDead    IsValid    GetWorldPosition    GetSaveRecord    table    insert       �?   map 	   revealed        tiles    TheSim    FindFirstEntityWithTag    ground    assert &   Cant save world without ground entity 	   LevelMap    GetStringEncode    width    height    GetSize 	   topology    player &   Cant save world without player entity    playerinfo    day    TheGlobalInstance    clock 
   numcycles 	   dayphase    phase    timeleftinera    timeLeftInEra "   Map missing from savedata on save )   Map prefab missing from savedata on save (   Map tiles missing from savedata on save (   Map width missing from savedata on save )   Map height missing from savedata on save )   Playerinfo missing from savedata on save    x +   Playerinfo.x missing from savedata on save    z +   Playerinfo.z missing from savedata on save -   Playerinfo day missing from savedata on save &   Entites missing from savedata on save    DataDumper 	   PLATFORM    NACL    SetPersistentString    ENCODE_SAVES    print    Saved    HUD 
   PushEvent    ontriggersave     �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                	   savename     �      save    �      nument    �      (for generator)    >      (for state)    >      (for control)    >      k    <      v    <      x '   <      y '   <      z '   <      record )   <      ground F   �      player b   �      data �   �      insz �   �      outsz �   �                    E   K@� ��  \��Z   @���� �   ��   � �� A�@ @ ��@A�@  �       TheSim    FindFirstEntityWithTag    player    HUD    Show    Hide                      	  	  
  
                    val           MainCharacter          HUD                 *    &   E   K@� ��  \����  �  A �A@  �� ��AW �����A@�@�ŀ � ��  �@ ����A �� ��@ �@�  ���A��@�Z   � ���� A� �  �@  �       TheSim    FindFirstEntityWithTag    player    TrackedAssert    ProcessJsonMessage    json    decode    sim     toggle_pause    SetHUDPause    IsHUDPaused    upsell_closed    HandleUpsellClose    quit 
   PushEvent     &                                   !  !  !  !  !  !  "  "  "  #  #  #  $  $  $  %  %  &  &  &  &  *        message     %      player    %      command 
   %           6  ?              � �@  A�  @ �   A � � �@ �@� @�� �� � @  A  @  � 	      CHEATS_ENABLED    require 
   debugkeys    TheSim    LoadPrefabs 	   frontend    TheFrontEnd 	   FrontEnd 
   gamelogic        7  7  7  8  8  8  <  <  <  <  <  <  =  =  =  >  >  >  ?              G  l     	2           � �  �    @  �@ ��  �  A J  �  @  � B � � E� F � �   \� @� � �E� \@�  � C � ��  C@ �A@   �A� �� �  �@�� �@��� � E � d    � �A Ł � ܁ � �@� �       exiting_game    TheFrontEnd    PushScreen    PopupDialogScreen 
   Quitting!    Packing up the science.    GetProfileStats    string    len       (@	   Shutdown 	   PLATFORM    NACL    /inst/exit    /anon/exit    Print 
   VERBOSITY    DEBUG    About to send stats and exit!    TheSim    QueryServer    POST       @       d  g      �   �@  ƀ��  D  �� �  �@ �  �@�  �       Print 
   VERBOSITY    DEBUG    DoInitGame TheSim:QueryServer 	   Shutdown        e  e  e  e  e  e  e  e  f  f  g        result     
      isSuccessful     
         query 2   H  H  H  I  K  K  M  M  N  N  N  N  N  M  S  S  S  T  T  T  T  T  T  U  U  V  Y  Z  Z  Z  [  [  ]  a  a  a  a  a  c  c  c  g  g  h  i  i  i  k  c  l        stats    1      query    1           n  q     	      E@  F�� ��  @�  @A @  �       Print 
   VERBOSITY    DEBUG    Ending the sim now!    TheSim    Quit     	   o  o  o  o  o  p  p  p  q          �                                                     
   
   
   
   
   
   
   
   
   
                                                                                          !   #   #   #   $   '   %   ,   ,   ,   -   -   -   -   .   .   .   A   A   A   F   F   F   G   G   G   H   H   H   I   I   I   J   J   J   K   K   K   L   L   L   M   M   M   N   N   N   O   O   O   P   P   P   Q   Q   Q   R   R   R   S   S   S   T   T   T   U   U   U   V   V   V   W   W   W   X   X   X   Y   Y   Y   Z   Z   Z   [   [   [   \   \   \   ]   ]   ]   _   _   _   `   `   `   a   a   a   b   b   b   c   c   c   d   d   d   e   e   e   f   f   f   i   i   i   k   k   k   l   l   l   m   m   m   q   q   q   w   s   z   z   z   z   z   z   }   }   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �            	            $    1  1  &  ;  ;  3  V  =  n  X  ~  r  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �      *    ,  ,  ,  ,  ,  ,  -  -  -  1  1  2  2  2  4  4  4  ?  6  E  E  l  G  q  n  q        loadfn 1   �     basedir 9   �     Mixer �   �     RegisterPrefabs �   �     renames �   �     debug_entity �   �  	   ticktime �   �     Scripts �   �      