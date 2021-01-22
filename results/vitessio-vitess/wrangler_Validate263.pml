#define Validate_keyspaces  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example983313288/go/vt/wrangler/validator.go
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
	chan child_waitForResults0 = [0] of {int};
	Wgdef wg;
	Chandef results;
	int num_msgs = 0;
	bool state = false;
	int i;
	int keyspaces = Validate_keyspaces;
	

	if
	:: 16 > 0 -> 
		results.size = 16;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run wgMonitor(wg);
	wg.Add!1;
	run go_Anonymous0(results,wg);
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!false,0 -> 
			results.sending?state
		fi
	:: true -> 
				for(i : 0.. keyspaces-1) {
			for30: skip;
			wg.Add!1;
			run go_Anonymous3(results,wg);
			for30_end: skip
		};
		for30_exit: skip
	fi;
	run waitForResults(wg,results,child_waitForResults0);
	child_waitForResults0?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_validateAllTablets0 = [0] of {int};
	run validateAllTablets(wg,results,child_validateAllTablets0);
	child_validateAllTablets0?0;
	stop_process: skip;
	wg.Add!-1
}
proctype validateAllTablets(Wgdef wg;Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int cellSet = 1;
	int aliases = 0;
	int shards=3;
	int keyspaces=3;
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!false,0 -> 
			results.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: keyspaces-1 != -3 -> 
				for(i : 0.. keyspaces-1) {
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!false,0 -> 
					results.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: shards-1 != -3 -> 
								for(i : 0.. shards-1) {
					for11: skip;
					

					if
					:: true -> 
						

						if
						:: results.async_send!0;
						:: results.sync!false,0 -> 
							results.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for11469: skip;
					

					if
					:: true -> 
						

						if
						:: results.async_send!0;
						:: results.sync!false,0 -> 
							results.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for11_end469: skip
				:: true -> 
					break
				od;
				for11_exit469: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10470: skip;
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!false,0 -> 
					results.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: shards-1 != -3 -> 
								for(i : 0.. shards-1) {
					for11470: skip;
					

					if
					:: true -> 
						

						if
						:: results.async_send!0;
						:: results.sync!false,0 -> 
							results.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for11_end470: skip
				};
				for11_exit470: skip
			:: else -> 
				do
				:: true -> 
					for11469470: skip;
					

					if
					:: true -> 
						

						if
						:: results.async_send!0;
						:: results.sync!false,0 -> 
							results.sending?state
						fi;
						goto stop_process
					:: true;
					fi;
					for11_end469470: skip
				:: true -> 
					break
				od;
				for11_exit469470: skip
			fi;
			for10_end470: skip
		:: true -> 
			break
		od;
		for10_exit470: skip
	fi;
		for(i : 0.. cellSet-1) {
		for20: skip;
		

		if
		:: true -> 
			

			if
			:: results.async_send!0;
			:: results.sync!false,0 -> 
				results.sending?state
			fi;
			goto for20_end
		:: true;
		fi;
				for(i : 0.. aliases-1) {
			for21: skip;
			wg.Add!1;
			run go_Anonymous2(results);
			for21_end: skip
		};
		for21_exit: skip;
		for20_end: skip
	};
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!false,0 -> 
			results.sending?state
		fi
	fi;
	stop_process: skip
}
proctype go_Anonymous3(Chandef results;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_validateKeyspace0 = [0] of {int};
	run validateKeyspace(wg,results,child_validateKeyspace0);
	child_validateKeyspace0?0;
	stop_process: skip;
	wg.Add!-1
}
proctype validateKeyspace(Wgdef wg;Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int shards = 1;
	

	if
	:: true -> 
		

		if
		:: results.async_send!0;
		:: results.sync!false,0 -> 
			results.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
		for(i : 0.. shards-1) {
		for31: skip;
		wg.Add!1;
		run go_Anonymous5(results);
		for31_end: skip
	};
	for31_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous5(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip
}
proctype waitForResults(Wgdef wg;Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	run go_Anonymous7(results);
	do
	:: true -> 
		

		if
		:: results.async_rcv?state,num_msgs;
		:: results.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for40: skip;
			for40_end: skip
		fi
	od;
	for40_exit: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous7(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	results.closing!true;
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


