LuaQ  g   @c:\jenkins\workspace\jobs\DontStarve_Release_Make_Steam_Package\workspace\data\scripts\stategraph.lua           z      A@  @ À  d             d@  	@  d  	@   dÀ  	@  d  	@   d@ 	@  d 	@   dÀ 	@  d  	@   d@ 	@  d 	@   dÀ 	@À  d     À  d@  @ À  d   À  dÀ  À À d  	@ À  d@  @ @ d 	@ À  dÀ  À À d  	@ À d@ 	@ À d 	@À dÀ 	@ À d  	@À d@ 	@ À d 	@À dÀ 	@ À d  	@À d@ 	@ À d 	@À dÀ 	@ À d  	@À d@ 	@ À d 	@À dÀ 	@  &      require    class    StateGraphWrangler    Class 
   SGManager    SendToList    OnEnterNewState    OnSetTimeout    OnPushEvent 
   Hibernate    Wake    Sleep    OnRemoveEntity    RemoveInstance    AddInstance    Update    ActionHandler    EventHandler 
   TimeEvent    State    HandleEvent    StateGraph    __tostring    StateGraphInstance    GetTimeInState    PlayRandomAnim 
   PushEvent    IsListeningForEvent    StartAction    HandleEvents 
   GoToState    AddStateTag    RemoveStateTag    HasStateTag    SetTimeout    UpdateState    Start    Stop $          	        J   	@ J   	@J   	@ J   	@J   	@      
   instances 	   updaters    tickwaiters    hibernaters    haveEvents                                      	         self     
                      Æ @ Æ@Ú     É@À @ 	      À      
   instances                                                self     
      inst     
      list     
   	   old_list    
                    	    @ @    À @@   F@ @      
   instances    SendToList 	   updaters     	                                     self           inst                "   &     	    @ @    À @@   F@ @      
   instances    SendToList 	   updaters     	   #   #   #   #   $   $   $   $   &         self           inst                (   ,         @ @    @ @@ À      
   instances    haveEvents        )   )   )   )   *   *   ,         self           inst                .   2     	    @ @    À @@   F@ @      
   instances    SendToList    hibernaters     	   /   /   /   /   0   0   0   0   2         self           inst                4   8     	    @ @    À @@   F@ @      
   instances    SendToList 	   updaters     	   5   5   5   5   6   6   6   6   8         self           inst                :   H     
   Æ @ Æ@Ú    Å@  Ü ÏÀ À  ÁÀ   AAE \ LÁ Á@FÁA FZA  À   @ ÁA AB   @A   	   
   instances    GetTickTime               ð?   math    floor    GetTick    tickwaiters    SendToList        ;   ;   ;   ;   <   <   <   =   =   =   ?   ?   ?   ?   ?   ?   ?   @   @   B   B   C   C   D   D   F   F   F   F   H         self           inst           time_to_wait           sleep_ticks          target_tick          waiters               K   S     
      Æ@@  ÆÀ@À ËÁ@ @ÜA  ¡  ý        pairs 
   instances    inst    RemoveInstance        M   M   M   M   N   N   N   O   O   O   P   M   Q   S         self           inst           (for generator)          (for state)          (for control)          k          v               U   X         @   C@ @@ À         SendToList    haveEvents         V   V   V   V   W   W   X         self           inst                Z   \         @   FA@ @         SendToList 	   updaters        [   [   [   [   \         self           inst                ^        9    @ @    @Å@    Ü @ @ 	Â@á  ÀþÆ @ É Á Æ@ 
  	 A  @@FBÁKÁ\ Z   KÂÁ\ Z  @@ BB  @B @@ ÂÀ B  B!  ÀùÁB J  	@EA   \@ CB a  Àþ        tickwaiters    pairs 	   updaters     inst    IsValid    Update            Sleep 
   Hibernate    haveEvents    HandleEvents     9   `   `   a   a   b   b   b   b   c   c   b   c   e   e   h   i   i   k   k   k   k   l   l   l   l   l   m   m   o   o   p   p   q   q   q   q   q   s   s   t   v   v   v   k   x   }   ~   ~                                    self     8      current_tick     8      waiters    8      (for generator)          (for state)          (for control)          k    
      v    
   	   updaters    8      (for generator)    -      (for state)    -      (for control)    -      k    +      v    +      sleep_amount    +      evs .   8      (for generator) 3   8      (for state) 3   8      (for control) 3   8      k 4   6      v 4   6                      	@ A  @  @À $     	   		À         action    type    string 
   deststate 
   condition                  D   ^                              inst              state                                                 self           action           state        
   condition                        %   Å   Æ@À  AÁ  ÜA AAÁ ÂÆAÂ 	  EÁ  \ W@Á  BA  B A  EÁ  \ W Ã  BA  B A A C@  	 	        debug    getinfo       @   Sl    defline    string    format    %s:%d 
   short_src    currentline    assert    type 	   function    name    lower    fn     %                                                                                                                        self     $      name     $      fn     $      info    $              ¥     !   Å   Æ@À  AÁ  ÜA AAÁ ÂÆAÂ 	  EÁ  \ W Ã  BA  B A  EÁ  \ W@Ã  BA  B A 	@ 	        debug    getinfo       @   Sl    defline    string    format    %s:%d 
   short_src    currentline    assert    type    number 	   function    time    fn     !                                              ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¢   ¢   ¢   ¢   ¢   ¢   ¢   ¢   ¢   £   ¤   ¥         self            time            fn            info                ¨   Ï     X      @@Á  Á  Å@ ÆÁÁ FBABÜ 	À Å ÁÂ A Ü@ÆÀÂ 	ÀÆ@Ã 	ÀÆÃ 	À ÆÀÃ 	ÀÆ Ä 	À Ê   	ÀÆ@Ä Ú   ÀÅ AÄ Ü @ BD 	ÂÄá  ÀþÊ   	À Æ Å W@ÅÅ Å Ü   KÂÅÅ \B BE FÂÂ	Âá   ýÊ   	À ÆÆ W@Å Å Æ Ü  KÂÅÅÂ \ BB GFF Bá  üä   A ÁGFF A         debug    getinfo       @   Sl    defline    string    format    %s:%d 
   short_src    currentline    assert    name    State needs name    onenter    onexit 	   onupdate 
   ontimeout    tags    ipairs    events     pairs    is_a    EventHandler    non-EventHandler in event list 	   timeline 
   TimeEvent    non-TimeEvent in timeline    table    insert    sort        Ê   Ì         @ Æ À XÀ   @              time        Ë   Ë   Ë   Ë   Ë   Ë   Ë   Ì         a           b            X   ©   ©   ©   ©   ©   ª   ª   ª   ª   ª   ª   ª   ¬   ¬   ¬   ¬   ­   ­   ®   ®   ¯   ¯   °   °   ±   ±   ³   ³   ´   ´   ´   µ   µ   µ   µ   ¶   ¶   µ   ¶   º   º   »   »   »   ¼   ¼   ¼   ¼   ½   ½   ½   ½   ½   ½   ¾   ¾   ¾   ¼   ¾   Â   Â   Ã   Ã   Ã   Ä   Ä   Ä   Ä   Å   Å   Å   Å   Å   Å   Æ   Æ   Æ   Æ   Æ   Ä   Æ   Ì   Í   Í   Í   Í   Í   Ï         self     W      args     W      info    W      (for generator) "   '      (for state) "   '      (for control) "   '      k #   %      v #   %      (for generator) /   ;      (for state) /   ;      (for control) /   ;      k 0   9      v 0   9      (for generator) C   Q      (for state) C   Q      (for control) C   Q      k D   O      v D   O      pred R   W           Ò   Ú        Ú   À  À ÀFA@ @ @  WÀ@ FAAÁ À]^             state    name    events     fn    inst        Ó   Ó   Ó   Ó   Ó   Ó   Ó   Ó   Ó   Ô   Ô   Õ   Õ   Ö   Ö   Ö   Ö   Ö   Ù   Ù   Ú         self           sg        
   eventname           data           handler               ß   ü     Q     Û ÅA    Ü WÀ  ÂA  Â Â  A AAÁ Â Å  ÆAÂ FÂBCÜ 	À	@	 	 Ê  	ÀZ  ÅA  Ü   KÄÅÃ \ CD FCÅ	Ãá   ýÊ  	ÀÅA  Ü   KÄÅÃ \ CE FCÃ	Ãá   ýÊ  	ÀÅA   Ü   KÄÅC \ CC FCÃ	Ãá   ý        assert    type    string ,   You must specify a name for this stategraph    debug    getinfo       @   Sl    defline    format    %s:%d 
   short_src    currentline    name    states    defaultstate    actionhandlers    pairs    is_a    ActionHandler 1   Non-action handler added in actionhandler table!    action    events    EventHandler !   Non-event added in events table!    State     Non-state added in state table!     Q   à   à   à   à   à   à   à   à   à   à   à   à   á   á   á   á   á   â   â   â   â   â   â   â   ã   ä   å   ç   ç   è   è   é   é   é   é   ê   ê   ê   ê   ê   ê   ë   ë   ë   é   ë   ð   ð   ñ   ñ   ñ   ñ   ò   ò   ò   ò   ò   ò   ó   ó   ó   ñ   ó   ö   ö   ÷   ÷   ÷   ÷   ø   ø   ø   ø   ø   ø   ù   ù   ù   ÷   ù   ü         self     P      name     P      states     P      events     P      defaultstate     P      actionhandlers     P      info    P      (for generator) "   .      (for state) "   .      (for control) "   .      k #   ,      v #   ,      (for generator) 3   ?      (for state) 3   ?      (for control) 3   ?      k 4   =      v 4   =      (for generator) D   P      (for state) D   P      (for control) D   P      k E   N      v E   N           þ           A   @@ U ^          Stategraph :     name        ÿ   ÿ   ÿ   ÿ            self                         	@ 	À	 Á	 Á	@	ÀÊ   	À 	Ê   	À 	 Á        sg    currentstate     timeinstate            lastupdatetime    timelineindex 
   prevstate    bufferedevents    inst 	   statemem    statestarttime                  	  
  
                  self           stategraph           inst                      
    E   F@À   ÆÀ@ Æ ÁAA AE \ ÁA M\  Á  UÀ @ ÆB  @À Â @ A U@¡  Àý  Á@ UÀ ^          string    format     sg="%s", state="%s", time=%2.2f    sg    name    currentstate    GetTime    statestarttime    , tags = "    pairs    tags 	   tostring    ,    "                                                                               self           str          (for generator)          (for state)          (for control)          k          v                        E   \ @@ M ^          GetTime    statestarttime                          self                  !       Å   Æ@À  @ T AÜ Á@ AAAÁ À A         math    floor    random    inst 
   AnimState    PlayAnimation       ð?                                            !        self           anims           loop           idx               #  *          À Æ@@ ÆÀÀ  Ê@  A@ @É  ÅÀ  Æ ÁAA J  IA I Ü@        state    currentstate    name    table    insert    bufferedevents    data        $  $  %  %  %  %  '  '  '  '  '  )  )  )  )  )  )  )  *        self           event           data                ,  .        @ @@@ @@À@ @@@ @  @              currentstate    events     sg        -  -  -  -  -  -  -  -  -  -  -  -  -  .        self           event                1  E    '    @ @@   @ @ @@ÆÀ À    ÀÆÀ@Ú    ÆÀ@A Ü Ú   ÀÆ@AÚ   ÀÆ@AA @ ÜÚ   À A A    Æ A ËÀÁÜ@ Â  Þ          sg    actionhandlers    action 
   condition    inst 
   deststate 
   GoToState    PerformBufferedAction     '   2  2  2  2  3  3  3  3  4  4  5  5  5  5  5  5  5  5  6  6  6  7  7  7  7  8  8  9  9  9  9  ;  <  >  >  >  A  A  E        self     &      bufferedaction     &      handler    &      state                G  S    #   E   @@ @  @    ÁÀ  \@E  @A \ @A@ A   FÂÁÂA  @AB BÆÁÁÁW@À ÆÁBC FÂÜAa  ÀúJ   	@        assert    currentstate     we are not in a state!    ipairs    bufferedevents    HandleEvent    name    data    sg    events    fn    inst     #   H  H  H  H  H  H  H  H  I  I  I  I  J  J  J  J  J  J  J  J  K  K  K  K  L  L  M  M  M  M  I  O  R  R  S        self     "      (for generator)           (for state)           (for control)           k          event          handler               V  {    L   Æ @ Æ@ÀÆ@  ÀÀ  BA  B  ÅA @ AÜ Â EB  \ AAAB 	 AB WÀ@ÀAB BWÀ@À AB BFÁB A 
  	 
  	 AÃ  À FAÃ@ FBC IÂÃ!  Àþ	À@	À	ÄAB ÁDWÀ@@ 	@E  	À@AB EWÀ@ AB EFÁB  A  	 ÁE 	  ÁF  A        sg    states    assert     State not found:  	   tostring    name    . 
   prevstate    currentstate    onexit    inst 	   statemem    tags    pairs    timeout    timeinstate         	   timeline    timelineindex       ð?   onenter    lastupdatetime    GetTime    statestarttime 
   SGManager    OnEnterNewState     L   W  W  W  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  Z  Z  [  [  [  [  [  [  [  \  \  \  \  _  _  `  `  a  a  a  b  b  b  b  c  c  b  c  f  g  h  j  j  j  j  k  k  m  q  q  q  q  r  r  r  r  r  w  w  w  x  x  y  y  y  y  {  	      self     K   
   statename     K      params     K      state    K      (for generator) *   /      (for state) *   /      (for control) *   /      i +   -      k +   -           }          @ @À         tags        ~  ~          self           tag                          @ @À         tags                     self           tag                          @    @ @ @ W@@  @              tags                                    self     
      tag     
                       @@   @	@      
   SGManager    OnSetTimeout    timeout                          self           time                  º    	]    @ @      @@ @ 	 @ Æ@ Ú   Æ@ Í@	À Æ@ ÀÀ 	 AÆ @ Æ@ÁÚ   ÀÆ @ Æ@ÁA Ü@ Æ @ WÀ     ÆÀA Ú   @Æ @ Æ ÂÁA Æ Ú   À
Æ @ Æ ÂÁA Æ Æ@ÂA@  ÀÆÀA ÁA B	 ÁA F@ FÂT   	 ÁA@ FA@ @ BÁ ABM@ BÁ ÁBÆA A @  A@   ôC  AA  òÆ @ ÆÃW Á Æ @ ÆÃA @ Ü@        currentstate    timeinstate    timeout ¡? 
   ontimeout    inst    timelineindex 	   timeline    time       ð?   fn    Update         	   onupdate     ]                                                               ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¤  ¦  §  §  §  ¨  ¨  ¨  ¨  ¨  ¨  ©  ¬  ­  ­  ­  ­  ­  ­  ®  ®  ®  ®  ®  ®  ±  ±  ±  ±  ±  ±  ²  ²  ²  ³  ³  ´  ·  ·  ·  ·  ¸  ¸  ¸  ¸  ¸  º        self     \      dt     \      startstate    \      idx 0   R   	   old_time ;   R      extra_time A   R           ¼  Â       F @ Z   @ K @ \@ 	ÀEÀ  K Á À   \@        OnStart    stopped  
   SGManager    AddInstance        ½  ½  ½  ¾  ¾  À  Á  Á  Á  Á  Â        self     
           Ä  Ë       K @ \@ F@@ Z   @ K@@ \@ 	À@E  K@Á À   \@        HandleEvents    OnStop    stopped 
   SGManager    RemoveInstance        Å  Å  Æ  Æ  Æ  Ç  Ç  É  Ê  Ê  Ê  Ê  Ë        self                Í  é    :   A   @@    À    Æ@@ MÀ    	À@   @  Æ A Ú    Æ@A ÆÁÚ    Æ@A ÆÁA Æ Ú   Æ@A ÆÁA Æ ÆÀÁB  Æ@B Ú   @    Æ@B   @B Æ@A ÆÂÚ    Á   Þ  @   @   @ Ã Þ                  lastupdatetime    GetTime    UpdateState    timelineindex    currentstate 	   timeline    time    timeinstate    timeout 	   onupdate     :   Î  Ï  Ï  Ï  Ð  Ð  Ð  Ð  Ò  Ò  Ò  Õ  Õ  Õ  Ø  Ù  Ù  Ù  Ù  Ù  Ù  Ù  Ù  Ù  Ù  Ù  Ù  Ù  Ú  Ú  Ú  Ú  Ú  Ú  Ú  Þ  Þ  Þ  Þ  Þ  Þ  Þ  Þ  ß  â  â  â  â  ã  ã  ã  ä  ä  å  å  ç  ç  é        self     9      dt    9      time_to_sleep    9       z               	      	                               "   &   "   (   ,   (   .   2   .   4   8   4   :   H   :   K   S   K   U   X   U   Z   \   Z   ^      ^                              ¥      ¥   §   Ï   §   Ð   Ò   Ú   Ò   ß   ü   ß   ü   þ      þ                         !    #  *  #  ,  .  ,  1  E  1  G  S  G  V  {  V  }    }                      º    ¼  Â  ¼  Ä  Ë  Ä  Í  é  Í  é          