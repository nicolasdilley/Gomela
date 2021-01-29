#define not_found_addParentsFnsL"instance"L41923  ??
#define not_found_list41821  ??
#define not_found_addParentsFnsL"subnet"L44123  ??
#define not_found_list44021  ??
#define not_found_addParentsFnsL"vpc"L46323  ??
#define not_found_list46221  ??
#define not_found_addParentsFnsL"keypair"L48523  ??
#define not_found_list48421  ??
#define not_found_addParentsFnsL"securitygroup"L50723  ??
#define not_found_list50621  ??
#define not_found_addParentsFnsL"volume"L52923  ??
#define not_found_list52821  ??
#define not_found_addParentsFnsL"internetgateway"L55123  ??
#define not_found_list55021  ??
#define not_found_addParentsFnsL"natgateway"L57323  ??
#define not_found_list57221  ??
#define not_found_addParentsFnsL"routetable"L59523  ??
#define not_found_list59421  ??
#define not_found_addParentsFnsL"availabilityzone"L61723  ??
#define not_found_list61621  ??
#define not_found_addParentsFnsL"image"L63923  ??
#define not_found_list63821  ??
#define not_found_addParentsFnsL"importimagetask"L66123  ??
#define not_found_list66021  ??
#define not_found_addParentsFnsL"elasticip"L68323  ??
#define not_found_list68221  ??
#define not_found_addParentsFnsL"snapshot"L70523  ??
#define not_found_list70421  ??
#define not_found_addParentsFnsL"networkinterface"L72723  ??
#define not_found_list72621  ??
#define not_found_addParentsFnsL"classicloadbalancer"L74923  ??
#define not_found_list74821  ??
#define not_found_addParentsFnsL"loadbalancer"L77123  ??
#define not_found_list77021  ??
#define not_found_addParentsFnsL"targetgroup"L79323  ??
#define not_found_list79221  ??
#define not_found_addParentsFnsL"listener"L81523  ??
#define not_found_list81421  ??
#define not_found_addParentsFnsL"database"L83723  ??
#define not_found_list83621  ??
#define not_found_addParentsFnsL"dbsubnetgroup"L85923  ??
#define not_found_list85821  ??
#define not_found_addParentsFnsL"launchconfiguration"L88123  ??
#define not_found_list88021  ??
#define not_found_addParentsFnsL"scalinggroup"L90323  ??
#define not_found_list90221  ??
#define not_found_addParentsFnsL"scalingpolicy"L92523  ??
#define not_found_list92421  ??
#define not_found_addParentsFnsL"repository"L94723  ??
#define not_found_list94621  ??
#define not_found_addParentsFnsL"containercluster"L96923  ??
#define not_found_list96821  ??
#define not_found_addParentsFnsL"containertask"L99123  ??
#define not_found_list99021  ??
#define not_found_addParentsFnsL"container"L101323  ??
#define not_found_list101221  ??
#define not_found_addParentsFnsL"containerinstance"L103523  ??
#define not_found_list103421  ??
#define not_found_addParentsFnsL"certificate"L105723  ??
#define not_found_list105621  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example582553626/aws/services/gen_services.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	Chandef errc;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errc);
	run wgMonitor(wg);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list41821-1) {
			for20: skip;
						for(i : 0.. not_found_addParentsFnsL"instance"L41923-1) {
				for21: skip;
				wg.Add!1;
				run go_Anonymous0(errc,wg);
				for21_end: skip
			};
			for21_exit: skip;
			for20_end: skip
		};
		for20_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list44021-1) {
			for30: skip;
						for(i : 0.. not_found_addParentsFnsL"subnet"L44123-1) {
				for31: skip;
				wg.Add!1;
				run go_Anonymous1(errc,wg);
				for31_end: skip
			};
			for31_exit: skip;
			for30_end: skip
		};
		for30_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list46221-1) {
			for40: skip;
						for(i : 0.. not_found_addParentsFnsL"vpc"L46323-1) {
				for41: skip;
				wg.Add!1;
				run go_Anonymous2(errc,wg);
				for41_end: skip
			};
			for41_exit: skip;
			for40_end: skip
		};
		for40_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list48421-1) {
			for50: skip;
						for(i : 0.. not_found_addParentsFnsL"keypair"L48523-1) {
				for51: skip;
				wg.Add!1;
				run go_Anonymous3(errc,wg);
				for51_end: skip
			};
			for51_exit: skip;
			for50_end: skip
		};
		for50_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list50621-1) {
			for60: skip;
						for(i : 0.. not_found_addParentsFnsL"securitygroup"L50723-1) {
				for61: skip;
				wg.Add!1;
				run go_Anonymous4(errc,wg);
				for61_end: skip
			};
			for61_exit: skip;
			for60_end: skip
		};
		for60_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list52821-1) {
			for70: skip;
						for(i : 0.. not_found_addParentsFnsL"volume"L52923-1) {
				for71: skip;
				wg.Add!1;
				run go_Anonymous5(errc,wg);
				for71_end: skip
			};
			for71_exit: skip;
			for70_end: skip
		};
		for70_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list55021-1) {
			for80: skip;
						for(i : 0.. not_found_addParentsFnsL"internetgateway"L55123-1) {
				for81: skip;
				wg.Add!1;
				run go_Anonymous6(errc,wg);
				for81_end: skip
			};
			for81_exit: skip;
			for80_end: skip
		};
		for80_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list57221-1) {
			for90: skip;
						for(i : 0.. not_found_addParentsFnsL"natgateway"L57323-1) {
				for91: skip;
				wg.Add!1;
				run go_Anonymous7(errc,wg);
				for91_end: skip
			};
			for91_exit: skip;
			for90_end: skip
		};
		for90_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list59421-1) {
			for100: skip;
						for(i : 0.. not_found_addParentsFnsL"routetable"L59523-1) {
				for101: skip;
				wg.Add!1;
				run go_Anonymous8(errc,wg);
				for101_end: skip
			};
			for101_exit: skip;
			for100_end: skip
		};
		for100_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list61621-1) {
			for110: skip;
						for(i : 0.. not_found_addParentsFnsL"availabilityzone"L61723-1) {
				for111: skip;
				wg.Add!1;
				run go_Anonymous9(errc,wg);
				for111_end: skip
			};
			for111_exit: skip;
			for110_end: skip
		};
		for110_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list63821-1) {
			for120: skip;
						for(i : 0.. not_found_addParentsFnsL"image"L63923-1) {
				for121: skip;
				wg.Add!1;
				run go_Anonymous10(errc,wg);
				for121_end: skip
			};
			for121_exit: skip;
			for120_end: skip
		};
		for120_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list66021-1) {
			for130: skip;
						for(i : 0.. not_found_addParentsFnsL"importimagetask"L66123-1) {
				for131: skip;
				wg.Add!1;
				run go_Anonymous11(errc,wg);
				for131_end: skip
			};
			for131_exit: skip;
			for130_end: skip
		};
		for130_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list68221-1) {
			for140: skip;
						for(i : 0.. not_found_addParentsFnsL"elasticip"L68323-1) {
				for141: skip;
				wg.Add!1;
				run go_Anonymous12(errc,wg);
				for141_end: skip
			};
			for141_exit: skip;
			for140_end: skip
		};
		for140_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list70421-1) {
			for150: skip;
						for(i : 0.. not_found_addParentsFnsL"snapshot"L70523-1) {
				for151: skip;
				wg.Add!1;
				run go_Anonymous13(errc,wg);
				for151_end: skip
			};
			for151_exit: skip;
			for150_end: skip
		};
		for150_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list72621-1) {
			for160: skip;
						for(i : 0.. not_found_addParentsFnsL"networkinterface"L72723-1) {
				for161: skip;
				wg.Add!1;
				run go_Anonymous14(errc,wg);
				for161_end: skip
			};
			for161_exit: skip;
			for160_end: skip
		};
		for160_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list74821-1) {
			for170: skip;
						for(i : 0.. not_found_addParentsFnsL"classicloadbalancer"L74923-1) {
				for171: skip;
				wg.Add!1;
				run go_Anonymous15(errc,wg);
				for171_end: skip
			};
			for171_exit: skip;
			for170_end: skip
		};
		for170_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list77021-1) {
			for180: skip;
						for(i : 0.. not_found_addParentsFnsL"loadbalancer"L77123-1) {
				for181: skip;
				wg.Add!1;
				run go_Anonymous16(errc,wg);
				for181_end: skip
			};
			for181_exit: skip;
			for180_end: skip
		};
		for180_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list79221-1) {
			for190: skip;
						for(i : 0.. not_found_addParentsFnsL"targetgroup"L79323-1) {
				for191: skip;
				wg.Add!1;
				run go_Anonymous17(errc,wg);
				for191_end: skip
			};
			for191_exit: skip;
			for190_end: skip
		};
		for190_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list81421-1) {
			for200: skip;
						for(i : 0.. not_found_addParentsFnsL"listener"L81523-1) {
				for201: skip;
				wg.Add!1;
				run go_Anonymous18(errc,wg);
				for201_end: skip
			};
			for201_exit: skip;
			for200_end: skip
		};
		for200_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list83621-1) {
			for210: skip;
						for(i : 0.. not_found_addParentsFnsL"database"L83723-1) {
				for211: skip;
				wg.Add!1;
				run go_Anonymous19(errc,wg);
				for211_end: skip
			};
			for211_exit: skip;
			for210_end: skip
		};
		for210_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list85821-1) {
			for220: skip;
						for(i : 0.. not_found_addParentsFnsL"dbsubnetgroup"L85923-1) {
				for221: skip;
				wg.Add!1;
				run go_Anonymous20(errc,wg);
				for221_end: skip
			};
			for221_exit: skip;
			for220_end: skip
		};
		for220_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list88021-1) {
			for230: skip;
						for(i : 0.. not_found_addParentsFnsL"launchconfiguration"L88123-1) {
				for231: skip;
				wg.Add!1;
				run go_Anonymous21(errc,wg);
				for231_end: skip
			};
			for231_exit: skip;
			for230_end: skip
		};
		for230_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list90221-1) {
			for240: skip;
						for(i : 0.. not_found_addParentsFnsL"scalinggroup"L90323-1) {
				for241: skip;
				wg.Add!1;
				run go_Anonymous22(errc,wg);
				for241_end: skip
			};
			for241_exit: skip;
			for240_end: skip
		};
		for240_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list92421-1) {
			for250: skip;
						for(i : 0.. not_found_addParentsFnsL"scalingpolicy"L92523-1) {
				for251: skip;
				wg.Add!1;
				run go_Anonymous23(errc,wg);
				for251_end: skip
			};
			for251_exit: skip;
			for250_end: skip
		};
		for250_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list94621-1) {
			for260: skip;
						for(i : 0.. not_found_addParentsFnsL"repository"L94723-1) {
				for261: skip;
				wg.Add!1;
				run go_Anonymous24(errc,wg);
				for261_end: skip
			};
			for261_exit: skip;
			for260_end: skip
		};
		for260_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list96821-1) {
			for270: skip;
						for(i : 0.. not_found_addParentsFnsL"containercluster"L96923-1) {
				for271: skip;
				wg.Add!1;
				run go_Anonymous25(errc,wg);
				for271_end: skip
			};
			for271_exit: skip;
			for270_end: skip
		};
		for270_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list99021-1) {
			for280: skip;
						for(i : 0.. not_found_addParentsFnsL"containertask"L99123-1) {
				for281: skip;
				wg.Add!1;
				run go_Anonymous26(errc,wg);
				for281_end: skip
			};
			for281_exit: skip;
			for280_end: skip
		};
		for280_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list101221-1) {
			for290: skip;
						for(i : 0.. not_found_addParentsFnsL"container"L101323-1) {
				for291: skip;
				wg.Add!1;
				run go_Anonymous27(errc,wg);
				for291_end: skip
			};
			for291_exit: skip;
			for290_end: skip
		};
		for290_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list103421-1) {
			for300: skip;
						for(i : 0.. not_found_addParentsFnsL"containerinstance"L103523-1) {
				for301: skip;
				wg.Add!1;
				run go_Anonymous28(errc,wg);
				for301_end: skip
			};
			for301_exit: skip;
			for300_end: skip
		};
		for300_exit: skip
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. not_found_list105621-1) {
			for310: skip;
						for(i : 0.. not_found_addParentsFnsL"certificate"L105723-1) {
				for311: skip;
				wg.Add!1;
				run go_Anonymous29(errc,wg);
				for311_end: skip
			};
			for311_exit: skip;
			for310_end: skip
		};
		for310_exit: skip
	:: true;
	fi;
	run go_Anonymous30(errc,wg);
	do
	:: true -> 
		

		if
		:: errc.async_rcv?state,num_msgs;
		:: errc.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for320: skip;
			for320_end: skip
		fi
	od;
	for320_exit: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous2(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous3(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous4(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous5(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous6(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous7(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous8(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous9(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous10(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous11(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous12(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous13(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous14(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous15(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous16(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous17(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous18(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous19(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous20(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous21(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous22(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous23(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous24(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous25(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous26(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous27(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous28(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous29(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!false,0 -> 
			errc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous30(Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Wait?0;
	errc.closing!true;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

