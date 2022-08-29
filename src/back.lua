--[[============================================================
--=
--=  The backside
--=
--=-------------------------------------------------------------
--=
--=  LÖVE Audio Effects Playground
--=  by Marcus 'ReFreezed' Thunström
--=
--============================================================]]

local function f(flags) -- :AvoidPairsWhenCheckingFlags
	local flagsOut = {}
	for id, toggled in pairs(flags) do
		table.insert(flagsOut, id)
		flagsOut[id] = toggled
	end
	return flagsOut
end

local dist = 34

local back = {
	groups = {
		source1 = {ox=.05,oy=.2, ax=0,ay=1, x=0  ,y=0, label="source 1 (loaded)"},
		source2 = {ox=.15,oy=.2, ax=0,ay=1, x=260,y=0, label="source 2"},

		filters1 = {ox=.05,oy=.2, ax=0,ay=1, x=0  ,y=100, label="source1 filters"},
		filters2 = {ox=.15,oy=.2, ax=0,ay=1, x=260,y=100, label="source2 filters"},

		fx11 = {ox=.5,oy=.85, ax=.5,ay=0, x=-2*150,y=-100, label="fx 1 (chorus)"},
		fx12 = {ox=.5,oy=.85, ax=.5,ay=0, x=-1*150,y=-100, label="fx 2 (flanger)"},
		fx13 = {ox=.5,oy=.85, ax=.5,ay=0, x= 0*150,y=-100, label="fx 3 (equalizer)"},
		fx14 = {ox=.5,oy=.85, ax=.5,ay=0, x= 1*150,y=-100, label="fx 4 (compressor)"},
		fx15 = {ox=.5,oy=.85, ax=.5,ay=0, x= 2*150,y=-100, label="fx 5"},
		fx21 = {ox=.5,oy=.85, ax=.5,ay=0, x=-2*150,y=0   , label="fx 6 (reverb)"},
		fx22 = {ox=.5,oy=.85, ax=.5,ay=0, x=-1*150,y=0   , label="fx 7 (echo)"},
		fx23 = {ox=.5,oy=.85, ax=.5,ay=0, x= 0*150,y=0   , label="fx 8 (ring modulator)"},
		fx24 = {ox=.5,oy=.85, ax=.5,ay=0, x= 1*150,y=0   , label="fx 9 (distortion)"},
		fx25 = {ox=.5,oy=.85, ax=.5,ay=0, x= 2*150,y=0   , label="fx 10"},

		speaker = {ox=.95,oy=.15, ax=1,ay=1, x=0,y=0, label="speaker"},
	},

	connectors = {
		-- Sources.
		{name="source1Out11", group="source1", x=0.5*dist,y=0*dist, out=true},
		{name="source1Out12", group="source1", x=1.5*dist,y=0*dist, out=true},
		{name="source1Out13", group="source1", x=2.5*dist,y=0*dist, out=true},
		{name="source1Out14", group="source1", x=3.5*dist,y=0*dist, out=true},
		{name="source1Out15", group="source1", x=4.5*dist,y=0*dist, out=true},
		{name="source1Out16", group="source1", x=5.5*dist,y=0*dist, out=true},
		{name="source1Out21", group="source1", x=0.5*dist,y=1*dist, out=true},
		{name="source1Out22", group="source1", x=1.5*dist,y=1*dist, out=true},
		{name="source1Out23", group="source1", x=2.5*dist,y=1*dist, out=true},
		{name="source1Out24", group="source1", x=3.5*dist,y=1*dist, out=true},
		{name="source1Out25", group="source1", x=4.5*dist,y=1*dist, out=true},
		{name="source1Out26", group="source1", x=5.5*dist,y=1*dist, out=true},

		{name="source2Out01", group="source2", x=0.5*dist,y=0*dist, out=true},
		{name="source2Out02", group="source2", x=1.5*dist,y=0*dist, out=true},
		{name="source2Out03", group="source2", x=2.5*dist,y=0*dist, out=true},
		{name="source2Out04", group="source2", x=3.5*dist,y=0*dist, out=true},
		{name="source2Out05", group="source2", x=4.5*dist,y=0*dist, out=true},
		{name="source2Out06", group="source2", x=5.5*dist,y=0*dist, out=true},
		{name="source2Out07", group="source2", x=0.5*dist,y=1*dist, out=true},
		{name="source2Out08", group="source2", x=1.5*dist,y=1*dist, out=true},
		{name="source2Out09", group="source2", x=2.5*dist,y=1*dist, out=true},
		{name="source2Out10", group="source2", x=3.5*dist,y=1*dist, out=true},
		{name="source2Out11", group="source2", x=4.5*dist,y=1*dist, out=true},
		{name="source2Out12", group="source2", x=5.5*dist,y=1*dist, out=true},

		-- Source filters.
		{name="source1Filter01In" , group="filters1", x=0*dist,y=0*dist, out=false},
		{name="source1Filter02In" , group="filters1", x=1*dist,y=0*dist, out=false},
		{name="source1Filter03In" , group="filters1", x=2*dist,y=0*dist, out=false},
		{name="source1Filter04In" , group="filters1", x=3*dist,y=0*dist, out=false},
		{name="source1Filter05In" , group="filters1", x=4*dist,y=0*dist, out=false},
		{name="source1Filter06In" , group="filters1", x=5*dist,y=0*dist, out=false},
		{name="source1Filter07In" , group="filters1", x=6*dist,y=0*dist, out=false},
		{name="source1Filter08In" , group="filters1", x=7*dist,y=0*dist, out=false},
		{name="source1Filter09In" , group="filters1", x=8*dist,y=0*dist, out=false},
		{name="source1Filter10In" , group="filters1", x=9*dist,y=0*dist, out=false},
		{name="source1Filter01Out", group="filters1", x=0*dist,y=1*dist, out=true},
		{name="source1Filter02Out", group="filters1", x=1*dist,y=1*dist, out=true},
		{name="source1Filter03Out", group="filters1", x=2*dist,y=1*dist, out=true},
		{name="source1Filter04Out", group="filters1", x=3*dist,y=1*dist, out=true},
		{name="source1Filter05Out", group="filters1", x=4*dist,y=1*dist, out=true},
		{name="source1Filter06Out", group="filters1", x=5*dist,y=1*dist, out=true},
		{name="source1Filter07Out", group="filters1", x=6*dist,y=1*dist, out=true},
		{name="source1Filter08Out", group="filters1", x=7*dist,y=1*dist, out=true},
		{name="source1Filter09Out", group="filters1", x=8*dist,y=1*dist, out=true},
		{name="source1Filter10Out", group="filters1", x=9*dist,y=1*dist, out=true},

		{name="source2Filter01In" , group="filters2", x=0*dist,y=0*dist, out=false},
		{name="source2Filter02In" , group="filters2", x=1*dist,y=0*dist, out=false},
		{name="source2Filter03In" , group="filters2", x=2*dist,y=0*dist, out=false},
		{name="source2Filter04In" , group="filters2", x=3*dist,y=0*dist, out=false},
		{name="source2Filter05In" , group="filters2", x=4*dist,y=0*dist, out=false},
		{name="source2Filter06In" , group="filters2", x=5*dist,y=0*dist, out=false},
		{name="source2Filter07In" , group="filters2", x=6*dist,y=0*dist, out=false},
		{name="source2Filter08In" , group="filters2", x=7*dist,y=0*dist, out=false},
		{name="source2Filter09In" , group="filters2", x=8*dist,y=0*dist, out=false},
		{name="source2Filter10In" , group="filters2", x=9*dist,y=0*dist, out=false},
		{name="source2Filter01Out", group="filters2", x=0*dist,y=1*dist, out=true},
		{name="source2Filter02Out", group="filters2", x=1*dist,y=1*dist, out=true},
		{name="source2Filter03Out", group="filters2", x=2*dist,y=1*dist, out=true},
		{name="source2Filter04Out", group="filters2", x=3*dist,y=1*dist, out=true},
		{name="source2Filter05Out", group="filters2", x=4*dist,y=1*dist, out=true},
		{name="source2Filter06Out", group="filters2", x=5*dist,y=1*dist, out=true},
		{name="source2Filter07Out", group="filters2", x=6*dist,y=1*dist, out=true},
		{name="source2Filter08Out", group="filters2", x=7*dist,y=1*dist, out=true},
		{name="source2Filter09Out", group="filters2", x=8*dist,y=1*dist, out=true},
		{name="source2Filter10Out", group="filters2", x=9*dist,y=1*dist, out=true},

		-- FX.
		{name="fx11In1", group="fx11", x=0.0*dist,y=0*dist, out=false},
		{name="fx11In2", group="fx11", x=1.0*dist,y=0*dist, out=false},
		{name="fx11In3", group="fx11", x=2.0*dist,y=0*dist, out=false},
		{name="fx11In4", group="fx11", x=3.0*dist,y=0*dist, out=false},
		{name="fx11Out", group="fx11", x=1.5*dist,y=1*dist, out=true},

		{name="fx12In1", group="fx12", x=0.0*dist,y=0*dist, out=false},
		{name="fx12In2", group="fx12", x=1.0*dist,y=0*dist, out=false},
		{name="fx12In3", group="fx12", x=2.0*dist,y=0*dist, out=false},
		{name="fx12In4", group="fx12", x=3.0*dist,y=0*dist, out=false},
		{name="fx12Out", group="fx12", x=1.5*dist,y=1*dist, out=true},

		{name="fx13In1", group="fx13", x=0.0*dist,y=0*dist, out=false},
		{name="fx13In2", group="fx13", x=1.0*dist,y=0*dist, out=false},
		{name="fx13In3", group="fx13", x=2.0*dist,y=0*dist, out=false},
		{name="fx13In4", group="fx13", x=3.0*dist,y=0*dist, out=false},
		{name="fx13Out", group="fx13", x=1.5*dist,y=1*dist, out=true},

		{name="fx14In1", group="fx14", x=0.0*dist,y=0*dist, out=false},
		{name="fx14In2", group="fx14", x=1.0*dist,y=0*dist, out=false},
		{name="fx14In3", group="fx14", x=2.0*dist,y=0*dist, out=false},
		{name="fx14In4", group="fx14", x=3.0*dist,y=0*dist, out=false},
		{name="fx14Out", group="fx14", x=1.5*dist,y=1*dist, out=true},

		{name="fx15In1", group="fx15", x=0.0*dist,y=0*dist, out=false},
		{name="fx15In2", group="fx15", x=1.0*dist,y=0*dist, out=false},
		{name="fx15In3", group="fx15", x=2.0*dist,y=0*dist, out=false},
		{name="fx15In4", group="fx15", x=3.0*dist,y=0*dist, out=false},
		{name="fx15Out", group="fx15", x=1.5*dist,y=1*dist, out=true},

		{name="fx21In1", group="fx21", x=0.0*dist,y=0*dist, out=false},
		{name="fx21In2", group="fx21", x=1.0*dist,y=0*dist, out=false},
		{name="fx21In3", group="fx21", x=2.0*dist,y=0*dist, out=false},
		{name="fx21In4", group="fx21", x=3.0*dist,y=0*dist, out=false},
		{name="fx21Out", group="fx21", x=1.5*dist,y=1*dist, out=true},

		{name="fx22In1", group="fx22", x=0.0*dist,y=0*dist, out=false},
		{name="fx22In2", group="fx22", x=1.0*dist,y=0*dist, out=false},
		{name="fx22In3", group="fx22", x=2.0*dist,y=0*dist, out=false},
		{name="fx22In4", group="fx22", x=3.0*dist,y=0*dist, out=false},
		{name="fx22Out", group="fx22", x=1.5*dist,y=1*dist, out=true},

		{name="fx23In1", group="fx23", x=0.0*dist,y=0*dist, out=false},
		{name="fx23In2", group="fx23", x=1.0*dist,y=0*dist, out=false},
		{name="fx23In3", group="fx23", x=2.0*dist,y=0*dist, out=false},
		{name="fx23In4", group="fx23", x=3.0*dist,y=0*dist, out=false},
		{name="fx23Out", group="fx23", x=1.5*dist,y=1*dist, out=true},

		{name="fx24In1", group="fx24", x=0.0*dist,y=0*dist, out=false},
		{name="fx24In2", group="fx24", x=1.0*dist,y=0*dist, out=false},
		{name="fx24In3", group="fx24", x=2.0*dist,y=0*dist, out=false},
		{name="fx24In4", group="fx24", x=3.0*dist,y=0*dist, out=false},
		{name="fx24Out", group="fx24", x=1.5*dist,y=1*dist, out=true},

		{name="fx25In1", group="fx25", x=0.0*dist,y=0*dist, out=false},
		{name="fx25In2", group="fx25", x=1.0*dist,y=0*dist, out=false},
		{name="fx25In3", group="fx25", x=2.0*dist,y=0*dist, out=false},
		{name="fx25In4", group="fx25", x=3.0*dist,y=0*dist, out=false},
		{name="fx25Out", group="fx25", x=1.5*dist,y=1*dist, out=true},

		-- Speaker.
		{name="speaker11", group="speaker", x=0*dist,y=0*dist, out=false},
		{name="speaker12", group="speaker", x=1*dist,y=0*dist, out=false},
		{name="speaker13", group="speaker", x=2*dist,y=0*dist, out=false},
		{name="speaker14", group="speaker", x=3*dist,y=0*dist, out=false},
		{name="speaker15", group="speaker", x=4*dist,y=0*dist, out=false},
		{name="speaker16", group="speaker", x=5*dist,y=0*dist, out=false},
		{name="speaker17", group="speaker", x=6*dist,y=0*dist, out=false},
		{name="speaker18", group="speaker", x=7*dist,y=0*dist, out=false},
		{name="speaker21", group="speaker", x=0*dist,y=1*dist, out=false},
		{name="speaker22", group="speaker", x=1*dist,y=1*dist, out=false},
		{name="speaker23", group="speaker", x=2*dist,y=1*dist, out=false},
		{name="speaker24", group="speaker", x=3*dist,y=1*dist, out=false},
		{name="speaker25", group="speaker", x=4*dist,y=1*dist, out=false},
		{name="speaker26", group="speaker", x=5*dist,y=1*dist, out=false},
		{name="speaker27", group="speaker", x=6*dist,y=1*dist, out=false},
		{name="speaker28", group="speaker", x=7*dist,y=1*dist, out=false},
	},

	wires = {
		-- Source 2.
		{from="source1Out11",to="source1Filter01In",flags=f{filterParam_active=true}}, {from="source1Filter01Out",to="speaker11",flags=f{filterParam_active=true}},
		{from="source1Out11",to="speaker11",flags=f{filterParam_active=false}},

		{from="source1Out13",to="source1Filter03In",flags=f{param_chorus_active=true,filterParam_chorus_active=true}}, {from="source1Filter03Out",to="fx11In1",flags=f{param_chorus_active=true,filterParam_chorus_active=true}},
		{from="source1Out13",to="fx11In1",flags=f{param_chorus_active=true,filterParam_chorus_active=false}},

		{from="source1Out23",to="source1Filter04In",flags=f{param_flanger_active=true,filterParam_flanger_active=true}}, {from="source1Filter04Out",to="fx12In1",flags=f{param_flanger_active=true,filterParam_flanger_active=true}},
		{from="source1Out23",to="fx12In1",flags=f{param_flanger_active=true,filterParam_flanger_active=false}},

		{from="source1Out14",to="source1Filter05In",flags=f{param_equalizer_active=true,filterParam_equalizer_active=true}}, {from="source1Filter05Out",to="fx13In1",flags=f{param_equalizer_active=true,filterParam_equalizer_active=true}},
		{from="source1Out14",to="fx13In1",flags=f{param_equalizer_active=true,filterParam_equalizer_active=false}},

		{from="source1Out24",to="source1Filter06In",flags=f{param_compressor_active=true,filterParam_compressor_active=true}}, {from="source1Filter06Out",to="fx14In1",flags=f{param_compressor_active=true,filterParam_compressor_active=true}},
		{from="source1Out24",to="fx14In1",flags=f{param_compressor_active=true,filterParam_compressor_active=false}},

		{from="source1Out15",to="source1Filter07In",flags=f{param_reverb_active=true,filterParam_reverb_active=true}}, {from="source1Filter07Out",to="fx21In1",flags=f{param_reverb_active=true,filterParam_reverb_active=true}},
		{from="source1Out15",to="fx21In1",flags=f{param_reverb_active=true,filterParam_reverb_active=false}},

		{from="source1Out25",to="source1Filter08In",flags=f{param_echo_active=true,filterParam_echo_active=true}}, {from="source1Filter08Out",to="fx22In1",flags=f{param_echo_active=true,filterParam_echo_active=true}},
		{from="source1Out25",to="fx22In1",flags=f{param_echo_active=true,filterParam_echo_active=false}},

		{from="source1Out16",to="source1Filter09In",flags=f{param_ringmodulator_active=true,filterParam_ringmodulator_active=true}}, {from="source1Filter09Out",to="fx23In1",flags=f{param_ringmodulator_active=true,filterParam_ringmodulator_active=true}},
		{from="source1Out16",to="fx23In1",flags=f{param_ringmodulator_active=true,filterParam_ringmodulator_active=false}},

		{from="source1Out26",to="source1Filter10In",flags=f{param_distortion_active=true,filterParam_distortion_active=true}}, {from="source1Filter10Out",to="fx24In1",flags=f{param_distortion_active=true,filterParam_distortion_active=true}},
		{from="source1Out26",to="fx24In1",flags=f{param_distortion_active=true,filterParam_distortion_active=false}},

		-- FX.
		{from="fx11Out",to="speaker13",flags=f{param_chorus_active=true}},
		{from="fx12Out",to="speaker14",flags=f{param_flanger_active=true}},
		{from="fx13Out",to="speaker15",flags=f{param_equalizer_active=true}},
		{from="fx14Out",to="speaker16",flags=f{param_compressor_active=true}},
		{from="fx21Out",to="speaker23",flags=f{param_reverb_active=true}},
		{from="fx22Out",to="speaker24",flags=f{param_echo_active=true}},
		{from="fx23Out",to="speaker25",flags=f{param_ringmodulator_active=true}},
		{from="fx24Out",to="speaker26",flags=f{param_distortion_active=true}},
	},
}

for _, conn in ipairs(back.connectors) do  back.connectors[conn.name] = conn  end

return back
