#define testRecords_num  1
#define testRecords_int1909  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example290997538/stresser/stresser.go
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
	Chandef rc;
	Chandef work;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int int1909 = testRecords_int1909;
	int num = testRecords_num;
	run wgMonitor(wg);
	

	if
	:: num * 50 > 0 -> 
		work.size = num * 50;
		run AsyncChan(work)
	:: else -> 
		run sync_monitor(work)
	fi;
	

	if
	:: num * 30 > 0 -> 
		rc.size = num * 30;
		run AsyncChan(rc)
	:: else -> 
		run sync_monitor(rc)
	fi;
	wg.Add!int1909;
	run go_Anonymous0(work,rc,wg);
	run go_Anonymous1(work,rc,wg);
	do
	:: true -> 
		

		if
		:: rc.async_rcv?state,num_msgs;
		:: rc.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			for30_end: skip
		fi
	od;
	for30_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef work;Chandef rc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Wait?0;
	rc.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef work;Chandef rc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int uint21012=0;
	int limit=0;
	

	if
	:: uint21012 != -2 && limit-1 != -3 -> 
				for(i : uint21012.. limit-1) {
			for201682: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end1682
			:: true;
			fi;
			

			if
			:: work.async_send!0;
			:: work.sync!false,0 -> 
				work.sending?state
			fi;
			for20_end1682: skip
		};
		for20_exit1682: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			

			if
			:: work.async_send!0;
			:: work.sync!false,0 -> 
				work.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	work.closing!true;
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


