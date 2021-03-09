
// https://github.com/elastic/beats/blob/1327562b17cf06c430a2ad668ba22a3f836606a4/filebeat/input/mqtt/input.go#L70
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_mqttcreateOnMessageHandler0 = [0] of {int};
	Wgdef inflightMessages;
	Wgdef clientDisconnected;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(clientDisconnected);
	run wgMonitor(inflightMessages);
	run mqttcreateOnMessageHandler(inflightMessages,child_mqttcreateOnMessageHandler0);
	child_mqttcreateOnMessageHandler0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype mqttcreateOnMessageHandler(Wgdef inflightMessages;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

