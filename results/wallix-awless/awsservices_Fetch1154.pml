#define not_found_addParentsFnsL"user"L119723  ??
#define not_found_list119621  ??
#define not_found_addParentsFnsL"group"L121923  ??
#define not_found_list121821  ??
#define not_found_addParentsFnsL"role"L124123  ??
#define not_found_list124021  ??
#define not_found_addParentsFnsL"policy"L126323  ??
#define not_found_list126221  ??
#define not_found_addParentsFnsL"accesskey"L128523  ??
#define not_found_list128421  ??
#define not_found_addParentsFnsL"instanceprofile"L130723  ??
#define not_found_list130621  ??
#define not_found_addParentsFnsL"mfadevice"L132923  ??
#define not_found_list132821  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example710248287/aws/services/gen_services.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
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
				for(i : 0.. not_found_list119621-1) {
			for20: skip;
						for(i : 0.. not_found_addParentsFnsL"user"L119723-1) {
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
				for(i : 0.. not_found_list121821-1) {
			for30: skip;
						for(i : 0.. not_found_addParentsFnsL"group"L121923-1) {
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
				for(i : 0.. not_found_list124021-1) {
			for40: skip;
						for(i : 0.. not_found_addParentsFnsL"role"L124123-1) {
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
				for(i : 0.. not_found_list126221-1) {
			for50: skip;
						for(i : 0.. not_found_addParentsFnsL"policy"L126323-1) {
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
				for(i : 0.. not_found_list128421-1) {
			for60: skip;
						for(i : 0.. not_found_addParentsFnsL"accesskey"L128523-1) {
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
				for(i : 0.. not_found_list130621-1) {
			for70: skip;
						for(i : 0.. not_found_addParentsFnsL"instanceprofile"L130723-1) {
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
				for(i : 0.. not_found_list132821-1) {
			for80: skip;
						for(i : 0.. not_found_addParentsFnsL"mfadevice"L132923-1) {
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
	run go_Anonymous7(errc,wg);
	do
	:: errc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: errc.async_rcv?0;
			:: errc.sync?0;
			fi;
			for90: skip;
			for90_end: skip
		fi
	od;
	for90_exit: skip;
	

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
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
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
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
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
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
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
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
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
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
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
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
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
	

	if
	:: true -> 
		

		if
		:: errc.async_send!0;
		:: errc.sync!0 -> 
			errc.sending?0
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
	wg.Wait?0;
	errc.closing!true;
	stop_process: skip
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
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

