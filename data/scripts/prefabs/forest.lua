LuaQ  k   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\forest.lua           D�      A@  ��  ŀ  ���
�  	AA�	�A�	AB�� �ŀ  ƀ�
�  	�B�	�A�	C�� �ŀ  ����� � ��  �@�AE�  F��FAF���  ��@�  �A �� � J � �B � ���� � @� ܂� A� �  ��E �� ��\��� �   ��bB  ��� C �EJ IƋI�ƌIǍI�ǎ�B 
 EC F��� �ȋ�CȌ��ȍ��Ȏ"C J �C �I� �CɋɃɌ�ǍɃǎbC � �C ���
 	ʋ	Dʌ	�ʍ	�ʎ�C � D KJ IDˋI�ˌI�ˍI̎�C 
 ED FD�� ��̋��ˌ��ˍ�̎"D J �D ��L	� �͋�D͌�ǍɄǎbD �B��� 
 A� ��  ��͋�Ό"C �B� 
� J �C �CNʃ  Ƀ΋ɃƌbC "C� dC  ��  ��  $   �  �      @ � \D @ � \D @ ��\D J��� � E A� �� ��  AF �� ��  AG �� ��  AH �� �� 	 AI �� �� 
 AJ �� ��  AK �� ��  AL �� ��  AM �� ��  AN �� �N � A �O �� � A �P �� bD �D �          	$�       d    
