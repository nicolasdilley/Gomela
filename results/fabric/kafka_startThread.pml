
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_kafkasetupChannelConsumerForChannel59 = [0] of {int};
	chan child_kafkasetupTopicForChannel61 = [0] of {int};
	Chandef _ch1;
	chan child_kafkasendConnectMessage45 = [0] of {int};
	int i;
	Chandef _ch0;
	chan child_kafkasetupProducerForChannel53 = [0] of {int};
	chan child_kafkasetupParentConsumerForChannel57 = [0] of {int};
	chan child_kafkagetHealthyClusterReplicaInfo511 = [0] of {int};
	bool state = false;
	chan _ch1_in = [0] of {int};
	chan _ch0_in = [0] of {int};
	run kafkasetupTopicForChannel6(child_kafkasetupTopicForChannel61);
	child_kafkasetupTopicForChannel61?0;
	run kafkasetupProducerForChannel5(child_kafkasetupProducerForChannel53);
	child_kafkasetupProducerForChannel53?0;
	run kafkasendConnectMessage4(child_kafkasendConnectMessage45);
	child_kafkasendConnectMessage45?0;
	run kafkasetupParentConsumerForChannel5(child_kafkasetupParentConsumerForChannel57);
	child_kafkasetupParentConsumerForChannel57?0;
	run kafkasetupChannelConsumerForChannel5(child_kafkasetupChannelConsumerForChannel59);
	child_kafkasetupChannelConsumerForChannel59?0;
	run kafkagetHealthyClusterReplicaInfo5(child_kafkagetHealthyClusterReplicaInfo511);
	child_kafkagetHealthyClusterReplicaInfo511?0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	chain_startChan.closing!true
stop_process:}

proctype kafkasetupTopicForChannel6(chan child) {
	bool closed; 
	int i;
	chan child_kafkanewRetryProcess50 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run kafkanewRetryProcess5(child_kafkanewRetryProcess50);
	child_kafkanewRetryProcess50?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype kafkanewRetryProcess5(chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype kafkasetupProducerForChannel5(chan child) {
	bool closed; 
	int i;
	chan child_kafkanewRetryProcess52 = [0] of {int};
	run kafkanewRetryProcess5(child_kafkanewRetryProcess52);
	child_kafkanewRetryProcess52?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype kafkasendConnectMessage4(chan child) {
	bool closed; 
	int i;
	chan child_kafkanewRetryProcess54 = [0] of {int};
	run kafkanewRetryProcess5(child_kafkanewRetryProcess54);
	child_kafkanewRetryProcess54?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype kafkasetupParentConsumerForChannel5(chan child) {
	bool closed; 
	int i;
	chan child_kafkanewRetryProcess56 = [0] of {int};
	run kafkanewRetryProcess5(child_kafkanewRetryProcess56);
	child_kafkanewRetryProcess56?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype kafkasetupChannelConsumerForChannel5(chan child) {
	bool closed; 
	int i;
	chan child_kafkanewRetryProcess58 = [0] of {int};
	run kafkanewRetryProcess5(child_kafkanewRetryProcess58);
	child_kafkanewRetryProcess58?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype kafkagetHealthyClusterReplicaInfo5(chan child) {
	bool closed; 
	int i;
	chan child_kafkanewRetryProcess510 = [0] of {int};
	run kafkanewRetryProcess5(child_kafkanewRetryProcess510);
	child_kafkanewRetryProcess510?0;
	goto stop_process;
	child!0;
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
