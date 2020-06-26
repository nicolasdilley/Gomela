#define lb_for203_0  -1
#define ub_for203_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run go_dnsklexer2(_ch0);
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0;
			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype go_dnsklexer2(Chandef c) {
	bool closed; 
	int i;
	
	if
	:: lb_for203_0 != -1 && ub_for203_1 != -1 -> 
				for(i : lb_for203_0.. ub_for203_1) {
for10:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				fi
			:: true;
			:: true -> 
				c.in!0;
				c.sending?state
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				fi
			:: true;
			:: true -> 
				c.in!0;
				c.sending?state
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		c.in!0;
		c.sending?state
	:: true;
	fi;
	c.closing!true;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
