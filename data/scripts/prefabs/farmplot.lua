LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\farmplot.lua           u      A@  @    A�  @ 
 �E�  �  �@ \����  �� � �����  � A ܀��  A� �A �"@  J ��� ��  AA �� ��  AB �� ��  b@��@ �� � A �  �A  $�  J��B ��F�B ���C GbB����  C A� �� ��  �B  
  EC �� �� � \ "C  J  �C �� � A� � bC  �B���          �  �     �        �� A� ��� �� �   � ��E� �C ��� ܃    @� \���� ��  �A	 � @  �� ����C	 �	 A�	 ��	 �
 ��   � )      require    prefabutil    tuning    Asset    ANIM    data/anim/farmplot.zip    IMAGE "   data/inventoryimages/farmplot.tex #   data/inventoryimages/farmplot2.tex #   data/inventoryimages/farmplot3.tex    plant_normal 	   farmrock    farmrocktall    farmrockflat    stick 
   stickleft    stickright 	   signleft 
   signright 
   fencepost    fencepostright       �              �?      ��   TUNING    FARM1_GROW_BONUS    FARM2_GROW_BONUS    FARM3_GROW_BONUS    Vector3    Prefab    common/objects/farmplot       �?   common/objects/farmplot2        @   common/objects/farmplot3       @   MakePlacer    common/farmplot_placer 	   farmplot    full        #   (        � @ �@@��@�@ ��  �  �� �@A��AAA �A �@  � B �@ �@B ��B� �@� �       components    lootdropper 	   DropLoot    SpawnPrefab    collapse_small 
   Transform    SetPosition    GetWorldPosition    Remove    SoundEmitter 
   PlaySound    dontstarve/common/destroy_wood        $   $   $   $   %   %   %   %   %   %   %   %   %   &   &   '   '   '   '   (         inst           worker                *   -         �            -         inst            worker                 1   >        �   @� @ ���  ���� @ ��  � �@�   ��� ��A � �@ �@� � 	      full            empty ��Q��?   med2 ��Q��?   med1 
   AnimState    PlayAnimation        3   4   4   5   5   6   6   7   7   8   8   9   <   <   <   <   >         inst           fert_percent           anim               O   �   	 1  A   ��  � � 
A  J� ����  �  A �A�bA� 	A���@� �� ��  
A  J ���  ����  D� �A��� A�  ���A�bA 	A�JA  � ���  A�  �� �A�
�D  ��  ��"B��A I���A  ��
�D L����  �� "B�J��  ��B��  � AbB���� ̂��  D� L��B��A������A  
� J�� ��   bB�"B� ����@ ����� �
A  J� ��� �  A �A�bA� 	A��JA  � �� BCA�  ��� �A�
�D L���  �B� "B��A I���A  �� 
�D L����  �� "B��A� ����A  
� J�� �BE��  �� bB�"B� ��
B  J� ���  ���  M� �B�bB� 	B�JB  �� ��  �DA�  �C� �B��B� I���B  �� 
�D  MC���  ̓� "C��B� ����B  
 J�� ��E��  � bC���� �C��  L� �C�"C ��
C  J� ��� ���  L�� �C�bC� 	C�JC  � �� �@A�  ��� �C�
�D L���  �D� "D��C I���C  � 
�D  M����  �� ���	"D�J��  ��G	��  � �F
bD��C ����C  
 J��  �A	��  � F
bD����  ���	�  D� ME�
�D�"D ��
D  J ���  �D�	�  D� M��
�D���  H
A�  �� �EH�D�bD 	D�JD  ����  @
A�  �� ��H�D�
�D L�
��  �� ���"E�J�� ��B��  � �HbE��D�I���D  � 
�D  M�
��  �� ���"E�J���  ��  � �HbE��D �Ą��@������          �   �     �   � &         �?
   signright �������              �?       @   stick �������?
   stickleft    stickright 333333�?	   signleft       �      @	   farmrock �������?ffffff@      �?   farmrocktall ���(\�@   farmrockflat {�G�z@�������?�������?�z�G��?333333@�(\����?R���Q�?�������?)\���(�?�������?      @ffffff�?=
ףp=�?
   fencepost 333333�?�������?   fencepostright        �   �    �   E   \�� �@� ��@�� �@� ���܀ A� AA A��� A����� A���A A����� �CA�A��� A���� A�A� �� A��� �D	AE��� �Dd  	A�A� �� A��� �ED  	A��� �EdA    � 	A���� �ED� �  F��	A��� �ED �  F��	A��
�A �A �� "A�F�� F���  ���A    �� I���F�� F����� ��E��GI���F�� F����I��J  I@��KI�A	 \A�KA� ��	 \A�KA� ��	 \A�F�� F��K��A
 Ɓ�\A�F�� F��K��� \A�F�� F��KA�� \A�F�� F��K����\A�D �  F���� ���@���   ���� @�@�E � \� �E�
�ELF� �E����
��LM
FFM
�D
�E��� ��M���  �
�E�!�  ���  @���  ��^   � 8      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    SetBank 	   farmplot 	   SetBuild    PlayAnimation    full    SetOrientation    ANIM_ORIENTATION 	   OnGround 	   SetLayer    LAYER_BACKGROUND    SetSortOrder       @   AddComponent    inspectable    components    nameoverride 	   FARMPLOT 
   getstatus    grower    level 
   onplantfn    croppoints 	   growrate       $@      4@      >@   max_cycles_left       @   cycles_left    setfertility    decor    SetRotation      �F@   lootdropper 	   workable    SetWorkAction    ACTIONS    HAMMER    SetWorkLeft       @   SetOnFinishCallback    SetOnWorkCallback    pairs    SpawnPrefab 
   SetParent 
   Transform    SetPosition       �?       @   table    insert        �   �        F @ F@� K�� \� Z@  � �A�  ^  ��F @ F@� K � \� Z@  @ �A@ ^   �       components    grower 
   IsFertile    NEEDSFERTILIZER    IsEmpty    GROWING        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst                �   �            @ @@ ��  @� �       SoundEmitter 
   PlaySound    dontstarve/wilson/plant_seeds        �   �   �   �   �   �             inst �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         Sim     �      inst    �      trans    �      anim    �      cycles_per_level E   �      decor_items z   �      (for generator) }   �      (for state) }   �      (for control) }   �      k ~   �   
   item_info ~   �      (for generator) �   �      (for state) �   �      (for control) �   �   
   item_name �   �      item_offsets �   �      (for generator) �   �      (for state) �   �      (for control) �   �      l �   �      offset �   �   
   item_inst �   �         level    croppoints    rates    setfertilityfn    onhammered    onhit    decor_defs 1  P   R   T   T   T   T   T   T   T   T   T   T   T   T   V   V   V   V   W   W   W   W   W   W   X   X   X   X   Y   Y   Z   [   [   \   \   \   \   \   ]   ]   ]   ]   ^   ^   _   `   `   a   a   a   a   a   a   b   b   b   b   b   b   b   c   c   c   c   c   c   d   d   e   f   f   f   f   f   f   f   f   g   g   i   i   i   i   i   i   i   i   i   i   i   l   l   m   m   m   m   m   m   n   n   n   n   n   o   o   p   r   r   r   r   r   r   r   r   r   r   s   s   s   s   s   s   s   s   s   s   v   v   v   v   v   v   v   v   v   v   w   w   w   w   w   w   w   w   w   w   x   x   x   x   x   x   x   x   x   x   {   {   |   |   |   |   |   |   }   }   }   }   }   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         level     0     rock_front    0     decor_defs '  0  	      left    back    right    front    croppoints    rates    setfertilityfn    onhammered    onhit u                                                            	   	   	   	   
                                                      (   -   >   @   B   B   C   C   D   E   E   G   G   H   H   H   H   H   H   H   I   I   I   I   I   I   I   J   J   J   J   J   J   K   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         assets    t      prefabs %   t      back &   t      front '   t      left (   t      right )   t      onhammered *   t      onhit +   t      setfertilityfn ,   t      rates 4   t      croppoints K   t      plot U   t       