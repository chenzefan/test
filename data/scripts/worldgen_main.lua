LuaQ  j   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\worldgen_main.lua           	�         ��@  A�  �   @��   A E   @ @  A@ @ � � $   E  F@� �� ��B��    \@ A  �@ �   � �A� �@  �� �  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �  �� �@ �  �� �@ �  �  �@ �  �@ �@ �@  �� �@ �  �� 
  d�     G d�  GA EA \�� � �� �A �� �� �	 �  ��    �A	 � ǁ	 �A ��	 �  �
 � �A
 �  ǁ
 �  ��
 �� � � �A �  ǁ �A �� � � �� �A � ǁ �A �� � � �� �A �A   � �   � 6      SEED    print    SEED =     math    randomseed    worldgen_main.lua MAIN = 1    MAIN       �?   table    insert    package    loaders    ./    TheSim    data/scripts/ 	   loadfile    require    simutil    strict    json    vector3    tuning    strings 
   constants    class    debugtools    util    prefabs 	   profiler    dumper    running worldgen_main.lua
       �   CallOnNextUpdate    GetTickTime    GetTime    GetTick    GetTimeReal    LoadScript 
   RunScript    GetDebugString 	   Settings    SetGlobalSettings    TrackingEventsStats    TrackingTimingStats    IncTrackingStat    SetTimingStat    ProfileStats    GetProfileStats    ProfileStatsSet    ProfileStatsAdd    ProfileStatsAddItemChunk    GenerateNewProfile    GenerateTEST    GenerateNew                *   A   �@  ��@�   �  A �� �@  �@�� �AA � ����A  Ɓ�  AB � ܁ B  �@@��� � � � � @��     � @� � ��C U ��@  @�^   �           string    gsub    %.    /    gmatch    package    path    ([^;]+)    %?    \    kleiloadlua    
	no file '    ' (checked with custom loader)     *                                                                                                                                 	      modulename     )      errmsg    )      modulepath    )      (for generator)    (      (for state)    (      (for control)    (      path    &   	   filename    &      result    &              !        E   �   ]  ^    �       kleiloadlua                        !      	   filename                =   ?       D   I @  �           >   >   ?         fn              PendingUpdateFns     E   G               �                   F   F   G               J   L               �                   K   K   L               N   P               �                   O   O   P               R   T             �     �       getrealtime        S   S   S   T               Y   _       D   F � Z@   �E   �@  �   �� \� �   � � ܀� ��  D   F � ^   �    	   loadfile    data/scripts/        Z   Z   Z   Z   [   [   [   [   [   \   \   \   \   ^   ^   ^   _      	   filename        	   scriptfn 	            Scripts     b   g        E   �   \� Z   @ �� � �@�  �       LoadScript        c   c   c   d   d   e   e   g      	   filename           fn               i   k            E@        �    	   tostring 
   scheduler        j   j   j   j   k               q   ~     ,   W @  �E�  ��  �  �@�   \� G@  E@  �@  ��A�@  @ ��� � BI� �E@  �@  �@B�@    ��� I���E@  �@  ��B�@    ��   I���E@  F � W@� ��E� �� \@ E  F@� �@  � C\@  �        	   Settings    TrackedAssert    SetGlobalSettings    json    decode 	   savedata    SAVE_NAMES    latest 
   character    wilson 
   purchases    random_seed     print 	   SEEEEED!    math    randomseed     ,   r   r   t   t   t   t   t   t   t   u   u   u   u   u   u   u   u   v   v   v   v   v   v   v   w   w   w   w   w   w   w   z   z   z   z   {   {   {   |   |   |   |   |   ~      	   settings     +           �   �        �   Z   ���   �@��@  � ��   � ��   ɀ� �  �@    ��@  �� ���   �       TrackingEventsStats               �?       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         stat        	   subtable           t               �   �        �      ��  �  �@  � �
  �    	�  A  �@O�@� � �  �       TrackingTimingStats    math    floor      @�@       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      	   subtable           stat           value           t               �   �            E@  �    ���  �@ J@  �@  I� �      ��  �@ J         �       GetTableSize    ProfileStats    json    encode    stats        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �               �   �        �   �@   �       ProfileStats        �   �   �         item           value                �   �        E   F � Z   @�E   �   �  �@@I�  @ �E   I@@  �       ProfileStats       �?       �   �   �   �   �   �   �   �   �   �   �   �   �         item                �   �        �   �  @@� ��   �   ��  �   �  �@ �   ���   �  �   � ��@�̀���� � ��   �  ���  �       ProfileStats        �?       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         item           chunk                �   �     J   E   �@  \@ E�  ��  �  \���@� �@ �   �� �� �A � ��    ܀ � ��@ � �@ ��  FAC�� ��  \� �A �� �AB ����� ��� BEF��F�� �A  � �� EB W��  �BB  B� �� ��� �A � �A�� A� ܁�� ��B�B�B 
  K�� � \B�E  �� \B E	 �� \B �  � %      require 	   profiler    newProfiler    time      j�@   start    map/forest_map    map/debug_map    print    Generating new world       `@      P@	   Generate    forest    Generation complete [    width    ,    height    ]    string    len    map    tiles    DataDumper    WINDOWS     stop    io    open    profile.txt    w+    report    close    lua_report    debugtools 
   dumptable     J   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	      debug     I   	   profiler    I      Gen    I   
   map_width    I      map_height    I   	   savedata    I      strdata 2   I      outfile 9   I      tmp ?   I           �   �     6   E   �@  \� ��  ��  �  A ��   A
�B� A� � ��� F�AF�@����F�AF��@����F�AF���� �F�AF��Y��  �BB  B� �� ��A�� F�AF���C Ń  �܃ � E FD�F���B��B �� � �B � �  �       require    map/forest_map       p@      �?     @�@	   Generate    forest    map    width            height    print    , 
    ok size: 	   tostring     generate-->    TrackingTimingStats    time 	   generate    collectgarbage    collect     6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
      count     5      Gen    5      max_map_width    5      max_map_height    5      (for index)    4      (for limit)    4      (for step)    4      i 	   3      gener    3      isnottoobig     3           �   !    
a   A   �   �@  �  ܀ A  A�  A A  A A A �A�A @ �EA �FA��� ��   @ \���� � �A �A Ɓ�� �A��A Ɓ���B �A��A Ɓ�Ɓ�� �A��A Ɓ���B �A��A Ɓ�Ɓ�� �A��A Ɓ���B �A��A Ɓ�� �A��A Ɓ���B �A��A Ɓ�Ɓ�� �A��A Ɓ���B �A��A Ɓ�Ɓ�� �A��A ��B	 �A��� ��	 �A ��	 �� E
 W@�  �BB  B� �� �  � *         �@   require    map/forest_map    map/map 
   map/tasks    tasks    sampletasks    oneofeverything 	   Generate    forest    print    Checking map...    assert    map &   Map missing from savedata on generate    prefab -   Map prefab missing from savedata on generate    tiles ,   Map tiles missing from savedata on generate    width ,   Map width missing from savedata on generate    height -   Map height missing from savedata on generate 	   topology /   Map topology missing from savedata on generate    playerinfo -   Playerinfo missing from savedata on generate    x /   Playerinfo.x missing from savedata on generate    y /   Playerinfo.y missing from savedata on generate    z /   Playerinfo.z missing from savedata on generate    day 1   Playerinfo day missing from savedata on generate    ents *   Entites missing from savedata on generate    Generation complete    DataDumper 	   PLATFORM    NACL     a   �   �   �   �   �   �   �   �                        
  
  
  
  
  
                                                                                                                                                     !        debug     `      max_map_width    `      max_map_height    `      Gen    `      choose_tasks    `   	   savedata    `      strdata _   `       �                                                                                          !      &   &   &   '   '   '   (   (   (   )   )   )   *   *   *   +   +   +   ,   ,   ,   -   -   -   .   .   .   /   /   /   0   0   0   1   1   1   2   2   2   4   4   4   7   9   <   ?   ?   =   G   E   I   I   L   J   P   N   T   R   W   _   _   Y   g   b   k   i   p   p   ~   q   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   !  �   #  #  #  #  #        loadfn    �      basedir    �      basedir J   �      last_tick_seen K   �      PendingUpdateFns L   �   	   ticktime S   �      Scripts Z   �       