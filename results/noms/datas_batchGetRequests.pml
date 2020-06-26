#define lb_for257_0  -1
#define ub_for257_1  -1
#define lb_for278_2  -1
#define ub_for278_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	int i;
	chan child_hcsbatchReadRequests21 = [0] of {int};
	bool state = false;
	run hcsbatchReadRequests2(child_hcsbatchReadRequests21);
	child_hcsbatchReadRequests21?0
stop_process:}

proctype hcsbatchReadRequests2(chan child) {
	bool closed; 
	int i;
	run Anonymous1(queue,queue);
	child!0;
stop_process:
}
proctype hcssendReadRequests3(Chandef queue;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for278_2 != -1 && ub_for278_3 != -1 -> 
				for(i : lb_for278_2.. ub_for278_3) {
for11:			do
			:: queue.in?0 -> 
				break
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for11:			do
			:: queue.in?0 -> 
				break
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for11_exit:	hcs_rateLimit.in!0;
	run Anonymous2(queue,queue);
	child!0;
stop_process:
}
proctype Anonymous2(Chandef queue;Chandef queue) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef queue;Chandef queue) {
	bool closed; 
	int i;
		for(i : lb_for257_0.. ub_for257_1) {
for10:		do
		:: queue.in?0 -> 
			chan child_hcssendReadRequests30 = [0] of {int};
			run hcssendReadRequests3(queue,child_hcssendReadRequests30);
			child_hcssendReadRequests30?0;
			break
		:: true -> 
			break
		od
	};
for10_exit:stop_process:
}
