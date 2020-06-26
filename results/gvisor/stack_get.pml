
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
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
		
		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			Chandef _ch0;
			chan _ch0_in = [0] of {int};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			_ch0.in = _ch0_in
		:: true;
		fi;
		goto stop_process
	:: true;
	fi
stop_process:}

