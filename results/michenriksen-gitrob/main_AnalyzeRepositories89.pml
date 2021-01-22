#define AnalyzeRepositories_sess_Repositories  0
#define AnalyzeRepositories_threadNum  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example183824376/main.go
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
	Chandef ch;
	int num_msgs = 0;
	bool state = false;
	int i;
	int threadNum = AnalyzeRepositories_threadNum;
	int sess_Repositories = AnalyzeRepositories_sess_Repositories;
	

	if
	:: sess_Repositories > 0 -> 
		ch.size = sess_Repositories;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run wgMonitor(wg);
	wg.Add!threadNum;
		for(i : 0.. threadNum-1) {
		for10: skip;
		run go_Anonymous0(ch,wg);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: sess_Repositories-1 != -3 -> 
				for(i : 0.. sess_Repositories-1) {
			for20: skip;
			

			if
			:: ch.async_send!0;
			:: ch.sync!false,0 -> 
				ch.sending?state
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for201228: skip;
			

			if
			:: ch.async_send!0;
			:: ch.sync!false,0 -> 
				ch.sending?state
			fi;
			for20_end1228: skip
		:: true -> 
			break
		od;
		for20_exit1228: skip
	fi;
	ch.closing!true;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Chandef ch;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		

		if
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
		fi;
		

		if
		:: true -> 
			wg.Add!-1;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto for11_end
		:: true;
		fi;
		

		if
		:: true -> 
			goto for11_end
		:: true;
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
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

