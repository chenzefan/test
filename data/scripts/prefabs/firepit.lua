LuaQ  l   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\firepit.lua           #      A@  @ 
 � E�  ��  �  \����  �@ � � �"@  J � �� b@� �   �@  $�       �E �A �    @� \���� ��  A �B ��^   �       require    prefabutil    Asset    ANIM    data/anim/firepit.zip    IMAGE !   data/inventoryimages/firepit.tex    campfirefire    Prefab    common/objects/firepit    MakePlacer    common/firepit_placer    firepit    preview                   � @ �@@��@�@ ��  �  �� �@A��AAA �A �@  � B �@B� �@���B �@  �       components    lootdropper 	   DropLoot    SpawnPrefab    collapse_small 
   Transform    SetPosition    GetWorldPosition    SoundEmitter 
   PlaySound     dontstarve/common/destroy_stone    Remove                                                                          inst           worker                        	   � @ �@@�  �@�� @ ��@ �@� �    
   AnimState    PlayAnimation    hit    PushAnimation    idle     	                                    inst           worker                   m    �   E   \�� �@� ��@�� �@� ���܀ A� AA A� AA� K�A�� \A�KB�A \A�K���� \A�K��A   \A K���� \A�K�� � \A�EA �� �� \A�K�� � \A�FA� F�K����  AB �� �B  \A  K�� �� \A�K�� � \A�FA� F�KA�Ł ���\A�FA� F�K��A \A�FA� F�K���  \A�FA� F�K���� \A�K�� �	 \A�FA� F���	 ��II���FA� F�IAJ�FA� F�K���A \A�FA� F���	 �KI���FA� F��    � I���FA� F�K���A    � \A�FA� F�K���    � \A�FA� F�K�Ł	 �A�\A�K�� �� \A�FA� F����  I���K� �A $   �\A ^   � 6      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    AddMiniMapEntity    SetIcon    firepit.png    SetPriority       �?   SetBank    firepit    PlayAnimation    idle 	   SetBuild    AddTag 	   campfire    MakeObstaclePhysics 333333�?   AddComponent 	   burnable    components 
   AddBurnFX    campfirefire    Vector3         �������?   lootdropper 	   workable    SetWorkAction    ACTIONS    HAMMER    SetWorkLeft       @   SetOnFinishCallback    SetOnWorkCallback    fueled    maxfuel    TUNING    FIREPIT_FUEL_MAX 
   accepting    SetSections 
   bonusmult    FIREPIT_BONUS_MULT    ontakefuelfn    SetUpdateFn    SetSectionCallback    InitializeFuelLevel    FIREPIT_FUEL_START    inspectable 
   getstatus    ListenForEvent    onbuilt        ?   ?            @ @@ ��  @� �       SoundEmitter 
   PlaySound    dontstarve/common/fireAddFuel        ?   ?   ?   ?   ?   ?             inst     A   E            @ @@    ��    @ �@    ��    @ @@ �@ �   � @��@� A�� �   � �ƀ��@��  @   �       components 	   burnable    fueled    SetFXLevel    GetCurrentSection    GetSectionPercent        B   B   B   B   B   B   B   B   B   B   C   C   C   C   C   C   C   C   C   C   C   C   C   C   C   E             inst     G   V    -    @ @�D   F@� F�� K�� \@ D   K � �@ \@���D   F@� F�� K�� \� Z@  @�D   F@� F�� K�� \@ D   F@� F@� Z@  � �D   K � �@ \@�D   F@� F�� K@� �     A@�B�B \@   �               components 	   burnable    Extinguish    RemoveComponent    cooker 
   IsBurning    Ignite    AddComponent    SetFXLevel    fueled    GetSectionPercent     -   H   H   I   I   I   I   I   J   J   J   J   J   L   L   L   L   L   L   L   M   M   M   M   M   N   N   N   N   N   O   O   O   O   S   S   S   S   S   S   S   S   S   S   S   V         section     ,         inst     ]   e        F @ F@� K�� \� �� � ��  �  @�@� ���  �� � A �A �@ �@ �   � 
      components    fueled    GetCurrentSection            OUT       @   EMBERS    LOW    NORMAL    HIGH        ^   ^   ^   ^   _   _   `   `   `   a   a   b   b   b   b   b   b   c   c   e         inst           sec          t               g   j     
       @ �@  @�   �@ ��  �   @  �       PlayAnimation    place    PushAnimation    idle     
   h   h   h   h   i   i   i   i   i   j             anim �                                                !   !   !   "   "   "   $   $   $   %   %   %   %   &   &   &   '   '   '   )   )   )   )   ,   ,   ,   .   .   .   .   .   .   .   .   .   .   1   1   1   2   2   2   3   3   3   3   3   3   4   4   4   4   4   5   5   5   5   5   6   6   6   6   6   9   9   9   :   :   :   :   :   ;   ;   ;   =   =   =   =   =   >   >   >   >   >   ?   ?   ?   ?   ?   A   A   A   E   E   A   G   G   G   V   V   G   X   X   X   X   X   X   \   \   \   ]   ]   e   e   g   g   j   j   g   l   m         Sim     �      inst    �      trans    �      anim    �      minimap    �         onhammered    onhit #                                          	               m   m   m   o   o   o   o   o   o   p   p   p   p   p   p   p   p         assets    "      prefabs    "      onhammered    "      onhit    "      fn    "       