LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\bonfire.lua              
 � E   �@  ��  \���   ��   � �"@  A@ �   �@  $�    �d�       � �   �      �Ł � @ �  � �   �       Asset    ANIM    data/anim/bonfire.zip    SOUND    data/sound/common.fsb       0@   Prefab    common/objects/bonfire        	        4   E   F@� �   ��@��   AA� E K��\� ��A �B� �A��A ��� ��   ܁  � LBB� �� � L�B� ��������AB  A � �BA�� �����B�� ����F�A KB�������\B�E �B \B �� �       math    sin    min       @   TheSim    GetTick    GetTickTime    Light    Enable        @�,C���?      @      �?   SetFalloff �������?�������?   Sleep �������?    4   
   
                                                                                                                                                         	      inst     3      sin    3      min    3   
   fade_time    3      start_tick    3   
   tick_time    3      tick    2      flicker    2      lerp )   2              ?     L   E   F@� �   ��@��   AA� E K��\� �  �A ܁�  � @�� @� ���\� B@� ��\� BBBL���@ �� � �B�܂ ������B��\���B���B �C���CN��C�B�� �B �B ������ ��D ��D �B��BE � �E�B���B �FC �B���F ��F �B���B �BG  �B�  � � �       math    sin    min       @   TheSim    GetTick    GetTickTime        @�,C���?      @      �?   Light    SetFalloff �������?�������?      4@   Sleep �������?
   AnimState    PlayAnimation    off 
   RemoveTag    ITEMTAG    FIRE    SetIntensity            SoundEmitter 
   KillSound    burning    Enable     L           !   !   #   $   $   $   %   %   %   '   *   *   +   +   +   +   +   +   +   +   +   +   +   +   ,   ,   .   .   .   .   .   .   .   .   .   .   /   /   1   1   1   1   1   1   1   3   3   3   5   5   6   7   7   7   7   8   8   8   8   9   9   9   9   :   :   :   :   ;   ;   ;   ;   <   =   ?   
      inst     K      sin    K      min    K   
   fade_time    K      start_tick    K   
   tick_time    K      fully_lerped    K      tick    J      flicker    J      lerp &   J           A   F       F @ W@� � �E�  � @ \@ K�@ �          \��	@ � �       light_task     KillThread    StartThread        E   E           D � @  �            E   E   E   E             FadeOut    inst    B   B   B   C   C   C   E   E   E   E   E   E   F         inst              FadeOut     H   Q       F @ W@� � �E�  � @ \@ K�@ �          \��	@ �F A K@� �� � \@ K�A �  �@�\@�F�B K�� � � \@�F C K@� �� � \@  �       light_task     KillThread    StartThread 
   AnimState    PlayAnimation    on    AddTag    ITEMTAG    FIRE    Light    SetIntensity    SoundEmitter 
   PlaySound    dontstarve/common/campfire    burning        L   L           D � @  �            L   L   L   L             FadeIn    inst    I   I   I   J   J   J   L   L   L   L   L   L   M   M   M   M   M   N   N   N   N   O   O   O   O   P   P   P   P   P   Q         inst              FadeIn 
   INTENSITY     S   q    F   E   \�� �@� ��@�� �@� ���܀ A� A� FA� KA�\� �� �� � �A��A� �B�� �ABA� �A���� ��D  �A���� �A�A� �� � �A���� �A�B  �A�ˁ� A� �A��� AB �A�ˁ�AB �A����AB �A���AB �A��� �� �� �   �   � B��� �B �B      � B�^   �       CreateEntity    entity    AddTransform    AddAnimState 	   AddLight    AddSoundEmitter    MakeObstaclePhysics 333333�?   AddMiniMapEntity    SetIcon    village.png    Light    SetIntensity 
   SetColour �������?�������?�������?   Enable    AddComponent    cooker    AddTag    bonfire    SetBank 	   SetBuild    PlayAnimation    off    ListenForEvent    daytime    TheGlobalInstance 
   nighttime        m   m       �   � � �@  �            m   m   m   m         inst           data           	   StartDay    local_inst     n   n       �   � � �@  �            n   n   n   n         inst           data              StartNight    local_inst F   T   T   U   U   U   V   V   V   X   X   X   Y   Y   Y   \   \   \   \   ^   ^   ^   _   _   _   a   a   a   a   b   b   b   b   b   b   c   c   c   c   e   e   e   g   g   g   h   h   h   i   i   i   j   j   j   l   m   m   m   m   m   m   m   n   n   n   n   n   n   n   p   q         Sim     E      inst    E      trans    E      anim    E      light    E      sound    E      minimap    E      local_inst 6   E      
   INTENSITY 	   StartDay    StartNight                                        ?   F   F   Q   Q   Q   q   q   q   q   s   s   s   s   s   s   s         assets 
      
   INTENSITY          FadeIn          FadeOut       	   StartDay          StartNight          fn           