� �� �E   �           �  �         �	     �
  �  �   � F @ �������   � n      data/levels/textures/snow.tex 1   data/images/colour_cubes/identity_colourcube.tex    SEASONS    SUMMER    DAY &   data/images/colour_cubes/day05_cc.tex    DUSK '   data/images/colour_cubes/dusk03_cc.tex    NIGHT (   data/images/colour_cubes/night03_cc.tex    WINTER %   data/images/colour_cubes/snow_cc.tex (   data/images/colour_cubes/night04_cc.tex    PlayFootstep    data/images/wave.tex    data/shaders/texture.ksh    Asset    SOUND    data/sound/forest_stream.fsb    IMAGE    SHADER    GROUND    ROAD    name    cobblestone    noise_texture    data/images/square.tex 	   runsound    dontstarve/movement/walk_dirt 
   walksound    dontstarve/movement/run_dirt    MARSH    marsh ,   data/levels/textures/Ground_noise_marsh.tex    dontstarve/movement/walk_marsh    dontstarve/movement/run_marsh    ROCKY    rocky %   data/levels/textures/noise_rocky.tex    SAVANNA    yellowgrass 3   data/levels/textures/Ground_noise_grass_detail.tex #   dontstarve/movement/walk_tallgrass "   dontstarve/movement/run_tallgrass    FOREST    forest &   data/levels/textures/Ground_noise.tex    dontstarve/movement/walk_grass    dontstarve/movement/run_grass    GRASS    grass    DIRT    dirt +   data/levels/textures/Ground_noise_dirt.tex       �?   web #   data/levels/textures/web_noise.tex    UNDERGROUND    falloff    evergreen_normal    evergreen_short    evergreen_tall    sapling 
   berrybush    rock1    rock2    tallbirdnest    hound    krampus    mound    gravestone    flower    beefalo    pigman 	   pighouse    pigking    bonfire 	   mandrake    beehive    goldnugget    crow    robin 
   butterfly    rabbithole    flint    carrot_planted    log 
   spiderden 	   tentacle    spawnpoint    phonograph_gears    phonograph_box    phonograph_crank    phonograph_cone    pond    marsh_tree    marsh_bush    reeds 
   fireflies    forest_ambiance 
   turf_road    turf_rocky    turf_marsh    turf_savanna 
   turf_dirt    turf_forest    turf_grass    TheMap    Prefab    forest/forest 
          "        F @ Z   ���@@ �� �   ���    ��@ �@� ��  � �A� ���A�� �A� ���A� �       SoundEmitter    GetCurrentTileType    sg    HasStateTag    running 
   PlaySound 	   runsound 
   walksound                                                                          "         inst           sound          tile       	   tileinfo               D   F        A   �   �@  U�� ^   �       data/levels/tiles/    .tex        E   E   E   E   E   F         name                H   J        A   �   �@  U�� ^   �       data/levels/tiles/    .xml        I   I   I   I   I   J         name                L   M         �            M         season                 O   \    :   E   �   \ ���A  ���� �  �@D  � �B ����B  �  �@D  � �B � F�� �  B  �  �@D  � �  F�� �  B  a�  ��E@ � �\ @��A �����ł  ���  E �C � \��B  ��  @�a�  �� � 
      ipairs    unpack    table    insert    Asset    IMAGE    noise_texture    name    FILE    pairs     :   P   P   P   P   Q   Q   Q   R   R   R   R   R   R   R   R   S   S   S   S   S   S   S   S   S   S   T   T   T   T   T   T   T   T   T   T   P   T   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Y   Y   Y   Y   X   Y   W   Z   \         layers     9      (for generator)    %      (for state)    %      (for control)    %      i    #      data    #   
   tile_type    #      properties    #      (for generator) (   9      (for state) (   9      (for control) (   9      season )   7      cc_data )   7      (for generator) ,   7      (for state) ,   7      (for control) ,   7      cc_name -   5      tex_filename -   5         assets    GroundImage    GroundAtlas    SEASON_CCS     �   �        E   K@� \� �   � � ���  � �O MA���@��@ ŀ �@�  � �       TheSim    GetTickTime            PostProcessor    SetColourCubeLerp       �?   Yield        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         total_time        
   tick_time       
   time_left               �   �    
   K@ �� $      �      �     EB  \A� �       ListenForEvent    TheGlobalInstance        �   �       �   �@@  D� AD A�@��   ��@  D� AD�A�@��   ��@ �@��@ �      ��A �@� �       PostProcessor    SetSourceColourCube    SetDestColourCube    SetColourCubeLerp            StartThread    GUID        �   �           D � @  �            �   �   �   �             UpdateCCLerp    length    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           data              SEASON_CCS    CURRENT_SEASON 	   start_cc    end_cc    UpdateCCLerp    length    �   �   �   �   �   �   �   �   �   �   �   �         inst           event        	   start_cc           end_cc           length              SEASON_CCS    CURRENT_SEASON    UpdateCCLerp     �   �           @@ �@    ��D   � � F�� ��@ �� �   � �� � �   ��@A �� �   � ���� �  @���A �� �   @ �� � �   � 	      TheGlobalInstance    components    clock    IsDay    DAY    IsDusk    DUSK    IsNight    NIGHT        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         clock          season             SEASON_CCS    CURRENT_SEASON     �   �       �   ��� �   �@�܀   �@��A�  �@� A� d    � �AA A� �       PostProcessor    GetDestColourCube    SetSourceColourCube    SetDestColourCube    StartThread    GUID        �   �           E   K@� \�   �����  � A�@ �  �AA�  �  �� ���  ������ � �@ �@�@  �@ �@� �� � 
      TheSim    GetTickTime            math    min       �?   max    PostProcessor    SetColourCubeLerp    Yield        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      
   time_left       
   tick_time          lerp             time    �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           time           cc          current_cc             GetCCToActivate     �   .   �   E   \�� �@� ��@�� �@� ���܀ A� A� FA� K��\� GA K�A� B \A K�B�� \A�KC�  \A�KAC�� \A�K�C��  \A �@ K�� �� \A�K�� � \A�FA� KA��  \A�I�E�D I@�EA � \@��� ���� ��E KC�� �@ � D � \� ���\� ��� ��C�a�  ��EA ��\@��� ����  CG� ����܃  F��� F��� EC K��� \C�a�  ��D F�FA�� �AG� �HD����\� � ����� Ƃ��� ��@ �A��A�E� F���A����D��A��� AB
 �A�ˁ� A�
 �A�ˁ� A �A��A� ��ˁ�A� �A��  � A �B �� � �A �  � A �� �B � �A �  � A� �B �B � �A �� AB �   �  ł �A���� BK�N  ��KO\� Z  @ ��  �KBO\� Z    ���E� K����\B�E� K���\B�E� KB��� \B�^   � C      CreateEntity    entity    AddTransform    AddMap    AddWaveComponent    GroundCreep    AddGroundCreep    SetRegionSize       @@      0@   SetRegionNumWaves       @   SetWaveTexture    SetWaveEffect    SetWaveSize       �@      �@   TheMap    AddTag    ground    NOCLICK    SetCanSleep 	   persists  	   tileinfo    ipairs    unpack    name    MapLayerManager    CreateRenderLayer    noise_texture    AddRenderLayer       �?       @   GROUND    UNDERGROUND    SetUndergroundRenderLayer    SetImpassableType    IMPASSABLE    SetOverlayTexture    SpawnChild    forest_ambiance    AddComponent    birdspawner    butterflyspawner    components    SetButterfly 
   butterfly    daytime    NIGHT    DAY       @	   dusktime    DUSK 
   nighttime        @   ListenForEvent    seasonChange    TheGlobalInstance    clock    IsDay    IsDusk    PostProcessor    SetSourceColourCube    SetDestColourCube    SetColourCubeLerp                        H   � � �     �@� �          $@                         inst           data              CURRENT_SEASON    UpdateAndTransitionCC �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                   	  	  	  
  
  
  
  
  
  
  
  
  
  
  
                                                                                                                     !  !  "  "  "  "  #  #  $  $  $  $  %  )  )  )  )  *  *  *  *  +  +  +  +  -  .        Sim     �      inst    �      trans    �      map    �      waves    �      (for generator) 1   F      (for state) 1   F      (for control) 1   F      i 2   D      data 2   D   
   tile_type 5   D      props 5   D      layer_name 6   D      handle A   D      (for generator) I   ^      (for state) I   ^      (for control) I   ^      i J   \      data J   \   
   tile_type M   \      props M   \      handle X   \      underground_layer a   �      underground_handle m   �      cc �   �      clock �   �         WAVE_IMAGE    TEXTURE_SHADER    GROUND_PROPERTIES    GroundAtlas    GroundImage    GROUND_CREEP_PROPERTIES    underground_layers    snow_texture    RegisterTimeColourCube    CURRENT_SEASON    UpdateAndTransitionCC    NIGHT_COLOURCUBE    DAY_COLOURCUBE    DUSK_COLOURCUBE �                              	   
   
   
   
                                                      "      $   %   '   )   )   )   )   *   *   *   *   +   +   +   +   ,   ,   ,   ,   -   -   -   -   .   0   0   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   6   6   6   6   6   6   6   6   6   7   7   7   7   7   7   7   7   7   8   8   8   8   8   8   8   8   9   ;   ;   <   <   <   <   <   =   ?   @   A   A   A   A   A   A   B   F   J   M   \   \   \   \   \   ^   ^   ^   _   _   _   `   `   `   b   d   e   f   g   h   i   j   k   l   m   n   p   q   r   t   v   w   x   y   z   {   }      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  0  0  0  0  0  0  0  0        snow_texture    �      IDENTITY_COLOURCUBE    �      SEASON_CCS    �      DAY_COLOURCUBE    �      DUSK_COLOURCUBE    �      NIGHT_COLOURCUBE    �      CURRENT_SEASON    �      WAVE_IMAGE "   �      TEXTURE_SHADER #   �      assets 9   �      GROUND_PROPERTIES z   �      GROUND_CREEP_PROPERTIES �   �      underground_layers �   �      GroundImage �   �      GroundAtlas �   �      SetColourCubes �   �   
   AddAssets �   �      prefabs �   �      UpdateCCLerp �   �      RegisterTimeColourCube �   �      GetCCToActivate �   �      UpdateAndTransitionCC �   �      fn �   �       