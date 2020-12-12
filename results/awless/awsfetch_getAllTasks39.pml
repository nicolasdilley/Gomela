#define getAllTasks_clusterArns  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example018730929/aws/fetch/ecs_helpers.go
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
	Chandef tasksNamesc;
	int clusterArns = getAllTasks_clusterArns;
	Chandef tasksc;
	bool state = false;
	Wgdef wg;
	Wgdef tasksWG;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(tasksNamesc);
	run wgMonitor(wg);
		for(i : 0.. clusterArns-1) {
for10:		wg.Add!1;
		run Anonymous0(tasksNamesc,tasksc,wg,tasksWG);
		wg.Add!1;
		run Anonymous1(tasksNamesc,tasksc,wg,tasksWG)
	};
	run sync_monitor(tasksc);
	run wgMonitor(tasksWG);
	tasksWG.Add!1;
	run Anonymous2(tasksNamesc,tasksc,wg,tasksWG);
	run Anonymous3(tasksNamesc,tasksc,wg,tasksWG);
	do
	:: tasksc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: tasksc.async_rcv?0;
			:: tasksc.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: tasksNamesc.async_send!0;
		:: tasksNamesc.sync!0 -> 
			tasksNamesc.sending?0
		fi
	:: true;
	fi;
stop_process:	wg.Add!-1
}
proctype Anonymous1(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: tasksNamesc.async_send!0;
		:: tasksNamesc.sync!0 -> 
			tasksNamesc.sending?0
		fi
	:: true;
	fi;
stop_process:	wg.Add!-1
}
proctype Anonymous2(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	bool state;
	do
	:: tasksNamesc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: tasksNamesc.async_rcv?0;
			:: tasksNamesc.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: tasksc.async_send!0;
				:: tasksc.sync!0 -> 
					tasksc.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			tasksWG.Add!1;
			run Anonymous2(tasksNamesc,tasksc,wg,tasksWG)
		fi
	od;
stop_process:	tasksWG.Add!-1
}
proctype Anonymous3(Chandef tasksNamesc;Chandef tasksc;Wgdef wg;Wgdef tasksWG) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	tasksNamesc.closing!true;
	tasksWG.Wait?0;
	tasksc.closing!true;
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

