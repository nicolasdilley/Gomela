#define executeOnAllTablets_numOfMasterTablets  0
#define executeOnAllTablets_exec_tablets  1
#define executeOnAllTablets_execResult_SuccessShards  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example983313288/go/vt/schemamanager/tablet_executor.go
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
	Chandef successChan;
	Chandef errChan;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int execResult_SuccessShards = executeOnAllTablets_execResult_SuccessShards;
	int exec_tablets = executeOnAllTablets_exec_tablets;
	int numOfMasterTablets = executeOnAllTablets_numOfMasterTablets;
	run wgMonitor(wg);
	wg.Add!numOfMasterTablets;
	

	if
	:: numOfMasterTablets > 0 -> 
		errChan.size = numOfMasterTablets;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	

	if
	:: numOfMasterTablets > 0 -> 
		successChan.size = numOfMasterTablets;
		run AsyncChan(successChan)
	:: else -> 
		run sync_monitor(successChan)
	fi;
		for(i : 0.. exec_tablets-1) {
		for10: skip;
		run go_Anonymous0(errChan,successChan,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	errChan.closing!true;
	successChan.closing!true;
	do
	:: true -> 
		

		if
		:: errChan.async_rcv?state,num_msgs;
		:: errChan.sync?state,num_msgs;
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
	do
	:: true -> 
		

		if
		:: successChan.async_rcv?state,num_msgs;
		:: successChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. execResult_SuccessShards-1) {
		for40: skip;
		wg.Add!1;
		run go_Anonymous2(errChan,successChan,wg);
		for40_end: skip
	};
	for40_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Chandef errChan;Chandef successChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_executeOneTablet0 = [0] of {int};
	run executeOneTablet(errChan,successChan,child_executeOneTablet0);
	child_executeOneTablet0?0;
	stop_process: skip;
	wg.Add!-1
}
proctype executeOneTablet(Chandef errChan;Chandef successChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errChan.async_send!0;
		:: errChan.sync!false,0 -> 
			errChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errChan.async_send!0;
		:: errChan.sync!false,0 -> 
			errChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: successChan.async_send!0;
	:: successChan.sync!false,0 -> 
		successChan.sending?state
	fi;
	stop_process: skip;
	child!0
}
proctype go_Anonymous2(Chandef errChan;Chandef successChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	wg.Add!-1
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

