LuaQ  o   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\evergreens.lua           (�   
 �E   �@  ��  \���   �@  �  ����   A  A ܀�  AA �� �"@  J ��� �  A A� �� b@�� � �  �@� � � 
�  E� �� �� � \� 	A��	AD��@� $     � $A  @ �� \� � � �� � B ܁ 
� 	�E�	�E�	�Ō	�F�	�F�	�Ǝ	�G�	BH�	�H�	BI�	�I�J��� �� C bB��� �� �B� ��� A� �� �C D �B�$�  d�  �   ��C $� d�   �      �   ��D   �  �   $�   �d�      �   �   ��E       $�   �d� � �F ��D�$ ���$G   ���$�    	����FK�
G 	GE�d� 	G��d   �		G�dG    
	G��	�K�JG IE��� I�����   �
I���    I���I�K�� �L��G �Ǉ��   ������    �Ǉ��F � $G       d�    ��   �� $H       d�   �  �     �  �        �   ��   �      � � I A� ܈� 	 A� �	 ��@	 �I �� \	��   � 6      Asset    ANIM    data/anim/evergreen_new.zip    data/anim/evergreen_all.zip    data/anim/dust_fx.zip    SOUND    data/sound/forest.fsb    log    twigs 	   pinecone 	   charcoal    leif    evergreen_new    pt    Vector3            lev       @   PickRandomBuild    short    tall    normal    idle 	   idle_old    sway1    sway2    chop 	   chop_old 	   fallleft 
   fallright    stump    idle_chop_old    burning 
   idle_olds    burnt    burnt_tall    chop_burnt    chop_burnt_tall    idle_chop_burnt    idle_chop_burnt_tall    name    time    fn    growfn 
   leifscale ffffff�?      �?      �?   old    evergreen_normal        @   evergreen_tall       @   evergreen_short $               	      E   F@� �   �  \� @     �       math    random     	                                        builds     !   /     /   J� �@  �   �� I� ���  �   �� I� ��@ �   �� I� ��� �   �� I� ��@ �   �� I� ��� �   �� I� ��@ �   �� I� ��� �   �� I� ��@ �   �� I� ��� �   �� I� ��@ �   �� I� �^   �       idle    idle_    sway1    sway1_loop_    sway2    sway2_loop_    chop    chop_ 	   fallleft 
   fallleft_ 
   fallright    fallright_    stump    stump_    burning    burning_loop_    burnt    burnt_    chop_burnt    chop_burnt_    idle_chop_burnt    idle_chop_burnt_     /   "   #   #   #   #   $   $   $   $   %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   )   )   )   )   *   *   *   *   +   +   +   +   ,   ,   ,   ,   -   -   -   -   .   /         stage     .           G   J        � @ �@ �@@ ��@��@ �@� �       Remove    components    lootdropper    SpawnLootPrefab    log        H   H   I   I   I   I   I   J         inst           chopper                L   Y     )   � @ A  �@���@ ��@ �@���@ ��@A �@���A ��AB AB�@���B ��B�@ � C A d      �@ ��C ��C� DA �@���C ��C��D�@ ��D �   � ���D � E�@ 	@ŉ �       RemoveComponent 	   workable    SoundEmitter 
   PlaySound    dontstarve/forest/treeCrumble    dontstarve/wilson/use_axe_tree 
   AnimState    PlayAnimation    anims    chop_burnt    Physics    ClearCollisionMask    ListenForEvent 	   animover    components    lootdropper    SpawnLootPrefab 	   charcoal 	   DropLoot    pineconetask    Cancel         R   R            @ @  �       Remove        R   R   R   R             inst )   M   M   M   N   N   N   N   O   O   O   O   P   P   P   P   P   Q   Q   Q   R   R   R   R   R   S   S   S   S   S   T   T   T   T   U   U   U   V   V   V   W   Y         inst     (      chopper     (           \   s       K @ �@  $         \@ F�@ K�� � A �@�� \@ F�@ K�� � � \@�K�A �@ \@� �       DoTaskInTime       �?
   AnimState    PlayAnimation    anims    burnt    SetRayTestOnBB    AddTag        ^   n     ;       @ @@     �    @ @@ �@ @    �@ �@  @�   �@ �  @�   �@ �@ @�    @ �A �A �   @�    @ �A  B �@ �� @     @ �B    @�    @ �B  C �@ @�    @ �B �C �  @�    @ �B �C � � @� �       components 	   burnable    Extinguish    RemoveComponent    propagator 	   growable    lootdropper    SetLoot    AddChanceLoot 	   pinecone �������?	   workable    SetWorkLeft       �?   SetOnWorkCallback    SetOnFinishCallback     ;   _   _   _   _   _   `   `   `   `   `   b   b   b   b   c   c   c   c   d   d   d   d   f   f   f   f   f   f   g   g   g   g   g   g   g   i   i   i   i   i   j   j   j   j   j   j   k   k   k   k   k   k   l   l   l   l   l   l   n             inst    chop_down_burnt_tree    ]   ]   n   n   n   ]   p   p   p   p   p   p   q   q   q   q   r   r   r   s         inst              chop_down_burnt_tree     u   {        E   F@� \�� @ ���F�@ K � �@A ƀ�� \@ @�F�@ K � �@A ���� \@  �       math    random       �?
   AnimState    PushAnimation    anims    sway1    sway2        v   v   v   v   v   w   w   w   w   w   w   w   y   y   y   y   y   y   {         inst                }   �        E   F@� \�� @ ���F�@ K � �@A ƀ�� \@ @�F�@ K � �@A ���� \@  �       math    random       �?
   AnimState    PlayAnimation    anims    sway1    sway2        ~   ~   ~   ~   ~                        �   �   �   �   �   �   �         inst                �   �       D   	@ �F@@ F�� Z   @�F@@ F�� K�� �  �@�\@�F@@ F�� K�� � � \@�D  �   \@  �       anims    components 	   workable    SetWorkLeft    TUNING    EVERGREEN_CHOPS_SMALL    lootdropper    SetLoot        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst              short_anims    short_loot    Sway     �   �       F @ K@� ��  \@�F�@ K � �@ \@�D   �   \@  �    
   AnimState    PlayAnimation    grow_old_to_short    SoundEmitter 
   PlaySound #   dontstarve/forest/treeGrowFromWilt        �   �   �   �   �   �   �   �   �   �   �   �         inst           	   PushSway     �   �       D   	@ �F@@ F�� Z   @�F@@ F�� K�� �  �@�\@�F@@ F�� K�� � � \@�D  �   \@  �       anims    components 	   workable    SetWorkLeft    TUNING    EVERGREEN_CHOPS_NORMAL    lootdropper    SetLoot        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst              normal_anims    normal_loot    Sway     �   �       F @ K@� ��  \@�F�@ K � �@ \@�D   �   \@  �    
   AnimState    PlayAnimation    grow_short_to_normal    SoundEmitter 
   PlaySound    dontstarve/forest/treeGrow        �   �   �   �   �   �   �   �   �   �   �   �         inst           	   PushSway     �   �       D   	@ �F@@ F�� Z   @�F@@ F�� K�� �  �@�\@�F@@ F�� K�� � � \@�D  �   \@  �       anims    components 	   workable    SetWorkLeft    TUNING    EVERGREEN_CHOPS_TALL    lootdropper    SetLoot        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst              tall_anims 
   tall_loot    Sway     �   �       F @ K@� ��  \@�F�@ K � �@ \@�D   �   \@  �    
   AnimState    PlayAnimation    grow_normal_to_tall    SoundEmitter 
   PlaySound    dontstarve/forest/treeGrow        �   �   �   �   �   �   �   �   �   �   �   �         inst           	   PushSway     �   �       D   	@ �F@@ F�� Z    �F@@ F�� K�� �  \@�F@@ F@� K�� � � � �@� \@�D � �   \@  �       anims    components 	   workable    SetWorkLeft       �?   lootdropper    SetLoot 	   pinecone        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst           
   old_anims    Sway     �   �       F @ K@� ��  \@�F�@ K � �@ \@�D   �   \@  �    
   AnimState    PlayAnimation    grow_tall_to_old    SoundEmitter 
   PlaySound    dontstarve/forest/treeWilt        �   �   �   �   �   �   �   �   �   �   �   �         inst           	   PushSway     �   �        K @ �@  \��Z   � �A�  ^  ��K @ ��  \��Z   @ �A  ^   �       HasTag    burnt    BURNT    stump    CHOPPED        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         inst                �   �        E   �@  ��@��@� A�@  ƀ�����@�] �^    �       GetRandomWithVariance    TUNING    EVERGREEN_GROW_TIME       �?   base    random        �   �   �   �   �   �   �   �   �   �   �   �         inst                �   �       D   �   \@  �            �   �   �   �         inst           	   SetShort     �   �       D   �   \@  �            �   �   �   �         inst           
   GrowShort     �   �        E   �@  ��@��@� A�@  ƀ�����@�] �^    �       GetRandomWithVariance    TUNING    EVERGREEN_GROW_TIME        @   base    random        �   �   �   �   �   �   �   �   �   �   �   �         inst                �   �       D   �   \@  �            �   �   �   �         inst           
   SetNormal     �   �       D   �   \@  �            �   �   �   �         inst              GrowNormal     �   �        E   �@  ��@��@� A�@  ƀ�����@�] �^    �       GetRandomWithVariance    TUNING    EVERGREEN_GROW_TIME       @   base    random        �   �   �   �   �   �   �   �   �   �   �   �         inst                �   �       D   �   \@  �            �   �   �   �         inst              SetTall     �   �       D   �   \@  �            �   �   �   �         inst           	   GrowTall     �   �        E   �@  ��@��@� A�@  ƀ�����@�] �^    �       GetRandomWithVariance    TUNING    EVERGREEN_GROW_TIME       @   base    random        �   �   �   �   �   �   �   �   �   �   �   �         inst                �   �       D   �   \@  �            �   �   �   �         inst              SetOld     �   �       D   �   \@  �            �   �   �   �         inst              GrowOld     �   �     9   � @ �@�A�  �@���@ � �FAA F���@���@ ���FAA F��� �@ �@ �B �B ܀   AC�������EB F���� �� �B� ��E � \���B���E�  @��B���E��E�� �  � ��B���E�F�B �B��BF��F � �B�a�  �� �       SoundEmitter 
   PlaySound    dontstarve/wilson/use_axe_tree 
   AnimState    PlayAnimation    anims    chop    PushAnimation    sway1    Vector3 
   Transform    GetWorldPosition    TheSim    FindEntities    x    y    z    TUNING    LEIF_REAWAKEN_RADIUS    leif    pairs    components    sleeper 	   IsAsleep    WakeUp    combat    SuggestTarget     9   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
      inst     8      chopper     8      chops     8      pt    8      ents    8      (for generator) "   8      (for state) "   8      (for control) "   8      k #   6      v #   6           �   8   �   � @ A  �@�� @ �  �@�� @ �  �@�� A �@A� �@��� � B �@��  ��  �� � AB ܀  ���B�� �C� �  X ��  �A  �   @�F�C K���D �A�\A�F�D F��K��� ��܁ ��\A� �F�C K���D �A�\A�F�D F��K��� ��܁ ��\A�F�E K��\A F�C K��D �A�\A�K�F ��  \A�F�D F��K��� �A�\A�F�D F��K���  \A�F�D F��K��� \A�KAH �A \A�F�D F��Z  � �F�D F��K��\A E	 F��FA�F����	 �J@ ��A
 ��J��� ��	 ����@
�� @�@��A
 Ɓ�B ܁ ����@� ��A
 Ɓ�� ܁ ���   A ���    E�	 FC��  ܂ �  ����L���C
 ��J��� ��K����C    � �   � C �  �A� � 5      RemoveComponent 	   burnable    propagator 	   workable    SoundEmitter 
   PlaySound    dontstarve/forest/treefall    Vector3 
   Transform    GetWorldPosition    Dot 
   TheCamera    GetRightVec         
   AnimState    PlayAnimation    anims 	   fallleft    components    lootdropper 	   DropLoot 
   fallright    Physics    ClearCollisionMask    PushAnimation    stump    AddComponent    SetWorkAction    ACTIONS    DIG    SetOnFinishCallback    SetWorkLeft       �?   AddTag 	   growable    StopGrowing    TheGlobalInstance    clock 
   numcycles    TUNING    LEIF_MIN_DAY    math    random    LEIF_PERCENT_CHANCE       >@       @      T@      @   FindEntity    LEIF_MAXSPAWNDIST    noleif    DoTaskInTime              !   F @ F@� Z   @�F @ F@� F�� ��  �K A �@ \��Z   ��K A �� \��Z@  ��K A �� \��Z@  � �F B S � @ �B@  B � ^  B   ^   � 	      components 	   growable    stage       @   HasTag    tree    stump    burnt    noleif     !                                                                           item                   3    R      E   �@  \� � � ƀ@ ���� ��� �@A�@    ��� ��A � ��@��� �A�O����Bς��B�A Ɓ� ����� �BC� ��Ɓ� �A��� BC�C� ��Ɓ� ����� �CD� ��Ɓ� ����� �CBD� ���Ɓ� �A��� BC�D� ����� ��@ � � �A�Ɓ� �A��A�D �A�Ɓ� ���A �A��AF �A ��� ˁ�F�D K��\ �A   �       SpawnPrefab    leif    components 	   growable    stage 
   leifscale       �?
   AnimState    GetMultColour    SetMultColour      �o@
   locomotor 
   walkspeed    combat    defaultdamage    health 
   maxhealth    currenthealth    range 
   Transform 	   SetScale    SuggestTarget    sg 
   GoToState    spawn    Remove    SetPosition    GetWorldPosition     R      !  !  !  "  "  "  "  "  "  "  "  "  #  #  #  $  $  $  $  $  $  $  '  '  '  '  '  '  '  (  (  (  (  (  (  (  )  )  )  )  )  )  )  *  *  *  *  *  *  *  +  +  +  +  +  +  +  -  -  -  -  -  -  .  .  .  .  .  /  /  /  /  0  0  2  2  2  2  2  2  3        target    Q      leif    Q      scale    Q      r    Q      g    Q      b    Q      a    Q         target    growth_stages    chopper �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                          	  	  	  	  
  
  
  
  
  
  
                                                                        3  3  3  3    4    8        inst     �      chopper     �      pt    �      hispos    �   	   he_right !   �      days_survived h   �   	   numleifs t   �      (for index) �   �      (for limit) �   �      (for step) �   �      k �   �      target �   �         dig_up_stump    growth_stages     :  G   
   D   �   \@ K@@ ��  $      \� 	@ � �       pineconetask    DoTaskInTime       $@       =  F          D   F@� K�� \  �  E�  F � �@ �� \����  �E� K � \� @  � �E� K � \� @  D   F@� F�� K�� �   \@�D   I@C� �       Vector3 
   Transform    GetWorldPosition    math    random               �?
   TheCamera    GetRightVec    components    lootdropper 	   DropLoot    pineconetask         >  >  >  >  >  >  ?  ?  ?  ?  ?  ?  ?  @  @  @  @  @  B  B  B  B  D  D  D  D  D  D  E  E  F        pt             inst 
   ;  ;  ;  <  <  F  F  <  F  G        inst     	         OnBurnt     K  P      � @ �@@��@�  �@�� A �@A� �@���A � BA �@��   �   �@  � 
      components 	   growable 	   SetStage       �?
   AnimState    PlayAnimation    grow_seed_to_short    SoundEmitter 
   PlaySound    dontstarve/wilson/plant_tree        L  L  L  L  L  M  M  M  M  N  N  N  N  O  O  O  P        inst           data           	   PushSway     R  Z       � @ A  ����@   �� @ �  ����     �I���� @  ����     �I�@� �       HasTag    burnt    fire    stump        S  S  S  S  S  S  S  S  S  S  T  W  W  W  W  W  X  Z        inst           data                \  n   :   � � �   � ��   �   �@ @��@� �   ����@ �  �@���@  �@���@ A �@���@ � �@���A � B�@ ��A �@B� �B�@�� C �@C�C A@�@���C A  �@�� D �  �@��@D ��@��D� E�@��@D ��@�@E� �@��@D ��@��E� �@� �       burnt    stump    RemoveComponent 	   workable 	   burnable    propagator 	   growable    Physics    ClearCollisionMask    CollidesWith 
   COLLISION    WORLD 
   AnimState    PlayAnimation    anims    AddTag    AddComponent    components    SetWorkAction    ACTIONS    DIG    SetOnFinishCallback    SetWorkLeft       �?    :   ]  ]  ]  ^  ^  ^  ^  _  _  _  `  `  `  a  a  a  b  b  b  c  c  c  d  d  d  e  e  e  e  e  f  f  f  f  f  g  g  g  i  i  i  j  j  j  j  j  j  k  k  k  k  k  l  l  l  l  l  n        inst     9      data     9         OnBurnt    dig_up_stump     p  �  	    d   �@      �    �   �       �  �   �            q  |    	   E   \�� �@� ��@�� �@� ���܀ A� A� KA��� \A�K��� \A�KA��� � \A ^   �       CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter 	   SetBuild    evergreen_new    SetBank    evergreen_short    PlayAnimation    idle_short        r  r  s  s  s  t  t  t  v  v  v  x  x  x  y  y  y  z  z  z  z  {  |        Sim           inst          trans          anim          sound               ~  �  
 ~   E   \�� �@� ��@�� �@� ���܀ A� A� EA �� �� \A�K�� � \A�K�� �A \A�E� \�� ��� ��A���B �A��� ��C��� �D����A�@ � � � �A ��  � �A �� AB �A�Ɓ� �A��ƋƁ� �A�  ����� AB �A�Ɓ� �A�ˁ�E� F��A�Ɓ� �A��A�D� �A�Ɓ� �A�ˁ�D �A��� A� �A��� A �A�Ɓ� ���A�D��A�Ɓ� ����H�Ɓ� �� ���� AB	 �A�Ɓ� �A����Ɓ� �A����D �A�Ɓ� �A��AJ�Ɓ� �A�ˁ��A ��� A ���A �A� ˁ�E� F��\�� N���A�� I����I���^   � 2      CreateEntity    entity    AddTransform    AddAnimState    AddSoundEmitter    MakeObstaclePhysics       �?   AddTag    tree 	   workable    PickRandomBuild 	   SetBuild    SetBank    evergreen_short    math    random       �?   SetMultColour       �?   MakeLargePropagator    AddComponent    inspectable    components    nameoverride 
   EVERGREEN 
   getstatus    SetWorkAction    ACTIONS    CHOP    SetOnWorkCallback    SetOnFinishCallback    lootdropper 	   burnable    SetBurntCallback 	   burntime       $@   fxdata 	   growable    stages 	   SetStage    loopstages    StartGrowing    ListenForEvent    growfromseed 
   AnimState    SetTime        @   OnSave    OnLoad     ~       �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �        Sim     }      inst    }      trans    }      anim    }      sound    }      build    }      color "   }   
      inspect_tree 
   chop_tree    chop_down_tree    tree_burnt    burnfxdata    growth_stages    stage    handler_growfromseed    onsave    onload    |  �  �  �  �  �  �  �  �  �  �  �  �  �        stage           fn2          fn       	      inspect_tree 
   chop_tree    chop_down_tree    tree_burnt    burnfxdata    growth_stages    handler_growfromseed    onsave    onload     �  �      �   �@     � �  @� � D� � � ��    �       Prefab    forest/objects/trees/        �  �  �  �  �  �  �  �  �  �  �  �        name           stage              makefn    assets    prefabs �                                                         	                                                                     /   1   1   1   2   2   2   3   3   3   4   6   7   8   9   :   ;   <   =   >   ?   @   C   C   C   C   C   D   D   D   E   E   E   E   E   E   E   J   Y   s   s   {   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   8  8  8  G  G  P  P  Z  n  n  n  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  #      assets    �      prefabs    �      builds    �      burnfxdata &   �   
   makeanims *   �      short_anims -   �      tall_anims 0   �      normal_anims 3   �   
   old_anims ?   �      normal_loot D   �      short_loot G   �   
   tall_loot N   �      dig_up_stump O   �      chop_down_burnt_tree P   �      OnBurnt R   �   	   PushSway S   �      Sway T   �   	   SetShort X   �   
   GrowShort Z   �   
   SetNormal ^   �      GrowNormal `   �      SetTall d   �   	   GrowTall f   �      SetOld i   �      GrowOld k   �      inspect_tree l   �      growth_stages �   �   
   chop_tree �   �      chop_down_tree �   �      tree_burnt �   �      handler_growfromseed �   �      onsave �   �      onload �   �      makefn �   �      tree �   �       