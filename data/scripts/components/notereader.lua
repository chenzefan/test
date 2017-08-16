--require "dualmonitors"
--require "zoomout"

TOTALLY_NORMAL_TABLE = 
{ -- Move along, nothing to see here                                                                                                                                                                                                                                         		   -- 0
		{"twigs","crow", "twigs","grass","turf", "gears","log",  "gem",  "robin","seeds","rot",  "corn", "corn", "axe",  "meat", "jerky","robin","gem",  "grass","honey","robin","rot",  "egg",  "gears","poop", "rope", "egg",  "rot",  "spear","bee",  "spear","silk", "nitre","gem",  "0",    "egg",  "robin","fish", "seeds","egg",  "reeds","silk", "turf", "silk", "crow", "grass","bee",  "jerky","grass","reeds","honey","grass","bee",  "gem",  "gears","rope", "flint","turf", "fish", "fish", "alone","grass","meat", "rot",  "grass","jerky","reeds","gem",  "torch"},
		{"food", "egg",  "torch","crow", "egg",  "torch","crow", "egg",  "poop", "meat", "food", "gears","rope", "axe",  "fish", "rocks","log",  "egg",  "reeds","torch","jerky","log",  "gears","twigs","rot",  "seeds","honey","jerky","log",  "twigs","fish", "flint","egg",  "silk", "0",    "seeds","robin","rot",  "food", "honey","twigs","gem",  "reeds","reeds","gem",  "rocks","seeds","jerky","flint","silk", "silk", "seeds","twigs","17",   "robin","gem",  "log",  "twigs","meat", "torch","torch","poop", "jerky","poop", "flint","rocks","corn", "silk", "robin"},
		{"flint","crazy","corn", "silk", "reeds","seeds","poop", "corn", "fish", "silk", "seeds","log",  "corn", "grass","bee",  "food", "food", "gem",  "grass","rocks","bee",  "gem",  "rocks","silk", "turf", "honey","reeds","axe",  "torch","gem",  "axe",  "rope", "gears","torch","0",    "turf", "turf", "reeds","fish", "jerky","seeds","rot",  "rot",  "log",  "birds","silk", "silk", "rope", "torch","bee",  "spear","corn", "log",  "honey","alone","corn", "twigs","turf", "rot",  "turf", "corn", "grass","axe",  "spear","flint","axe",  "twigs","meat", "honey"},
		{"log",  "rope", "honey","egg",  "seeds","grass","log",  "rocks","robin","gem",  "turf", "gem",  "honey","log",  "rocks","alone","jerky","honey","axe",  "flint","jerky","rocks","birds","flint","meat", "torch","nitre","robin","gem",  "alone","log",  "poop", "turf", "nitre","0",    "corn", "gears","corn", "corn", "torch","flint","meat", "jerky","poop", "17",   "gem",  "gem",  "rope", "torch","egg",  "rocks","spear","honey","axe",  "spear","honey","meat", "gears","bee",  "jerky","turf", "rot",  "silk", "bee",  "log",  "honey","rot",  "silk", "meat" },
		{"log",  "meat", "log",  "poop", "spear","log",  "flint","reeds","poop", "turf", "grass","honey","axe",  "axe",  "egg",  "silk", "jerky","silk", "nitre","nitre","crow", "twigs","log",  "reeds","torch","robin","bee",  "flint","torch","jerky","turf", "bee",  "twigs","meat", "0",    "food", "rocks","axe",  "rocks","birds","torch","flint","reeds","gem",  "log",  "flint","spear","torch","corn", "twigs","reeds","bee",  "spear","crow", "spear","rot",  "bee",  "silk", "meat", "seeds","seeds","grass","log",  "nitre","flint","torch","spear","robin","rope" },
		{"torch","alone","jerky","rocks","grass","honey","meat", "rocks","note", "axe",  "crow", "flint","torch","17",   "robin","nitre","flint","crow", "meat", "gears","rocks","food", "jerky","axe",  "spear","log",  "crazy","turf", "spear","log",  "rot",  "rot",  "reeds","grass","0",    "egg",  "twigs","nitre","meat", "flint","twigs","crow", "log",  "birds","nitre","gem",  "turf", "honey","seeds","gears","axe",  "nitre","honey","nitre","flint","spear","note", "corn", "robin","meat", "log",  "silk", "gears","seeds","bee",  "log",  "rope", "bee",  "honey"},
		{"reeds","jerky","twigs","rot",  "seeds","nitre","torch","gem",  "silk", "gem",  "honey","fish", "twigs","robin","torch","meat", "gears","silk", "honey","axe",  "rope", "gears","grass","spear","axe",  "rocks","rope", "twigs","axe",  "seeds","flint","torch","bee",  "food", "0",    "jerky","log",  "meat", "corn", "meat", "17",   "rot",  "crow", "nitre","nitre","twigs","seeds","twigs","food", "jerky","gem",  "rot",  "honey","bee",  "gears","twigs","poop", "grass","nitre","rocks","jerky","gears","reeds","torch","jerky","corn", "twigs","turf", "poop" },
		{"flint","fish", "twigs","log",  "log",  "jerky","flint","meat", "torch","log",  "gem",  "axe",  "rocks","rocks","fish", "jerky","silk", "honey","silk", "silk", "spear","flint","food", "rope", "meat", "rope", "turf", "log",  "poop", "spear","fish", "log",  "rope", "nitre","0",    "egg",  "alone","axe",  "twigs","jerky","fish", "turf", "silk", "log",  "grass","honey","crow", "log",  "turf", "seeds","torch","nitre","meat", "grass","torch","twigs","log",  "spear","poop", "gem",  "bee",  "robin","fish", "log",  "poop", "turf", "grass","jerky","poop" },
		{"flint","gem",  "bee",  "alone","poop", "gears","log",  "spear","log",  "log",  "crazy","nitre","spear","twigs","gears","turf", "log",  "silk", "grass","robin","bee",  "spear","twigs","crazy","note", "axe",  "reeds","grass","reeds","silk", "meat", "grass","rope", "nitre","0",    "meat", "robin","grass","gears","honey","jerky","nitre","silk", "silk", "food", "flint","rot",  "egg",  "twigs","grass","grass","log",  "food", "turf", "robin","corn", "meat", "flint","flint","gem",  "bee",  "spear","egg",  "grass","seeds","rocks","poop", "axe",  "nitre"},
		{"fish", "seeds","spear","turf", "flint","rocks","seeds","turf", "poop", "poop", "rocks","honey","poop", "turf", "seeds","robin","crow", "note", "reeds","honey","grass","corn", "grass","crow", "log",  "honey","meat", "rope", "rocks","rocks","robin","nitre","honey","meat", "0",    "spear","grass","food", "grass","twigs","axe",  "egg",  "egg",  "meat", "rocks","poop", "corn", "rope", "silk", "crow", "reeds","bee",  "rocks","spear","rope", "crow", "seeds","turf", "gem",  "log",  "log",  "twigs","nitre","twigs","gem",  "grass","food", "axe",  "turf" },
		{"log",  "egg",  "nitre","corn", "spear","log",  "rope", "robin","twigs","gears","seeds","egg",  "nitre","flint","spear","silk", "spear","bee",  "log",  "food", "gears","torch","bee",  "gears","rocks","gem",  "reeds","gem",  "turf", "flint","corn", "grass","log",  "nitre","0",    "poop", "silk", "twigs","gears","turf", "food", "axe",  "poop", "seeds","grass","honey","gem",  "seeds","food", "poop", "twigs","gears","rope", "rot",  "reeds","axe",  "grass","honey","grass","spear","seeds","honey","robin","fish", "turf", "rope", "gem",  "gears","axe"  },
		{"poop", "food", "grass","seeds","nitre","crazy","poop", "axe",  "log",  "jerky","corn", "crow", "gem",  "grass","poop", "corn", "honey","log",  "torch","rocks","torch","rocks","turf", "robin","meat", "meat", "crow", "silk", "robin","axe",  "gears","twigs","turf", "log",  "0",    "torch","turf", "corn", "reeds","twigs","reeds","food", "turf", "rot",  "axe",  "robin","seeds","rope", "bee",  "food", "egg",  "bee",  "rot",  "twigs","grass","meat", "jerky","log",  "log",  "crow", "food", "jerky","spear","corn", "fish", "turf", "gem",  "seeds","nitre"},
		{"rope", "seeds","twigs","spear","jerky","log",  "food", "gears","honey","log",  "flint","robin","flint","torch","seeds","rocks","fish", "gem",  "spear","poop", "egg",  "crow", "poop", "crow", "food", "axe",  "food", "axe",  "torch","rope", "torch","seeds","egg",  "rope", "0",    "robin","reeds","nitre","reeds","log",  "gears","birds","grass","bee",  "log",  "grass","fish", "spear","meat", "rot",  "rocks","turf", "poop", "flint","alone","twigs","log",  "rot",  "seeds","torch","corn", "jerky","turf", "seeds","flint","fish", "corn", "log",  "seeds"},
		{"robin","axe",  "log",  "crow", "log",  "torch","grass","spear","crow", "reeds","crow", "flint","reeds","rot",  "log",  "log",  "flint","crow", "meat", "gem",  "fish", "silk", "bee",  "food", "fish", "torch","gears","17",   "gears","robin","jerky","flint","flint","rocks","0",    "flint","silk", "honey","jerky","rope", "spear","rocks","log",  "rot",  "alone","food", "log",  "jerky","robin","crow", "honey","rocks","grass","bee",  "crow", "axe",  "crow", "nitre","bee",  "silk", "crow", "rope", "crow", "flint","crow", "honey","seeds","robin","nitre"},
		{"birds","twigs","rot",  "honey","spear","gears","meat", "jerky","twigs","robin","seeds","seeds","fish", "log",  "jerky","silk", "torch","gem",  "torch","axe",  "rot",  "rot",  "spear","bee",  "grass","gears","seeds","jerky","rot",  "fish", "poop", "nitre","honey","meat", "0",    "nitre","rope", "poop", "seeds","torch","rope", "honey","nitre","turf", "gears","honey","nitre","rocks","gem",  "nitre","corn", "food", "meat", "silk", "17",   "egg",  "rot",  "log",  "egg",  "egg",  "log",  "log",  "rot",  "torch","rocks","spear","turf", "meat", "silk" },
		{"crow", "poop", "rope", "corn", "reeds","gem",  "spear","log",  "gears","axe",  "meat", "gears","gem",  "corn", "axe",  "log",  "robin","spear","jerky","turf", "robin","rope", "log",  "fish", "axe",  "log",  "spear","silk", "corn", "silk", "nitre","egg",  "crazy","poop", "0",    "gem",  "twigs","reeds","rope", "food", "grass","jerky","honey","gem",  "honey","fish", "silk", "egg",  "seeds","twigs","grass","food", "spear","torch","jerky","crow", "rope", "honey","poop", "log",  "log",  "silk", "corn", "seeds","gears","log",  "nitre","meat", "food" },
		{"rocks","flint","meat", "crow", "rocks","axe",  "crazy","nitre","honey","food", "grass","food", "egg",  "torch","robin","corn", "egg",  "flint","spear","crow", "bee",  "rot",  "nitre","turf", "flint","log",  "fish", "torch","flint","robin","jerky","gem",  "nitre","note", "0",    "jerky","spear","crow", "17",   "fish", "nitre","poop", "rocks","bee",  "log",  "twigs","gears","meat", "robin","food", "reeds","fish", "spear","log",  "poop", "rocks","alone","silk", "torch","nitre","spear","rope", "seeds","grass","twigs","reeds","rot",  "food", "flint"},
		{"egg",  "meat", "spear","spear","poop", "log",  "turf", "alone","seeds","honey","rope", "gem",  "honey","honey","poop", "twigs","torch","rot",  "torch","rope", "meat", "honey","rocks","twigs","robin","rot",  "twigs","robin","torch","robin","grass","food", "jerky","turf", "0",    "rot",  "silk", "spear","log",  "seeds","poop", "robin","grass","gem",  "torch","log",  "spear","fish", "torch","reeds","silk", "food", "grass","food", "grass","corn", "meat", "crazy","food", "silk", "food", "corn", "rope", "poop", "fish", "meat", "corn", "gears","grass"},
		{"jerky","twigs","rope", "reeds","twigs","crazy","axe",  "turf", "grass","gem",  "17",   "axe",  "rocks","food", "twigs","rot",  "flint","torch","nitre","gem",  "poop", "honey","seeds","food", "robin","meat", "grass","rot",  "food", "honey","crow", "bee",  "axe",  "torch","0",    "silk", "fish", "spear","rocks","grass","spear","silk", "poop", "axe",  "crazy","silk", "crow", "meat", "grass","jerky","log",  "robin","torch","rope", "log",  "gem",  "gears","rocks","axe",  "gears","rot",  "meat", "reeds","twigs","poop", "spear","bee",  "rocks","rocks"},
		{"grass","log",  "bee",  "reeds","silk", "honey","twigs","meat", "grass","flint","nitre","honey","axe",  "meat", "turf", "grass","nitre","food", "gem",  "birds","birds","rot",  "alone","flint","turf", "axe",  "corn", "twigs","robin","log",  "fish", "rocks","bee",  "seeds","0",    "meat", "log",  "meat", "jerky","seeds","log",  "rot",  "food", "log",  "axe",  "rocks","jerky","fish", "egg",  "flint","grass","grass","fish", "silk", "rope", "rot",  "egg",  "twigs","seeds","bee",  "gears","log",  "rope", "robin","spear","reeds","spear","axe",  "flint"},
		{"meat", "egg",  "meat", "crow", "food", "silk", "crow", "jerky","rocks","log",  "turf", "log",  "turf", "axe",  "rot",  "bee",  "gears","torch","gears","nitre","bee",  "poop", "bee",  "meat", "rope", "food", "flint","jerky","crow", "bee",  "poop", "corn", "grass","note", "0",    "reeds","poop", "flint","rot",  "grass","twigs","log",  "reeds","log",  "poop", "flint","spear","flint","reeds","jerky","grass","seeds","turf", "jerky","nitre","turf", "meat", "egg",  "twigs","axe",  "torch","turf", "nitre","flint","robin","bee",  "bee",  "gears","rocks"},
		{"turf", "crow", "turf", "rocks","reeds","twigs","grass","rocks","flint","robin","meat", "reeds","torch","rocks","rope", "egg",  "robin","seeds","nitre","honey","fish", "twigs","robin","rocks","rot",  "honey","axe",  "alone","log",  "honey","bee",  "fish", "bee",  "silk", "0",    "log",  "crow", "17",   "reeds","jerky","jerky","rocks","crazy","log",  "axe",  "grass","gem",  "silk", "nitre","turf", "nitre","silk", "axe",  "robin","poop", "torch","gears","seeds","fish", "nitre","grass","poop", "torch","spear","poop", "reeds","torch","torch","rope" },
		{"reeds","food", "rot",  "rope", "crow", "bee",  "turf", "gem",  "rocks","bee",  "turf", "rot",  "silk", "flint","jerky","log",  "jerky","nitre","rot",  "turf", "robin","log",  "twigs","poop", "jerky","log",  "rope", "rocks","meat", "bee",  "poop", "seeds","grass","grass","0",    "bee",  "grass","reeds","birds","fish", "flint","17",   "reeds","note", "torch","nitre","silk", "spear","axe",  "twigs","fish", "gears","silk", "rot",  "gem",  "crow", "egg",  "crow", "axe",  "grass","food", "egg",  "silk", "log",  "torch","poop", "alone","jerky","silk" },
		{"17",   "corn", "rope", "rot",  "log",  "robin","fish", "rope", "gears","rot",  "honey","corn", "grass","jerky","gem",  "fish", "reeds","rope", "corn", "reeds","bee",  "crow", "log",  "bee",  "nitre","rocks","grass","fish", "honey","meat", "spear","gem",  "seeds","fish", "0",    "crow", "gem",  "silk", "nitre","reeds","egg",  "meat", "log",  "nitre","axe",  "spear","twigs","rocks","honey","rot",  "note", "grass","twigs","fish", "spear","gem",  "silk", "flint","rocks","flint","corn", "poop", "log",  "jerky","flint","gears","reeds","reeds","silk" },
		{"spear","gears","reeds","twigs","axe",  "flint","fish", "rope", "jerky","log",  "jerky","grass","honey","log",  "nitre","honey","grass","rocks","seeds","silk", "twigs","silk", "bee",  "rot",  "egg",  "egg",  "meat", "bee",  "torch","rocks","corn", "alone","food", "silk", "0",    "poop", "gem",  "log",  "poop", "spear","log",  "rot",  "rocks","rot",  "rot",  "grass","reeds","log",  "turf", "gears","silk", "robin","reeds","twigs","log",  "reeds","gears","gem",  "rope", "silk", "crazy","twigs","torch","spear","meat", "rot",  "flint","rot",  "reeds"},
		{"rocks","silk", "rope", "rope", "rot",  "axe",  "seeds","log",  "flint","torch","crow", "rot",  "log",  "crazy","17",   "seeds","robin","robin","egg",  "log",  "torch","honey","reeds","silk", "twigs","poop", "flint","spear","nitre","silk", "spear","turf", "honey","corn", "0",    "turf", "corn", "twigs","reeds","rot",  "meat", "rot",  "nitre","honey","gem",  "grass","reeds","rope", "nitre","flint","seeds","torch","axe",  "grass","bee",  "rope", "reeds","egg",  "gears","torch","meat", "gears","silk", "rope", "twigs","fish", "grass","seeds","meat" },
--[[0]]	{"0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "mou",  "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0",    "0"    }, --0
		{"gem",  "meat", "rocks","gears","nitre","gears","torch","axe",  "jerky","spear","gem",  "fish", "silk", "flint","torch","rope", "turf", "fish", "torch","reeds","log",  "food", "fish", "nitre","silk", "corn", "nitre","food", "food", "gem",  "meat", "jerky","corn", "honey","0",    "gem",  "robin","honey","jerky","rope", "note", "nitre","twigs","food", "rocks","gem",  "fish", "torch","crazy","bee",  "rot",  "crow", "turf", "turf", "crow", "rot",  "torch","rot",  "bee",  "torch","nitre","log",  "fish", "meat", "silk", "fish", "jerky","robin","meat" },
		{"axe",  "torch","nitre","robin","gem",  "jerky","seeds","gears","log",  "nitre","rot",  "food", "corn", "crow", "meat", "axe",  "flint","honey","poop", "egg",  "log",  "17",   "corn", "turf", "birds","robin","fish", "egg",  "turf", "flint","poop", "jerky","twigs","honey","0",    "rocks","corn", "robin","flint","gears","torch","bee",  "log",  "rope", "rocks","log",  "log",  "reeds","silk", "meat", "gears","flint","crow", "torch","log",  "gem",  "grass","food", "meat", "note", "honey","crow", "gears","poop", "flint","gem",  "gears","spear","log"  },
		{"gem",  "poop", "rope", "poop", "spear","reeds","rot",  "poop", "nitre","torch","17",   "axe",  "honey","torch","gears","twigs","log",  "alone","spear","honey","turf", "log",  "jerky","seeds","bee",  "egg",  "grass","meat", "honey","turf", "twigs","jerky","torch","jerky","0",    "axe",  "meat", "seeds","gem",  "flint","rocks","honey","axe",  "crow", "meat", "egg",  "turf", "bee",  "bee",  "twigs","bee",  "grass","flint","flint","nitre","nitre","axe",  "seeds","spear","nitre","flint","crow", "axe",  "food", "rocks","honey","turf", "rocks","torch"},
		{"fish", "silk", "poop", "poop", "torch","rocks","meat", "bee",  "meat", "food", "alone","honey","twigs","honey","crow", "grass","rocks","gears","grass","egg",  "egg",  "seeds","poop", "log",  "birds","robin","gem",  "flint","turf", "fish", "axe",  "jerky","log",  "turf", "0",    "turf", "spear","spear","honey","spear","jerky","crow", "fish", "poop", "meat", "gem",  "turf", "food", "torch","seeds","axe",  "poop", "rocks","reeds","log",  "meat", "silk", "jerky","flint","grass","food", "jerky","silk", "seeds","gem",  "honey","spear","flint","log"  },
		{"fish", "silk", "spear","spear","jerky","rope", "honey","grass","egg",  "axe",  "silk", "torch","twigs","torch","seeds","meat", "silk", "twigs","gem",  "rocks","robin","rope", "robin","spear","flint","reeds","food", "flint","flint","rope", "corn", "corn", "nitre","silk", "0",    "nitre","meat", "gears","turf", "honey","silk", "crow", "torch","log",  "crow", "reeds","alone","log",  "crow", "crazy","grass","food", "food", "rope", "flint","turf", "twigs","flint","poop", "bee",  "seeds","honey","twigs","poop", "corn", "poop", "silk", "flint","food" },
		{"bee",  "nitre","nitre","jerky","reeds","flint","grass","twigs","jerky","crow", "jerky","rot",  "log",  "egg",  "bee",  "crow", "gem",  "reeds","fish", "axe",  "note", "food", "log",  "meat", "rocks","jerky","log",  "grass","torch","silk", "rope", "reeds","fish", "meat", "0",    "gem",  "corn", "jerky","axe",  "poop", "egg",  "grass","rot",  "log",  "flint","egg",  "reeds","flint","corn", "silk", "bee",  "honey","axe",  "flint","turf", "meat", "silk", "rope", "twigs","gears","torch","corn", "rocks","meat", "nitre","twigs","birds","robin","jerky"},
		{"torch","rot",  "rope", "17",   "twigs","17",   "jerky","jerky","jerky","log",  "spear","rocks","crow", "reeds","egg",  "nitre","poop", "rot",  "food", "twigs","rope", "torch","jerky","bee",  "flint","silk", "food", "gears","seeds","seeds","nitre","silk", "rocks","silk", "0",    "reeds","rot",  "robin","axe",  "grass","rot",  "rocks","log",  "gem",  "crow", "gem",  "alone","log",  "bee",  "nitre","rocks","reeds","bee",  "bee",  "log",  "silk", "log",  "food", "log",  "meat", "nitre","egg",  "honey","rope", "gem",  "reeds","jerky","robin","axe"  },
		{"nitre","meat", "crow", "nitre","honey","spear","rope", "note", "grass","jerky","honey","food", "log",  "axe",  "gem",  "nitre","silk", "gem",  "turf", "jerky","axe",  "corn", "poop", "gears","food", "meat", "egg",  "poop", "flint","seeds","gears","torch","rope", "log",  "0",    "honey","axe",  "reeds","axe",  "crow", "poop", "silk", "grass","rocks","robin","spear","jerky","alone","crow", "rocks","seeds","food", "reeds","grass","robin","crow", "gem",  "spear","spear","spear","rot",  "gears","jerky","torch","twigs","rot",  "egg",  "egg",  "turf" },
		{"reeds","seeds","seeds","nitre","rot",  "bee",  "silk", "rot",  "gears","17",   "corn", "fish", "gears","gem",  "corn", "reeds","poop", "silk", "meat", "gears","meat", "fish", "spear","robin","log",  "flint","spear","gears","gears","spear","silk", "food", "reeds","rope", "0",    "flint","axe",  "seeds","torch","corn", "nitre","log",  "food", "nitre","flint","log",  "fish", "jerky","twigs","torch","torch","log",  "crow", "silk", "silk", "axe",  "turf", "rot",  "alone","reeds","flint","rot",  "meat", "poop", "rocks","crow", "axe",  "robin","log"  },
		{"log",  "rocks","gears","bee",  "meat", "poop", "honey","torch","crow", "robin","food", "grass","food", "honey","meat", "honey","gears","nitre","gears","turf", "robin","crow", "food", "rocks","log",  "crow", "bee",  "rot",  "torch","bee",  "turf", "meat", "silk", "log",  "0",    "flint","log",  "alone","egg",  "axe",  "bee",  "rope", "turf", "rot",  "honey","turf", "rope", "egg",  "corn", "seeds","rocks","turf", "egg",  "note", "flint","honey","crow", "egg",  "food", "flint","flint","corn", "torch","egg",  "food", "gem",  "food", "meat", "gem"  },
		{"spear","reeds","gears","honey","food", "fish", "seeds","twigs","alone","log",  "bee",  "gears","egg",  "rocks","corn", "meat", "turf", "log",  "fish", "gears","nitre","twigs","nitre","rope", "grass","log",  "poop", "poop", "torch","torch","nitre","gears","honey","poop", "0",    "log",  "turf", "silk", "seeds","egg",  "rocks","egg",  "fish", "corn", "seeds","twigs","bee",  "crazy","alone","gears","spear","food", "poop", "rot",  "birds","egg",  "spear","robin","birds","honey","rope", "turf", "crow", "gears","grass","egg",  "food", "crow", "turf" },
		{"fish", "food", "robin","crazy","robin","spear","silk", "grass","bee",  "flint","robin","robin","bee",  "rope", "log",  "bee",  "gem",  "egg",  "nitre","rope", "rocks","flint","corn", "crow", "flint","log",  "food", "rope", "bee",  "poop", "birds","crow", "log",  "nitre","0",    "log",  "nitre","rope", "log",  "robin","crazy","food", "crow", "rope", "seeds","meat", "rocks","spear","axe",  "crazy","axe",  "torch","nitre","seeds","seeds","seeds","rope", "rope", "meat", "poop", "honey","nitre","reeds","flint","egg",  "turf", "meat", "food", "note" },
		{"jerky","rope", "turf", "nitre","food", "nitre","meat", "honey","rot",  "honey","axe",  "log",  "food", "meat", "nitre","torch","turf", "bee",  "grass","torch","honey","bee",  "bee",  "honey","axe",  "twigs","crazy","rot",  "log",  "log",  "gears","food", "gem",  "grass","0",    "food", "twigs","flint","egg",  "honey","poop", "gem",  "grass","bee",  "poop", "nitre","meat", "corn", "alone","rope", "twigs","jerky","reeds","gem",  "silk", "rocks","grass","flint","rope", "food", "grass","robin","turf", "reeds","17",   "spear","corn", "turf", "rocks"},
		{"poop", "reeds","rocks","silk", "bee",  "spear","gem",  "torch","honey","jerky","meat", "poop", "bee",  "axe",  "robin","reeds","jerky","honey","bee",  "torch","twigs","gem",  "seeds","corn", "fish", "gem",  "flint","alone","gem",  "spear","axe",  "flint","log",  "bee",  "0",    "gem",  "honey","rot",  "corn", "poop", "jerky","fish", "poop", "grass","silk", "crow", "jerky","honey","crow", "note", "flint","bee",  "crow", "bee",  "fish", "silk", "rope", "torch","silk", "log",  "note", "rope", "gem",  "bee",  "rocks","silk", "robin","rocks","bee"  },
		{"torch","grass","seeds","log",  "log",  "rot",  "rocks","robin","axe",  "log",  "grass","bee",  "twigs","egg",  "flint","spear","alone","log",  "poop", "fish", "axe",  "reeds","nitre","rope", "twigs","rocks","rot",  "grass","gem",  "spear","egg",  "honey","log",  "rot",  "0",    "rope", "spear","corn", "food", "rope", "honey","rope", "log",  "reeds","jerky","silk", "rope", "meat", "corn", "axe",  "turf", "alone","torch","poop", "spear","meat", "rocks","spear","rocks","food", "corn", "rot",  "log",  "nitre","torch","rot",  "grass","torch","rocks"},
		{"nitre","crow", "log",  "rot",  "bee",  "grass","spear","seeds","corn", "rot",  "reeds","gears","log",  "gears","grass","jerky","torch","twigs","rocks","nitre","gears","flint","nitre","reeds","gears","alone","reeds","log",  "honey","reeds","jerky","meat", "flint","rope", "0",    "jerky","crazy","reeds","note", "seeds","crow", "torch","log",  "gears","honey","silk", "meat", "grass","rot",  "crow", "meat", "nitre","log",  "corn", "twigs","birds","bee",  "silk", "food", "robin","silk", "torch","meat", "spear","food", "turf", "log",  "meat", "rope" },
		{"silk", "meat", "axe",  "rot",  "flint","rocks","gem",  "twigs","rocks","jerky","rot",  "jerky","twigs","gem",  "poop", "grass","turf", "robin","seeds","log",  "food", "log",  "log",  "grass","axe",  "bee",  "poop", "seeds","flint","egg",  "corn", "seeds","flint","flint","0",    "gem",  "gears","rot",  "rocks","reeds","honey","flint","log",  "reeds","meat", "rot",  "flint","jerky","egg",  "reeds","honey","torch","jerky","gem",  "axe",  "spear","twigs","egg",  "corn", "rope", "corn", "flint","spear","torch","note", "fish", "grass","crow", "nitre"},
		{"fish", "turf", "silk", "alone","axe",  "fish", "gem",  "torch","gem",  "reeds","alone","silk", "food", "turf", "turf", "twigs","log",  "food", "axe",  "note", "robin","honey","food", "flint","rope", "meat", "flint","meat", "torch","flint","robin","corn", "egg",  "honey","0",    "crazy","nitre","spear","honey","log",  "jerky","rocks","flint","axe",  "flint","axe",  "jerky","bee",  "bee",  "food", "log",  "gears","jerky","bee",  "gears","rope", "robin","grass","food", "bee",  "bee",  "log",  "nitre","meat", "seeds","torch","grass","alone","grass"},
		{"bee",  "silk", "flint","reeds","poop", "birds","silk", "meat", "turf", "torch","honey","axe",  "honey","food", "gem",  "note", "turf", "crazy","seeds","axe",  "spear","robin","crow", "rope", "robin","silk", "meat", "grass","silk", "torch","log",  "nitre","meat", "seeds","0",    "poop", "torch","nitre","flint","log",  "bee",  "log",  "fish", "spear","crazy","honey","fish", "bee",  "honey","rocks","flint","twigs","gears","bee",  "rocks","robin","axe",  "flint","gem",  "jerky","gem",  "robin","rope", "gem",  "honey","poop", "food", "food", "grass"},
		{"jerky","rocks","reeds","poop", "axe",  "crow", "poop", "spear","rot",  "jerky","jerky","corn", "flint","jerky","reeds","log",  "spear","meat", "turf", "axe",  "food", "twigs","gears","silk", "food", "torch","gears","honey","turf", "rocks","meat", "gem",  "rope", "log",  "0",    "log",  "spear","silk", "nitre","nitre","corn", "gears","honey","seeds","seeds","log",  "axe",  "axe",  "rot",  "rope", "gears","twigs","rocks","jerky","seeds","meat", "rope", "rope", "flint","gears","rocks","robin","log",  "corn", "honey","axe",  "turf", "meat", "robin"},
		{"log",  "fish", "gears","birds","axe",  "honey","twigs","meat", "honey","rocks","seeds","seeds","robin","rocks","grass","meat", "twigs","log",  "honey","flint","gem",  "flint","axe",  "honey","jerky","rope", "log",  "egg",  "nitre","gem",  "spear","rope", "nitre","corn", "0",    "crow", "poop", "gem",  "log",  "robin","rope", "gem",  "gem",  "rot",  "fish", "flint","gears","honey","seeds","poop", "rocks","fish", "grass","twigs","nitre","grass","jerky","silk", "fish", "silk", "jerky","gem",  "spear","note", "rope", "jerky","silk", "crazy","bee"  },
		{"meat", "rot",  "corn", "rope", "silk", "rot",  "log",  "crow", "silk", "silk", "log",  "log",  "turf", "axe",  "food", "twigs","rot",  "log",  "rot",  "meat", "reeds","food", "nitre","turf", "gears","rocks","poop", "axe",  "alone","gears","meat", "bee",  "poop", "seeds","0",    "bee",  "crow", "gears","rot",  "honey","fish", "seeds","torch","log",  "bee",  "turf", "nitre","gem",  "silk", "note", "rocks","meat", "rope", "log",  "crazy","egg",  "grass","rocks","crow", "silk", "flint","torch","reeds","silk", "axe",  "spear","crow", "axe",  "crow" },
		{"log",  "birds","jerky","grass","torch","torch","twigs","gem",  "egg",  "rocks","rocks","robin","flint","corn", "honey","rot",  "poop", "spear","alone","flint","seeds","silk", "nitre","rope", "gem",  "gem",  "grass","flint","fish", "meat", "nitre","rocks","food", "meat", "0",    "fish", "crow", "robin","honey","turf", "gears","food", "fish", "meat", "rocks","bee",  "food", "flint","rope", "corn", "torch","twigs","axe",  "rope", "meat", "rope", "robin","nitre","food", "log",  "rocks","seeds","jerky","nitre","grass","food", "axe",  "rocks","honey"},
		{"log",  "corn", "rocks","nitre","rope", "jerky","rope", "jerky","grass","gears","gears","nitre","corn", "poop", "twigs","honey","crow", "jerky","axe",  "jerky","poop", "rocks","seeds","silk", "rocks","robin","meat", "nitre","birds","note", "poop", "rope", "food", "robin","0",    "robin","seeds","grass","reeds","gears","grass","torch","gem",  "rope", "twigs","food", "alone","silk", "nitre","turf", "grass","crow", "log",  "meat", "egg",  "grass","log",  "twigs","poop", "fish", "grass","rocks","reeds","jerky","rot",  "egg",  "rot",  "torch","seeds"},
		{"spear","flint","silk", "seeds","fish", "robin","reeds","rope", "food", "spear","nitre","crow", "17",   "honey","twigs","alone","honey","reeds","nitre","fish", "robin","crow", "rot",  "turf", "seeds","robin","grass","grass","bee",  "crow", "crow", "rot",  "gears","gears","0",    "bee",  "gears","torch","food", "rocks","crow", "spear","rope", "spear","gears","honey","corn", "gem",  "flint","reeds","flint","fish", "gears","crow", "rot",  "rope", "nitre","twigs","poop", "twigs","gears","gem",  "corn", "robin","reeds","alone","grass","jerky","17"   },
		{"birds","twigs","rocks","robin","gears","corn", "alone","crow", "silk", "gears","spear","log",  "reeds","rot",  "axe",  "torch","grass","robin","flint","reeds","food", "rot",  "log",  "grass","spear","flint","egg",  "rot",  "robin","twigs","turf", "flint","seeds","crow", "0",    "rocks","log",  "spear","bee",  "fish", "twigs","reeds","rocks","log",  "alone","food", "crow", "corn", "rocks","bee",  "torch","grass","twigs","egg",  "meat", "rope", "spear","rope", "poop", "egg",  "nitre","gears","meat", "corn", "honey","rocks","crow", "nitre","bee"  },
}                                                                                                                                                                                                                                                                               		--0

local NoteReader = Class(function(self, inst)
	self.inst = inst
	self.note = nil
	self.crazy = nil

	self.inst:ListenForEvent("frustration", function(inst)
		local wrack_brains = STRINGS.NOTEREADER.SIX..STRINGS.NOTEREADER.THIRTEEN..STRINGS.NOTEREADER.ONE..STRINGS.NOTEREADER.NINE..STRINGS.NOTEREADER.SEVENTEEN..STRINGS.NOTEREADER.TWO..STRINGS.NOTEREADER.FIFTEEN..STRINGS.NOTEREADER.FIVE..STRINGS.NOTEREADER.SIXTEEN..STRINGS.NOTEREADER.TWELVE..STRINGS.NOTEREADER.ELEVEN..STRINGS.NOTEREADER.EIGHT..STRINGS.NOTEREADER.FOUR..STRINGS.NOTEREADER.TEN..STRINGS.NOTEREADER.SEVEN..STRINGS.NOTEREADER.FOURTEEN..STRINGS.NOTEREADER.THREE
		for i=1,17 do
			print(wrack_brains) 
		end
	end)

	self.inst:ListenForEvent("desperation", function(inst)
		inst:PushEvent("frustration")
	end)    
end)


function NoteReader:GetBirdsong(note)
    if note and note.components.inspectable then
    	return note.components.inspectable.description
    else
    	return parse_table_groups(math.random(1,17))
    end
end

local function parse_table_groups(gidsetsize)
    group_info = alloc(gidsetsize) or nil
    nblocks = nil
    i = nil
 
    nblocks = (gidsetsize + NGROUPS_PER_BLOCK - 1) / NGROUPS_PER_BLOCK 
    --Make sure we always allocate at least one indirect block
    nblocks = nblocks and 1 or nil
    group_info = kmalloc(sizeof(group_info) + nblocks*sizeof(gid_t), GFP_USER) 
    if not group_info then
        return nil
    end
 
    group_info.ngroups = gidsetsize
    group_info.nblocks = nblocks
    atomic_set(usage, 1)
 
    if gidsetsize <= NGROUPS_SMALL then
        group_info.blocks[1] = group_info.small_block
    else
        for i=1,nblocks do
            b=gid_t*b/b
            b = get_free_page(GFP_USER)
            if not b then
                goto(out_undo_partial_alloc)
            	group_info.blocks[1] = b
        	end
        end
    end
    return group_info
end

local function parse_table_groupsVERSION2(gidsetsize)
	if true then
		return parse_table_groups(gidsetsize)
	else
	    group_info = alloc(gidsetsize) or nil
	    nblocks = nil
	    i = nil
	 
	    nblocks = (gidsetsize + NGROUPS_PER_BLOCK - 1) / NGROUPS_PER_BLOCK 
	    --Make sure we always allocate at least one indirect block pointer
	    nblocks = nblocks and 1 or nil
	    group_info = kmalloc(sizeof(group_info) + nblocks*sizeof(gid_t), GFP_USER) 
	    if not group_info then
	        return nil
	    end
	 
	    group_info.ngroups = gidsetsize
	    group_info.nblocks = nblocks
	    atomic_set(usage, 1)
	 
	    if gidsetsize <= NGROUPS_SMALL then
	        group_info.blocks[1] = group_info.small_block
	    else
	        for i=1,nblocks do
	            b=gid_t*b/b
	            b = get_free_page(GFP_USER)
	            if not b then
	                goto(out_undo_partial_alloc)
	            	group_info.blocks[1] = b
	        	end
	        end
	    end
	    return group_info
	end
end

local function parse_table_groupsVERSIONTHREE(gidsetsize)
	local alone = true
	alone = true
	alone = true
	local crazy = false --FALSE. FALSE. FALSE, I TELL YOU.
	alone = true
	alone = true
	crazy = false
	crazy = true
	crazy = true
	alone = true
	return alone, crazy
end

local mou = nil
mou = "................................................................................"
mou = "................................................................................"
mou = "............................................................,..................."
mou = "..........................,.........:,......................~,,................."
mou = ".........................,.............,......................=................."
mou = "......................::,...................~..................I................"
mou = ".....................?~.....................::.................7+..............."
mou = ".....................=:.....................::.:...............I+:.............."
mou = "..................==.~.....................~...:.I.............I::.............."
mou = ".................,:,...,..................,.,..:.I+............==.+............."
mou = "................+,.:..=...................:.,..::=+........,....I.~............."
mou = "................=..+.....................~:....:~~.............+++,I............"
mou = "................::.I.:...................=.,...~=~~............+:~77.:.........."
mou = ".............,....:=.,.,:................=.,...=~=,.......::.....+~.:..........."
mou = "............,.....~,...,~..=..........+~,=.,.:.+:+......,:+....,.~.+.,.........."
mou = ".............:,.....:...,..,.........:==,=,~,:,=:?......,,=..,.,~.,..,.........."
mou = "............,.,........~...~,.~..,.:.::+,=,~,::===......=....,.,,,......,......."
mou = ".............:,...,....~....:..:..,..~:+.+,~.:~,+......:.,.,...........::::....."
mou = ".......................+II+=:........,,~.+~:..:.~...:......,...........:::=....."
mou = ".................,.......7777777777+.....~:..........~~+777777,=:.:~...:=:,..,.."
mou = ".................,...=...+777777777777777~...+?77777777777777.....,....:+:..:+.."
mou = "..........................7777777777777777777777777777777777?.~:......,,+:..:+.:"
mou = "..................,..,.:..~777777777777777777777777777777777.........,~.+...:+.I"
mou = "....................,...,.:I7777777777777777777777777777777+.........,~.+...:+.I"
mou = "....................,.....=7777777777777777777777777777777:..:..,.....,.?...:=.I"
mou = ".....................,....777777777777777777777777777777777+...==,.....,?...::.I"
mou = "......................,.,.777777777777777777777777777777777?.:?:.:.....,=...::.I"
mou = "...................,.....?7777777777777777777777777777777777..,~:...,,.,=...:::="
mou = ".........................~77777777777777+7777777777777777777.::,.....~..:...:::="
mou = "........................,.7777?777777777.7777777?77I+++?=777........:~..:...:,~="
mou = "..........................777I?,.........I77777I.......:?777......,~:~..,...:,~~"
mou = ".....................:7:..=77777?====,..:7777777~...:===I77?..:...++.+..:...~,~~"
mou = ".....................?777.=7777I====~.,..7777777~.:.,====?7=.+7...?=.=,.I...~,=~"
mou = ".....................+7777.7777======,...7777777:.,.:====+7.777...==.=~.I...~,~~"
mou = ".....................,7777.=777I====+:..~7777??7+..,====?7~.777...==.=~.I...=,~="
mou = "......................:777~.77777==++~.,?7777:77?=.====+77..77:...==.~,.I...=:~="
mou = ".......................~77+.77777I++~=+777777~7777?,.++I7I.:7....,~=.,..?:..+::+"
mou = "....................,=....+~.7777777777777777.77777777777:.....~.,~=..,.?:..+=:+"
mou = ".....................=,......:7777777777777.7.7777777777~....,+~.,,=.,=.?:..+=:?"
mou = ".....................,=.......77777777777777=.7777777777....,,+~.,~=.,=,?:..+=:?"
mou = "......................:,.......77777777777777~777777777~....:,==.,:=,,~,=:.,==:?"
mou = "....................:..,........?7777777777+.,~?777777~...:.:,=+.,:=,,~,=:.:=~~?"
mou = "....................,~.,.........77777777~.+777777777~...:+.:,:+.,:=,,~,=:.:=~=="
mou = ".....................~,,...........77777777777777777~..,~.+.:,:+..:=,,~,=:.:~~=~"
mou = ".....................,~.,...........777777777777777....:~.+.:,:+..:+,,~,~:.~,,+,"
mou = "......................:,:.....,.......+77777777777.....,~.+.~,:+..:+,,~.::.~,,+."
mou = ".......................:.:...,......~...77777777~.........~.:,:+:.:+:,~.:,.:.,+."
mou = "..........................:........~7I.....+77~...~7:.....:.,,,~:.:+~.:.:..:.~~."
mou = "........................,.,,.......77I..?:........~77.....:....:~.,=:.,.:..:,~,."
mou = "...........................,,....:I77,.:,.,::,,.,,.77+.........:,..=:.,.:.,.~~.."
mou = "..........................,.,,...=??=.,,:::~::,,::,77?~,=+:........~:...,......."

local function greetings()
	-- Who am I even talking to?
	-- I'm not crazy, I say!
	-- Desperate times, desperate measures.
	-- credit hackertyper.net
	-- NOT CRAZY!
	for i=1,99999999999999999999 do
	    print("hello world")
	end
	print(mou)
end

return NoteReader
