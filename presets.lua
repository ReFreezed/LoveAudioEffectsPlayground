local function parsePresets(presetsStr)
	local columns = nil
	local presets = {}

	for line in presetsStr:gmatch"%S[^\n]*" do
		if line:find"^%-%-" then
			-- void

		elseif not columns then
			columns = {}

			for name in line:gmatch"%S+" do
				table.insert(columns, (not name:find"%?$" and name or false))
			end

		else
			local preset = {title="?", params={}}
			local i      = -1

			for valueStr in line:gmatch"%S+" do
				i = i + 1

				if     i == 0              then  preset.title = valueStr:gsub("_", " "):gsub(".", string.lower):gsub(".", string.upper, 1)
				elseif not columns[i]      then  if columns[i] == nil then  error(line)  end
				elseif valueStr == "true"  then  preset.params[columns[i]] = true
				elseif valueStr == "false" then  preset.params[columns[i]] = false
				else                             preset.params[columns[i]] = tonumber(valueStr) or error(valueStr)  end
			end

			table.insert(presets, preset)
		end
	end

	return presets
end

return {
	chorus = {
		{title="Tube", params={volume=1, waveform="sine", phase=53.57, rate=2.5, depth=.02979, feedback=.9298, delay=.004081}},
		{title="Wacky", params={volume=1, waveform="sine", phase=77.14, rate=3.333, depth=.4287, feedback=.25, delay=.016}},
	},

	flanger = {
		{title="Alien", params={volume=1, waveform="sine", phase=102.2, rate=8.919, depth=.8233, feedback=-.2950, delay=.0032}},
		{title="Cyborg", params={volume=1, waveform="triangle", phase=0, rate=6.049, depth=.1975, feedback=.6639, delay=.0026}},
	},

	equalizer = {
		-- {title="foo", params={volume=1, lowgain=, lowcut=, lowmidgain=, lowmidfrequency=, lowmidbandwidth=, highmidgain=, highmidfrequency=, highmidbandwidth=, highgain=, highcut=}},
	},

	compressor = {
		-- void
	},

	reverb = parsePresets[[
		-- https://github.com/kcat/openal-soft/blob/master/include/AL/efx-presets.h

		-- flDensity flDiffusion flGain flGainHF flGainLF flDecayTime flDecayHFRatio flDecayLFRatio flReflectionsGain flReflectionsDelay flLateReverbGain flLateReverbDelay flEchoTime flEchoDepth flModulationTime flModulationDepth flAirAbsorptionGainHF flHFReference flLFReference flRoomRolloffFactor iDecayHFLimit
		density diffusion gain highgain flGainLF? decaytime decayhighratio flDecayLFRatio? earlygain earlydelay lategain latedelay flEchoTime? flEchoDepth? flModulationTime? flModulationDepth? airabsorption flHFReference? flLFReference? roomrolloff highlimit

		-- Default presets.
		GENERIC         1 1 .3162 .8913 1 1.49 .83 1 .05 .007 1.2589 .011 .25 0 .25 0 .9943 50 250 0 true
		PADDEDCELL      .1715 1 .3162 .001 1 .17 .1 1 .25 .001 1.2691 .002 .25 0 .25 0 .9943 50 250 0 true
		ROOM            .4287 1 .3162 .5929 1 .4 .83 1 .1503 .002 1.0629 .003 .25 0 .25 0 .9943 50 250 0 true
		BATHROOM        .1715 1 .3162 .2512 1 1.49 .54 1 .6531 .007 3.2734 .011 .25 0 .25 0 .9943 50 250 0 true
		LIVINGROOM      .9766 1 .3162 .001 1 .5 .1 1 .2051 .003 .2805 .004 .25 0 .25 0 .9943 50 250 0 true
		STONEROOM       1 1 .3162 .7079 1 2.31 .64 1 .4411 .012 1.1003 .017 .25 0 .25 0 .9943 50 250 0 true
		AUDITORIUM      1 1 .3162 .5781 1 4.32 .59 1 .4032 .02 .717 .03 .25 0 .25 0 .9943 50 250 0 true
		CONCERTHALL     1 1 .3162 .5623 1 3.92 .7 1 .2427 .02 .9977 .029 .25 0 .25 0 .9943 50 250 0 true
		CAVE            1 1 .3162 1 1 2.91 1.3 1 .5 .015 .7063 .022 .25 0 .25 0 .9943 50 250 0 false
		ARENA           1 1 .3162 .4477 1 7.24 .33 1 .2612 .02 1.0186 .03 .25 0 .25 0 .9943 50 250 0 true
		HANGAR          1 1 .3162 .3162 1 10.05 .23 1 .5 .02 1.256 .03 .25 0 .25 0 .9943 50 250 0 true
		CARPETEDHALLWAY .4287 1 .3162 .01 1 .3 .1 1 .1215 .002 .1531 .03 .25 0 .25 0 .9943 50 250 0 true
		HALLWAY         .3645 1 .3162 .7079 1 1.49 .59 1 .2458 .007 1.6615 .011 .25 0 .25 0 .9943 50 250 0 true
		STONECORRIDOR   1 1 .3162 .7612 1 2.7 .79 1 .2472 .013 1.5758 .02 .25 0 .25 0 .9943 50 250 0 true
		ALLEY           1 .3 .3162 .7328 1 1.49 .86 1 .25 .007 .9954 .011 .125 .95 .25 0 .9943 50 250 0 true
		CITY            1 .5 .3162 .3981 1 1.49 .67 1 .073 .007 .1427 .011 .25 0 .25 0 .9943 50 250 0 true
		PARKINGLOT      1 1 .3162 1 1 1.65 1.5 1 .2082 .008 .2652 .012 .25 0 .25 0 .9943 50 250 0 false
		FOREST          1 .3 .3162 .0224 1 1.49 .54 1 .0525 .162 .7682 .088 .125 1 .25 0 .9943 50 250 0 true
		MOUNTAINS       1 .27 .3162 .0562 1 1.49 .21 1 .0407 .3 .1919 .1 .25 1 .25 0 .9943 50 250 0 false
		PLAIN           1 .21 .3162 .1 1 1.49 .5 1 .0585 .179 .1089 .1 .25 1 .25 0 .9943 50 250 0 true
		QUARRY          1 1 .3162 .3162 1 1.49 .83 1 0 .061 1.7783 .025 .125 .7 .25 0 .9943 50 250 0 true
		SEWERPIPE       .3071 .8 .3162 .3162 1 2.81 .14 1 1.6387 .014 3.2471 .021 .25 0 .25 0 .9943 50 250 0 true
		UNDERWATER      .3645 1 .3162 .01 1 1.49 .1 1 .5963 .007 7.0795 .011 .25 0 1.18 .348 .9943 50 250 0 true
		DRUGGED         .4287 .5 .3162 1 1 8.39 1.39 1 .876 .002 3.1081 .03 .25 0 .25 1 .9943 50 250 0 false
		DIZZY           .3645 .6 .3162 .631 1 17.23 .56 1 .1392 .02 .4937 .03 .25 1 .81 .31 .9943 50 250 0 false
		PSYCHOTIC       .0625 .5 .3162 .8404 1 7.56 .91 1 .4864 .02 2.4378 .03 .25 0 4 1 .9943 50 250 0 false

		-- Castle presets.
		CASTLE_SMALLROOM    1 .89 .3162 .3981 .1 1.22 .83 .31 .8913 .022 1.9953 .011 .138 .08 .25 0 .9943 5168 139.5 0 true
		CASTLE_MEDIUMROOM   1 .93 .3162 .2818 .1 2.04 .83 .46 .631 .022 1.5849 .011 .155 .03 .25 0 .9943 5168 139.5 0 true
		CASTLE_LARGEROOM    1 .82 .3162 .2818 .1259 2.53 .83 .5 .4467 .034 1.2589 .016 .185 .07 .25 0 .9943 5168 139.5 0 true
		CASTLE_SHORTPASSAGE 1 .89 .3162 .3162 .1 2.32 .83 .31 .8913 .007 1.2589 .023 .138 .08 .25 0 .9943 5168 139.5 0 true
		CASTLE_LONGPASSAGE  1 .89 .3162 .3981 .1 3.42 .83 .31 .8913 .007 1.4125 .023 .138 .08 .25 0 .9943 5168 139.5 0 true
		CASTLE_HALL         1 .81 .3162 .2818 .1778 3.14 .79 .62 .1778 .056 1.122 .024 .25 0 .25 0 .9943 5168 139.5 0 true
		CASTLE_CUPBOARD     1 .89 .3162 .2818 .1 .67 .87 .31 1.4125 .01 3.5481 .007 .138 .08 .25 0 .9943 5168 139.5 0 true
		CASTLE_COURTYARD    1 .42 .3162 .4467 .1995 2.13 .61 .23 .2239 .16 .7079 .036 .25 .37 .25 0 .9943 50 250 0 false
		CASTLE_ALCOVE       1 .89 .3162 .5012 .1 1.64 .87 .31 1 .007 1.4125 .034 .138 .08 .25 0 .9943 5168 139.5 0 true

		-- Factory presets.
		FACTORY_SMALLROOM    .3645 .82 .3162 .7943 .5012 1.72 .65 1.31 .7079 .01 1.7783 .024 .119 .07 .25 0 .9943 3762 362.5 0 true
		FACTORY_MEDIUMROOM   .4287 .82 .2512 .7943 .5012 2.76 .65 1.31 .2818 .022 1.4125 .023 .174 .07 .25 0 .9943 3762 362.5 0 true
		FACTORY_LARGEROOM    .4287 .75 .2512 .7079 .631 4.24 .51 1.31 .1778 .039 1.122 .023 .231 .07 .25 0 .9943 3762 362.5 0 true
		FACTORY_SHORTPASSAGE .3645 .64 .2512 .7943 .5012 2.53 .65 1.31 1 .01 1.2589 .038 .135 .23 .25 0 .9943 3762 362.5 0 true
		FACTORY_LONGPASSAGE  .3645 .64 .2512 .7943 .5012 4.06 .65 1.31 1 .02 1.2589 .037 .135 .23 .25 0 .9943 3762 362.5 0 true
		FACTORY_HALL         .4287 .75 .3162 .7079 .631 7.43 .51 1.31 .0631 .073 .8913 .027 .25 .07 .25 0 .9943 3762 362.5 0 true
		FACTORY_CUPBOARD     .3071 .63 .2512 .7943 .5012 .49 .65 1.31 1.2589 .01 1.9953 .032 .107 .07 .25 0 .9943 3762 362.5 0 true
		FACTORY_COURTYARD    .3071 .57 .3162 .3162 .631 2.32 .29 .56 .2239 .14 .3981 .039 .25 .29 .25 0 .9943 3762 362.5 0 true
		FACTORY_ALCOVE       .3645 .59 .2512 .7943 .5012 3.14 .65 1.31 1.4125 .01 1 .038 .114 .1 .25 0 .9943 3762 362.5 0 true

		-- Ice palace presets.
		ICEPALACE_SMALLROOM    1 .84 .3162 .5623 .2818 1.51 1.53 .27 .8913 .01 1.4125 .011 .164 .14 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_MEDIUMROOM   1 .87 .3162 .5623 .4467 2.22 1.53 .32 .3981 .039 1.122 .027 .186 .12 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_LARGEROOM    1 .81 .3162 .5623 .4467 3.14 1.53 .32 .2512 .039 1 .027 .214 .11 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_SHORTPASSAGE 1 .75 .3162 .5623 .2818 1.79 1.46 .28 .5012 .01 1.122 .019 .177 .09 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_LONGPASSAGE  1 .77 .3162 .5623 .3981 3.01 1.46 .28 .7943 .012 1.2589 .025 .186 .04 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_HALL         1 .76 .3162 .4467 .5623 5.49 1.53 .38 .1122 .054 .631 .052 .226 .11 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_CUPBOARD     1 .83 .3162 .5012 .2239 .76 1.53 .26 1.122 .012 1.9953 .016 .143 .08 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_COURTYARD    1 .59 .3162 .2818 .3162 2.04 1.2 .38 .3162 .173 .3162 .043 .235 .48 .25 0 .9943 12428.5 99.6 0 true
		ICEPALACE_ALCOVE       1 .84 .3162 .5623 .2818 2.76 1.46 .28 1.122 .01 .8913 .03 .161 .09 .25 0 .9943 12428.5 99.6 0 true

		-- Space station presets.
		SPACESTATION_SMALLROOM    .2109 .7 .3162 .7079 .8913 1.72 .82 .55 .7943 .007 1.4125 .013 .188 .26 .25 0 .9943 3316 458.2 0 true
		SPACESTATION_MEDIUMROOM   .2109 .75 .3162 .631 .8913 3.01 .5 .55 .3981 .034 1.122 .035 .209 .31 .25 0 .9943 3316 458.2 0 true
		SPACESTATION_LARGEROOM    .3645 .81 .3162 .631 .8913 3.89 .38 .61 .3162 .056 .8913 .035 .233 .28 .25 0 .9943 3316 458.2 0 true
		SPACESTATION_SHORTPASSAGE .2109 .87 .3162 .631 .8913 3.57 .5 .55 1 .012 1.122 .016 .172 .2 .25 0 .9943 3316 458.2 0 true
		SPACESTATION_LONGPASSAGE  .4287 .82 .3162 .631 .8913 4.62 .62 .55 1 .012 1.2589 .031 .25 .23 .25 0 .9943 3316 458.2 0 true
		SPACESTATION_HALL         .4287 .87 .3162 .631 .8913 7.11 .38 .61 .1778 .1 .631 .047 .25 .25 .25 0 .9943 3316 458.2 0 true
		SPACESTATION_CUPBOARD     .1715 .56 .3162 .7079 .8913 .79 .81 .55 1.4125 .007 1.7783 .018 .181 .31 .25 0 .9943 3316 458.2 0 true
		SPACESTATION_ALCOVE       .2109 .78 .3162 .7079 .8913 1.16 .81 .55 1.4125 .007 1 .018 .192 .21 .25 0 .9943 3316 458.2 0 true

		-- Wooden galleon presets.
		WOODEN_SMALLROOM    1 1 .3162 .1122 .3162 .79 .32 .87 1 .032 .8913 .029 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_MEDIUMROOM   1 1 .3162 .1 .2818 1.47 .42 .82 .8913 .049 .8913 .029 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_LARGEROOM    1 1 .3162 .0891 .2818 2.65 .33 .82 .8913 .066 .7943 .049 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_SHORTPASSAGE 1 1 .3162 .1259 .3162 1.75 .5 .87 .8913 .012 .631 .024 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_LONGPASSAGE  1 1 .3162 .1 .3162 1.99 .4 .79 1 .02 .4467 .036 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_HALL         1 1 .3162 .0794 .2818 3.45 .3 .82 .8913 .088 .7943 .063 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_CUPBOARD     1 1 .3162 .1413 .3162 .56 .46 .91 1.122 .012 1.122 .028 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_COURTYARD    1 .65 .3162 .0794 .3162 1.79 .35 .79 .5623 .123 .1 .032 .25 0 .25 0 .9943 4705 99.6 0 true
		WOODEN_ALCOVE       1 1 .3162 .1259 .3162 1.22 .62 .91 1.122 .012 .7079 .024 .25 0 .25 0 .9943 4705 99.6 0 true

		-- Sports presets.
		SPORT_EMPTYSTADIUM      1 1 .3162 .4467 .7943 6.26 .51 1.1 .0631 .183 .3981 .038 .25 0 .25 0 .9943 50 250 0 true
		SPORT_FULLSTADIUM       1 1 .3162 .0708 .7943 5.25 .17 .8 .1 .188 .2818 .038 .25 0 .25 0 .9943 50 250 0 true
		SPORT_STADIUMTANNOY     1 .78 .3162 .5623 .5012 2.53 .88 .68 .2818 .23 .5012 .063 .25 .2 .25 0 .9943 50 250 0 true
		SPORT_SQUASHCOURT       1 .75 .3162 .3162 .7943 2.22 .91 1.16 .4467 .007 .7943 .011 .126 .19 .25 0 .9943 7176 211.2 0 true
		SPORT_SMALLSWIMMINGPOOL 1 .7 .3162 .7943 .8913 2.76 1.25 1.14 .631 .02 .7943 .03 .179 .15 .895 .19 .9943 50 250 0 false
		SPORT_LARGESWIMMINGPOOL 1 .82 .3162 .7943 1 5.49 1.31 1.14 .4467 .039 .5012 .049 .222 .55 1.159 .21 .9943 50 250 0 false
		SPORT_GYMNASIUM         1 .81 .3162 .4467 .8913 3.14 1.06 1.35 .3981 .029 .5623 .045 .146 .14 .25 0 .9943 7176 211.2 0 true

		-- Prefab presets.
		PREFAB_WORKSHOP     .4287 1 .3162 .1413 .3981 .76 1 1 1 .012 1.122 .012 .25 0 .25 0 .9943 50 250 0 false
		PREFAB_SCHOOLROOM   .4022 .69 .3162 .631 .5012 .98 .45 .18 1.4125 .017 1.4125 .015 .095 .14 .25 0 .9943 7176 211.2 0 true
		PREFAB_PRACTISEROOM .4022 .87 .3162 .3981 .5012 1.12 .56 .18 1.2589 .01 1.4125 .011 .095 .14 .25 0 .9943 7176 211.2 0 true
		PREFAB_OUTHOUSE     1 .82 .3162 .1122 .1585 1.38 .38 .35 .8913 .024 .631 .044 .121 .17 .25 0 .9943 2854 107.5 0 false
		PREFAB_CARAVAN      1 1 .3162 .0891 .1259 .43 1.5 1 1 .012 1.9953 .012 .25 0 .25 0 .9943 50 250 0 false

		-- Dome and pipe presets.
		DOME_TOMB       1 .79 .3162 .3548 .2239 4.18 .21 .1 .3868 .03 1.6788 .022 .177 .19 .25 0 .9943 2854 20 0 false
		DOME_SAINTPAULS 1 .87 .3162 .3548 .2239 10.48 .19 .1 .1778 .09 1.2589 .042 .25 .12 .25 0 .9943 2854 20 0 true
		PIPE_SMALL      1 1 .3162 .3548 .2239 5.04 .1 .1 .5012 .032 2.5119 .015 .25 0 .25 0 .9943 2854 20 0 true
		PIPE_LONGTHIN   .256 .91 .3162 .4467 .2818 9.21 .18 .1 .7079 .01 .7079 .022 .25 0 .25 0 .9943 2854 20 0 false
		PIPE_LARGE      1 1 .3162 .3548 .2239 8.45 .1 .1 .3981 .046 1.5849 .032 .25 0 .25 0 .9943 2854 20 0 true
		PIPE_RESONANT   .1373 .91 .3162 .4467 .2818 6.81 .18 .1 .7079 .01 1 .022 .25 0 .25 0 .9943 2854 20 0 false

		-- Outdoors presets.
		OUTDOORS_BACKYARD      1 .45 .3162 .2512 .5012 1.12 .34 .46 .4467 .069 .7079 .023 .218 .34 .25 0 .9943 4399 242.9 0 false
		OUTDOORS_ROLLINGPLAINS 1 0 .3162 .0112 .631 2.13 .21 .46 .1778 .3 .4467 .019 .25 1 .25 0 .9943 4399 242.9 0 false
		OUTDOORS_DEEPCANYON    1 .74 .3162 .1778 .631 3.89 .21 .46 .3162 .223 .3548 .019 .25 1 .25 0 .9943 4399 242.9 0 false
		OUTDOORS_CREEK         1 .35 .3162 .1778 .5012 2.13 .21 .46 .3981 .115 .1995 .031 .218 .34 .25 0 .9943 4399 242.9 0 false
		OUTDOORS_VALLEY        1 .28 .3162 .0282 .1585 2.88 .26 .35 .1413 .263 .3981 .1 .25 .34 .25 0 .9943 2854 107.5 0 false

		-- Mood presets.
		MOOD_HEAVEN 1 .94 .3162 .7943 .4467 5.04 1.12 .56 .2427 .02 1.2589 .029 .25 .08 2.742 .05 .9977 50 250 0 true
		MOOD_HELL   1 .57 .3162 .3548 .4467 3.57 .49 2 0 .02 1.4125 .03 .11 .04 2.109 .52 .9943 50 139.5 0 false
		MOOD_MEMORY 1 .85 .3162 .631 .3548 4.06 .82 .56 .0398 0 1.122 0 .25 0 .474 .45 .9886 50 250 0 false

		-- Driving presets.
		DRIVING_COMMENTATOR     1     0   .3162 .5623 .5012 2.42 .88  .68  .1995  .093 .2512  .017 .25  1   .25 0 .9886 50    250   0 true
		DRIVING_PITGARAGE       .4287 .59 .3162 .7079 .5623 1.72 .93  .87  .5623  0    1.2589 .016 .25  .11 .25 0 .9943 50    250   0 false
		DRIVING_INCAR_RACER     .0832 .8  .3162 1     .7943 .17  2    .41  1.7783 .007 .7079  .015 .25  0   .25 0 .9943 10268 251   0 true
		DRIVING_INCAR_SPORTS    .0832 .8  .3162 .631  1     .17  .75  .41  1      .01  .5623  0    .25  0   .25 0 .9943 10268 251   0 true
		DRIVING_INCAR_LUXURY    .256  1   .3162 .1    .5012 .13  .41  .46  .7943  .01  1.5849 .01  .25  0   .25 0 .9943 10268 251   0 true
		DRIVING_FULLGRANDSTAND  1     1   .3162 .2818 .631  3.01 1.37 1.28 .3548  .09  .1778  .049 .25  0   .25 0 .9943 10420 250   0 false
		DRIVING_EMPTYGRANDSTAND 1     1   .3162 1     .7943 4.62 1.75 1.4  .2082  .09  .2512  .049 .25  0   .25 0 .9943 10420 250   0 false
		DRIVING_TUNNEL          1     .81 .3162 .3981 .8913 3.42 .94  1.31 .7079  .051 .7079  .047 .214 .05 .25 0 .9943 50    155.3 0 true

		-- City presets.
		CITY_STREETS   1 .78 .3162 .7079 .8913 1.79 1.12 .91 .2818 .046 .1995   .028 .25  .2  .25 0 .9943 50   250   0 true
		CITY_SUBWAY    1 .74 .3162 .7079 .8913 3.01 1.23 .91 .7079 .046  1.2589 .028 .125 .21 .25 0 .9943 50   250   0 true
		CITY_MUSEUM    1 .82 .3162 .1778 .1778 3.28 1.4  .57 .2512 .039 .8913   .034 .13  .17 .25 0 .9943 2854 107.5 0 false
		CITY_LIBRARY   1 .82 .3162 .2818 .0891 2.76 .89  .41 .3548 .029 .8913   .02  .13  .17 .25 0 .9943 2854 107.5 0 false
		CITY_UNDERPASS 1 .82 .3162 .4467 .8913 3.57 1.12 .91 .3981 .059 .8913   .037 .25  .14 .25 0 .992  50   250   0 true
		CITY_ABANDONED 1 .69 .3162 .7943 .8913 3.28 1.17 .91 .4467 .044 .2818   .024 .25  .2  .25 0 .9966 50   250   0 true

		-- Misc. presets.
		DUSTYROOM      .3645 .56 .3162 .7943 .7079 1.79 .38  .21  .5012 .002 1.2589 .006 .202 .05 .25  0   .9886 13046 163.3 0 true
		CHAPEL         1     .84 .3162 .5623 1     4.62 .64  1.23 .4467 .032 .7943  .049 .25  0   .25  .11 .9943 50    250   0 true
		SMALLWATERROOM 1     .7  .3162 .4477 1     1.51 1.25 1.14 .8913 .02  1.4125 .03  .179 .15 .895 .19 .992  50    250   0 false
	]],

	echo = {
		{title="Plenty", params={volume=.338, delay=.1491, tapdelay=.1, damping=.5, feedback=.6344, spread=.1952}},
		{title="Some", params={volume=.2217, delay=.06997, tapdelay=.03414, damping=.1669, feedback=.2986, spread=-.01352}},
		{title="Tube", params={volume=.4016, delay=.03331, tapdelay=.009955, damping=.823, feedback=.8438, spread=-.3246}},
	},

	ringmodulator = {
		{title="Deep robot", params={volume=1, frequency=41.31, highcut=123.9, waveform="sine"}},
		{title="Radio chatter", params={volume=1, frequency=1657, highcut=69.70, waveform="sine"}},
	},

	distortion = {
		{title="Electric guitar", params={volume=.7521, edge=.5138, gain=.4643, lowcut=2933, center=536.1, bandwidth=2933}},
		{title="The worst speaker", params={volume=1, edge=.5602, gain=.3696, lowcut=5657, center=2696, bandwidth=5523}},
	},
}
