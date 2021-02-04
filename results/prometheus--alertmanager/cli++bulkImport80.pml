#define bulkImport_c_workers  3
#define ub_for120_1  -2

// https://github.com/prometheus/alertmanager/blob/3f46b62d75da4d68d2098388797e6a61fcc5e043/cli/silence_import.go#L80
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
	Chandef silencec;
	int num_msgs = 0;
	bool state = false;
	int i;
	int c_workers = bulkImport_c_workers;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 100 > 0 -> 
		silencec.size = 100;
		run AsyncChan(silencec)
	:: else -> 
		run sync_monitor(silencec)
	fi;
	

	if
	:: 100 > 0 -> 
		errc.size = 100;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run wgMonitor(wg);
		for(i : 0.. c_workers-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(silencec,errc,wg);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous2(silencec,errc,wg);
	

	if
	:: 0 != -2 && ub_for120_1 != -2 -> 
				for(i : 0.. ub_for120_1) {
			for30693: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: silencec.async_send!0;
			:: silencec.sync!false,0 -> 
				silencec.sending?state
			fi;
			for30_end693: skip
		};
		for30_exit693: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: silencec.async_send!0;
			:: silencec.sync!false,0 -> 
				silencec.sending?state
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	silencec.closing!true;
	wg.Wait?0;
	errc.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef silencec;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cliaddSilenceWorker0 = [0] of {int};
	run cliaddSilenceWorker(silencec,errc,child_cliaddSilenceWorker0);
	child_cliaddSilenceWorker0?0;
	wg.Add!-1;
	stop_process: skip
}
proctype cliaddSilenceWorker(Chandef silencec;Chandef errc;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: silencec.async_rcv?state,num_msgs;
		:: silencec.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: errc.async_send!0;
			:: errc.sync!false,0 -> 
				errc.sending?state
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef silencec;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
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

