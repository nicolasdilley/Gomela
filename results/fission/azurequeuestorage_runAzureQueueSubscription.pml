#define lb_for292_0  -1
#define ub_for292_1  -1
#define lb_for267_2  -1
#define ub_for267_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example768287099/pkg/mqtrigger/messageQueue/azurequeuestorage/asq.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	chan child_azurequeuestoragepollAzureQueueSubscription0 = [0] of {int};
	bool state = false;
	run wgMonitor(wg);
	run azurequeuestoragepollAzureQueueSubscription(wg,child_azurequeuestoragepollAzureQueueSubscription0);
	child_azurequeuestoragepollAzureQueueSubscription0?0;
	do
	:: true -> 
for20:		do
		:: true -> 
			wg.Wait?0;
			goto stop_process
		:: true -> 
			chan child_azurequeuestoragepollAzureQueueSubscription1 = [0] of {int};
			run azurequeuestoragepollAzureQueueSubscription(child_azurequeuestoragepollAzureQueueSubscription1);
			child_azurequeuestoragepollAzureQueueSubscription1?0
		od
	od;
for20_exit:
stop_process:}

proctype azurequeuestoragepollAzureQueueSubscription(Wgdef wg;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		wg.Add!messages;
		do
		:: true -> 
for11:			run Anonymous1()
		:: true -> 
			break
		od
	od;
for10_exit:	child!0;
stop_process:
}
proctype Anonymous1() {
	bool closed; 
	int i;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
stop_process:
}
