LuaQ  m   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\prefabs\pinecone.lua           *      A@  @ 
  E  ΐ  Α  \  Α@   "@  J    Ε  A AA A ά ΐΐBb@ €   δ@  $          E A ΐ    \  ΑΑ  AB  ^          require    prefabutil    Asset    ANIM    data/anim/pinecone.zip    IMAGE "   data/inventoryimages/pinecone.tex    pt    Vector3            lev       @   Prefab    common/inventory/pinecone    MakePlacer    common/pinecone_placer    evergreen_short    evergreen_new    idle_short        
   *     P      Α@      Ζ@ΛΐΐFΑ AΑ ΖΑ ά@ΛΐAA ά@Ζ@B ΖΒΛΐΒά Λ Γά@ Ε@ ΛΓFΑ AΑ ΖΑ Β DJ B bB ά  E \ 
Β ΒDΕ   EC ΐE \  ά  Γ ΓEEΓ FΓΕC @ ΕΒ ΖΕB ΖΖά @ΖBΒΖΒΖΪ   ΖBΒΖΒΖΛΗAC άBA   ΖΗΛΒΗA άB a   υ  !      SpawnPrefab    evergreen_short 
   Transform    SetPosition    x    y    z 
   PushEvent    growfromseed    components 
   stackable    Get    Remove    TheSim    FindEntities    TUNING    LEIF_PINECONE_CHILL_RADIUS    leif    pairs    LEIF_PINECONE_CHILL_CHANCE_FAR    distsq    Vector3    GetWorldPosition !   LEIF_PINECONE_CHILL_CLOSE_RADIUS !   LEIF_PINECONE_CHILL_CHANCE_CLOSE    math    random    sleeper 
   GoToSleep      @@   SoundEmitter 
   PlaySound #   dontstarve/creatures/leif/taunt_VO     P                                                                                                                                                                                                                      "   "   #   #   #   #   $      &   *         inst     O      pt     O      tree    O      ents    O      played_sound     O      (for generator) #   O      (for state) #   O      (for control) #   O      k $   M      v $   M      chill_chance &   M           ,   @     G      ΐ   Ε@  ΖΐWΐ ΐΕ@  ΖΐΐWΐ ΐ Ε@  Ζ Αΐ   Β@  Β  Ϊ    A AΑΑ ΖΒ BΒ A  EΑ  \@W ΐΓBC   ΓC   @ΒΓ B   BΔ  @ ΕΒ  FCΕKΕ\   @ ά @ Β  ή a  ΐφB ^            GetGroundTypeAtPosition    GROUND    ROCKY    ROAD    IMPASSABLE    TheSim    FindEntities    x    y    z       @   pairs    entity    IsValid 
   IsVisible    HasTag    player    Physics        @   distsq    Vector3 
   Transform    GetWorldPosition     G   -   -   -   .   .   .   .   .   .   .   .   .   .   .   .   .   .   0   0   1   1   1   1   1   1   1   3   3   3   3   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   5   5   5   6   7   7   7   7   7   7   7   7   7   7   7   8   8   3   ;   =   =   ?   ?   @         inst     F      pt     F   	   tiletype    F   
   ground_OK    F      ents    D      (for generator)    B      (for state)    B      (for control)    B      k    @      v    @      min_spacing 3   @           C   e    O   E   \ @ΐ @@ @ΐ ΐ@@   ΐ  @ @Α AΑ @@Α  BΑ @@Α @B @ΐΒ  @@Γ  CΕΐ Ζ Δΐ ΐΒ A @ΐΒ  @@Γ DΕΐ Ζ ΕΐΐΒ A @@Γ @EΐE@Γ @EΔ   ΐ @ ΐ  @ ΐΒ  @ΐΒ Α @@Γ ΐFΕΐ Ζ@Ηΐ ΐΒ  @@Γ GΔ  ΐ@Γ GΔ  ΐ ^    !      CreateEntity    entity    AddTransform    AddAnimState    MakeInventoryPhysics 
   AnimState    SetBank 	   pinecone 	   SetBuild    PlayAnimation    idle    AddComponent 
   stackable    components    maxsize    TUNING    STACK_SIZE_SMALLITEM    inspectable    fuel 
   fuelvalue    SMALL_FUEL 	   burnable 	   burntime       @   fxdata    MakeSmallPropagator    inventoryitem    researchvalue 
   basevalue    RESEARCH_VALUE_BASE    deployable    test 	   ondeploy     O   D   D   E   E   E   F   F   F   G   G   G   I   I   I   I   J   J   J   J   K   K   K   K   M   M   M   N   N   N   N   N   P   P   P   R   R   R   S   S   S   S   S   U   U   U   V   V   V   W   W   W   W   X   X   X   Z   Z   Z   [   [   [   \   \   \   \   \   _   _   _   `   `   `   `   a   a   a   a   d   e         Sim     N      inst    N         burnfxdata    test_ground 	   ondeploy *                                                                        *   @   e   e   e   e   g   g   g   g   g   h   h   h   h   h   h   h   h         assets    )      burnfxdata    )   	   ondeploy    )      test_ground    )      fn    )       