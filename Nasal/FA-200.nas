setprop("/controls/flight/rudder-trim",0.9);
setprop("/controls/gear/brake-parking",1);
setprop("/sim/models/livery/show-immat",1);
setprop("/consumables/fuel/tank[0]/selected",0);
setprop("/consumables/fuel/tank[1]/selected",0);
setprop("/consumables/fuel/tank-selector",2);
setprop("/instrumentation/fric-knob",0.01);

setlistener("/consumables/fuel/tank-selector", func(sw){
	var pos = sw.getValue();
	#if(pos){setprop("consumables/fuel/tank[1]/selected",1)}else{setprop("consumables/fuel/tank[0]/selected",1}
	setprop("/consumables/fuel/tank[0]/selected",0);
	setprop("/consumables/fuel/tank[1]/selected",0);
	setprop("/consumables/fuel/tank["~pos~"]/selected",1);
},1,0);

######################### ENGINE HOOD OPEN ##########################################
props.globals.getNode("/instrumentation/doors/hood/position",1).setIntValue(0);
props.globals.getNode("/instrumentation/doors/hood/position-norm",1).setDoubleValue(0.0);

setlistener("/instrumentation/doors/hood/position",func{
             interpolate("/instrumentation/doors/hood/position-norm",getprop("/instrumentation/doors/hood/position"),5)});


#controls.adjMixture = func {
#    var running = getprop("engines/engine[0]/running");
#    var onground = getprop("gears/gear[0]/wow");
#    if (onground and !running) {
#        adjEngControl("mixture", arg[0]);
#        var mixturelevel = getprop("/controls/engines/engine[0]/mixture");
#        print ("Mixture level (0~1): ",mixturelevel);
#    }
#    else print ("mixture can't be adjusted for now");
#}

#var startEngine = controls.startEngine;
controls.startEngine = func(v=1){
        setprop("controls/engines/engine/starter",0);
        var volts = getprop("systems/electrical/batt-volts");
	print("Starter Volts: ",volts);
	if (volts < 16) v=0;
        setprop("controls/engines/engine/starter",v);
	}




