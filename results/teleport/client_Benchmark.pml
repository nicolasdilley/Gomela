#define lb_for90_0  -1
#define ub_for90_1  -1
#define lb_for117_2  -1
#define ub_for117_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [bench.Threads] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
		for(i : 0.. bench.Threads-1) {
for10:
	};
for10_exit:	run Anonymous0(_ch0,_ch1);
	do
	:: true -> 
for30:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		:: _ch1.in?0 -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi;
			break
		od
	od;
for30_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: true -> 
			do
			:: _ch0.in!0 -> 
				break
			:: true -> 
				goto stop_process
			od;
			break
		:: true -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
}
