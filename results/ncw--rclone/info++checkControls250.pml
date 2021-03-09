#define checkControls_ci_Checkers  0
#define checkControls_rune26011  0
#define not_found_{"＼""\u00A0""\xBF""\xFE"}27620  3

// https://github.com/ncw/rclone/blob/80e63af4703730923a97b65fae4d5b712de846c9/cmd/info/info.go#L250
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
	Chandef tokens;
	int num_msgs = 0;
	bool state = false;
	int i;
	int rune26011 = checkControls_rune26011;
	int ci_Checkers = checkControls_ci_Checkers;
	

	if
	:: ci_Checkers > 0 -> 
		tokens.size = ci_Checkers;
		run AsyncChan(tokens)
	:: else -> 
		run sync_monitor(tokens)
	fi;
	

	if
	:: 0 != -2 && ci_Checkers-1 != -3 -> 
				for(i : 0.. ci_Checkers-1) {
			for101264: skip;
			

			if
			:: tokens.async_send!0;
			:: tokens.sync!false,0 -> 
				tokens.sending?state
			fi;
			for10_end1264: skip
		};
		for10_exit1264: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: tokens.async_send!0;
			:: tokens.sync!false,0 -> 
				tokens.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run wgMonitor(wg);
		for(i : rune26011.. 128-1) {
		for20: skip;
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		wg.Add!1;
		run go_Anonymous0(tokens,wg);
		for20_end: skip
	};
	for20_exit: skip;
		for(i : 0.. not_found_{"＼""\u00A0""\xBF""\xFE"}27620-1) {
		for30: skip;
		wg.Add!1;
		run go_Anonymous1(tokens,wg);
		for30_end: skip
	};
	for30_exit: skip;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Chandef tokens;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: tokens.async_rcv?state,num_msgs;
	:: tokens.sync?state,num_msgs;
	fi;
	

	if
	:: tokens.async_send!0;
	:: tokens.sync!false,0 -> 
		tokens.sending?state
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef tokens;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: tokens.async_rcv?state,num_msgs;
	:: tokens.sync?state,num_msgs;
	fi;
	

	if
	:: tokens.async_send!0;
	:: tokens.sync!false,0 -> 
		tokens.sending?state
	fi;
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

