LuaQ  n   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\fireflies.lua           &   
 � E   �@  ��  \���   ��   � �"@  A@ �     � �@    � $�       �d�  �    �A   �$�   �   �  �     �      E� �� �    ] ^   �       Asset    ANIM    data/anim/fireflies.zip    IMAGE #   data/inventoryimages/fireflies.tex       �?   Prefab    common/objects/fireflies        
       !   F @ F@� K�� \@ F�@ K � �@ \@�F�@ K�� �� � \@ F B K@� � � \@�F @ F@� K�� ��   E FA�\�� N��LA���      �A      \@� �       components    fader    StopAll 
   AnimState    PlayAnimation 
   swarm_pre    PushAnimation    swarm_loop    Light    Enable    Fade            math    random        @      @                 D   F � K@� �   \@� �       Light    SetIntensity                                v              inst                    @ �@  @� �    
   RemoveTag    NOCLICK                                 inst !                                                                                                            inst            
   INTENSITY               F @ F@� K�� \@ F�@ K � �@ \@�F @ F@� K�� �   � E FA�\�� N��LA���      �A      \@� �       components    fader    StopAll 
   AnimState    PlayAnimation 
   swarm_pst    Fade            math    random       �?      �?                 D   F � K@� �   \@� �       Light    SetIntensity                                v              inst             
       @ �@  @�   �@ �@ �   @� �       AddTag    NOCLICK    Light    Enable     
                                           inst                                                                                  inst           
   INTENSITY               F @ F@� K�� ��  \@�D   �   \@ E  F � F@� K�� \� Z   @�K�A �  �@�܀� ����� �$   �     \@  �       components 	   workable    SetWorkLeft       �?   TheGlobalInstance    clock    IsDay    DoTaskInTime    math    random        @                     D � @  �                                  fadeout    inst                                                                                        inst              fadein    fadeout         $        F @ F@� F�� Z   @ �A�  ^   �       components    inventoryitem    owner    HELD        !   !   !   !   !   "   "   $         inst                '   +       E   F@� F�� K�� \� Z   � �D   �   \@  �       TheGlobalInstance    components    clock    IsNight        (   (   (   (   (   (   (   )   )   )   +         inst     
         fadein     -   /       D   �   \@  �            .   .   .   /         inst              fadeout     1   y    	�   E   \�� �@� ��@�@ �@� ��@�@ �  �@A��A��A�� �@� � �AA �@��@� ˀ��@ �@� ���܀ ��A A����  A����A A��� A�A��� ��  A�A� �E�� A�A� F�A A�A� �F�A A�A� �F�� A�� �A A�� �� A�� �� A�A� �GD� 	A�� �A A�A� AH�H�� �IA�A� AHAI�A A�A� AH�I�    A�� ��	 A�A� �IEA
 F��	A�� ��
 A�A� �JK��A�A� �J	�˖� �� A�A� �KEA
 FA�	A�A� AG�L�� � A A� AGAM� A�A� AG�M��A��� � �A    �    A��� �A �    �    A��   � � @� A ^   � :      CreateEntity    entity    AddTransform    AddAnimState    TheGlobalInstance    components    clock    IsNight    SetSleepRadius       0@   AddPhysics 	   AddLight    SetFalloff       �?   SetIntensity 
   SetRadius    Enable 
   SetColour �������?xxxxxx�?�������?
   AnimState    SetBloomEffectHandle    data/shaders/anim.ksh    SetBank 
   fireflies 	   SetBuild    SetRayTestOnBB    AddComponent    playerprox    fader    inspectable 
   getstatus 	   workable    SetWorkAction    ACTIONS    CATCH    SetWorkLeft    SetOnFinishCallback 
   stackable    maxsize    TUNING    STACK_SIZE_SMALLITEM    inventoryitem    SetOnDroppedFn    canbepickedup     researchvalue 
   basevalue    RESEARCH_VALUE_WORKED    SetDist       @      @   SetOnPlayerNear    SetOnPlayerFar    ListenForEvent    daytime 
   nighttime        R   W       � � �@@�    �� � �@@��@   C���  � �A�F�A K��\ �  �  �@  �   �   �@  �       components 
   inventory 	   GiveItem    Vector3    TheSim    GetScreenPos 
   Transform    GetWorldPosition        S   S   S   S   T   T   T   T   T   T   T   T   T   T   T   T   T   T   U   U   U   W         inst           worker              fadeout     h   l            @ @@ �@ @  ��   �@ �  �@A��� ��A�����    �    @  �       components    inventoryitem    owner    DoTaskInTime    math    random       �?       @       j   j           D � @  �            j   j   j   j             fadeout    inst    i   i   i   i   i   i   j   j   j   j   j   j   j   j   j   j   j   l             inst    fadeout     m   q            @ @@ �@ @  ��   �@ �  �@A��� ��A�����    �    @  �       components    inventoryitem    owner    DoTaskInTime    math    random       �?       @       o   o           D � @  �            o   o   o   o             fadein    inst    n   n   n   n   n   n   o   o   o   o   o   o   o   o   o   o   o   q             inst    fadein �   2   2   3   3   3   4   4   4   6   6   6   6   6   7   7   7   7   8   8   8   :   :   :   ;   ;   ;   <   <   <   =   =   =   >   >   >   ?   ?   ?   ?   ?   B   B   B   B   D   D   D   D   E   E   E   E   G   G   G   G   I   I   I   J   J   J   L   L   L   M   M   M   M   O   O   O   P   P   P   P   P   P   Q   Q   Q   Q   Q   R   R   R   W   W   R   Y   Y   Y   Z   Z   Z   Z   Z   \   \   \   ]   ]   ]   ]   ]   ^   ^   ^   _   _   _   `   `   `   `   `   c   c   c   c   c   c   d   d   d   d   d   e   e   e   e   e   h   h   l   l   l   l   h   m   m   q   q   q   q   m   t   t   u   u   u   x   y         Sim     �      inst    �      isnight    �      light    �      
   INTENSITY 
   getstatus    fadeout 
   ondropped    onnear    onfar    fadein &                                                         $   +   +   /   /   y   y   y   y   y   y   y   y   {   {   {   {   {   {   {   	      assets 
   %   
   INTENSITY    %      fadein    %      fadeout    %   
   ondropped    %   
   getstatus    %      onfar    %      onnear    %      fn    %       