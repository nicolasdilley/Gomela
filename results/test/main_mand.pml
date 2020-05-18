#define num  ??
#define a  -1
#define opt  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [num] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
		for(i : 0+1.. num_2) {
for10:		run go_mainopt2(_ch0,num,_ch0)
	};
for10_exit:	
	if
	:: 0 != -1 && opt != -1 -> 
				for(i : 0+1.. opt) {
for20:			_ch0.in!0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in!0
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype go_mainopt2(Chandef a;int num_1;int a_1) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && num_1 != -1 -> 
				for(i : 0+1.. num_1) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	
	if
	:: 0 != -1 && a_1 != -1 -> 
				for(i : 0+1.. a_1) {
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
for12_exit:stop_process:
}
