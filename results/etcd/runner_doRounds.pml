#define rcs  ??
#define lb_for67_1  -1
#define ub_for67_2  -1
#define lb_for72_3  -1
#define ub_for72_4  -1
#define lb_for83_5  -1
#define ub_for83_6  -1
#define lb_for90_7  -1
#define ub_for90_8  -1

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
	do
	:: true -> 
for10:		run Anonymous0(_ch0)
	od;
	
	if
	:: lb_for90_7 != -1 && ub_for90_8 != -1 -> 
				for(i : lb_for90_7.. ub_for90_8) {
for20:			do
			:: _ch0.in?0 -> 
				break
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: _ch0.in?0 -> 
				break
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	do
	:: true -> 
for30:
	od
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: lb_for67_1 != -1 && ub_for67_2 != -1 -> 
				for(i : lb_for67_1.. ub_for67_2) {
for11:			
			if
			:: lb_for72_3 != -1 && ub_for72_4 != -1 -> 
								for(i : lb_for72_3.. ub_for72_4) {
for12:
				}
			:: else -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
			fi;
for12_exit:			_ch0.in!0;
			
			if
			:: lb_for83_5 != -1 && ub_for83_6 != -1 -> 
								for(i : lb_for83_5.. ub_for83_6) {
for13:
				}
			:: else -> 
				do
				:: true -> 
for13:
				:: true -> 
					break
				od
			fi;
for13_exit:
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: lb_for72_3 != -1 && ub_for72_4 != -1 -> 
								for(i : lb_for72_3.. ub_for72_4) {
for12:
				}
			:: else -> 
				do
				:: true -> 
for12:
				:: true -> 
					break
				od
			fi;
for12_exit:			_ch0.in!0;
			
			if
			:: lb_for83_5 != -1 && ub_for83_6 != -1 -> 
								for(i : lb_for83_5.. ub_for83_6) {
for13:
				}
			:: else -> 
				do
				:: true -> 
for13:
				:: true -> 
					break
				od
			fi;
for13_exit:for13_exit:
		:: true -> 
			break
		od
	fi;
for11_exit:stop_process:
}
