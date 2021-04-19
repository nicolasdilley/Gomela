
// https://github.com/moby/moby/blob/master/daemon/list_test.go#L98
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNameFilter980 = [1] of {int};
	run TestNameFilter98(child_TestNameFilter980)
stop_process:skip
}

proctype TestNameFilter98(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Containers1076 = [1] of {int};
	chan child_Containers1075 = [1] of {int};
	chan child_Containers1074 = [1] of {int};
	chan child_Containers1073 = [1] of {int};
	chan child_setupContainerWithName362 = [1] of {int};
	chan child_setupContainerWithName361 = [1] of {int};
	chan child_setupContainerWithName360 = [1] of {int};
	Mutexdef d_mdDB_statlock;
	Mutexdef d_mdDB_mmaplock;
	Mutexdef d_mdDB_metalock;
	Mutexdef d_mdDB_rwlock;
	Mutexdef d_mdDB_batch_start_m;
	Mutexdef d_mdDB_batchMu;
	Mutexdef d_mdDB_freelistLoad_m;
	Mutexdef d_attachableNetworkLock_mu;
	Mutexdef d_containerdCli_conn_firstResolveEvent_o_m;
	Mutexdef d_containerdCli_conn_balancerWrapper_mu;
	Mutexdef d_containerdCli_conn_balancerWrapper_done_o_m;
	Mutexdef d_containerdCli_conn_balancerWrapper_scBuffer_mu;
	Mutexdef d_containerdCli_conn_balancerWrapper_balancerMu;
	Mutexdef d_containerdCli_conn_resolverWrapper_pollingMu;
	Mutexdef d_containerdCli_conn_resolverWrapper_done_o_m;
	Mutexdef d_containerdCli_conn_resolverWrapper_resolverMu;
	Mutexdef d_containerdCli_conn_mu;
	Mutexdef d_containerdCli_conn_blockingpicker_mu;
	Mutexdef d_containerdCli_conn_csMgr_mu;
	Mutexdef d_containerdCli_connMu;
	Mutexdef d_linkIndex_mu;
	run mutexMonitor(d_linkIndex_mu);
	run mutexMonitor(d_containerdCli_connMu);
	run mutexMonitor(d_containerdCli_conn_csMgr_mu);
	run mutexMonitor(d_containerdCli_conn_blockingpicker_mu);
	run mutexMonitor(d_containerdCli_conn_mu);
	run mutexMonitor(d_containerdCli_conn_resolverWrapper_resolverMu);
	run mutexMonitor(d_containerdCli_conn_resolverWrapper_done_o_m);
	run mutexMonitor(d_containerdCli_conn_resolverWrapper_pollingMu);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_balancerMu);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_done_o_m);
	run mutexMonitor(d_containerdCli_conn_balancerWrapper_mu);
	run mutexMonitor(d_containerdCli_conn_firstResolveEvent_o_m);
	run mutexMonitor(d_attachableNetworkLock_mu);
	run mutexMonitor(d_mdDB_freelistLoad_m);
	run mutexMonitor(d_mdDB_batchMu);
	run mutexMonitor(d_mdDB_batch_start_m);
	run mutexMonitor(d_mdDB_rwlock);
	run mutexMonitor(d_mdDB_metalock);
	run mutexMonitor(d_mdDB_mmaplock);
	run mutexMonitor(d_mdDB_statlock);
	run setupContainerWithName36(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_setupContainerWithName360);
	child_setupContainerWithName360?0;
	run setupContainerWithName36(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_setupContainerWithName361);
	child_setupContainerWithName361?0;
	run setupContainerWithName36(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_setupContainerWithName362);
	child_setupContainerWithName362?0;
	run Containers107(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_Containers1073);
	child_Containers1073?0;
	run Containers107(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_Containers1074);
	child_Containers1074?0;
	run Containers107(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_Containers1075);
	child_Containers1075?0;
	run Containers107(d_linkIndex_mu,d_containerdCli_connMu,d_containerdCli_conn_csMgr_mu,d_containerdCli_conn_blockingpicker_mu,d_containerdCli_conn_mu,d_containerdCli_conn_resolverWrapper_resolverMu,d_containerdCli_conn_resolverWrapper_done_o_m,d_containerdCli_conn_resolverWrapper_pollingMu,d_containerdCli_conn_balancerWrapper_balancerMu,d_containerdCli_conn_balancerWrapper_scBuffer_mu,d_containerdCli_conn_balancerWrapper_done_o_m,d_containerdCli_conn_balancerWrapper_mu,d_containerdCli_conn_firstResolveEvent_o_m,d_attachableNetworkLock_mu,d_mdDB_freelistLoad_m,d_mdDB_batchMu,d_mdDB_batch_start_m,d_mdDB_rwlock,d_mdDB_metalock,d_mdDB_mmaplock,d_mdDB_statlock,child_Containers1076);
	child_Containers1076?0;
	stop_process: skip;
	child!0
}
proctype setupContainerWithName36(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reserveName580 = [1] of {int};
	run reserveName58(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reserveName580);
	child_reserveName580?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype reserveName58(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Containers107(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reduceContainers1783 = [1] of {int};
	run reduceContainers178(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reduceContainers1783);
	child_reduceContainers1783?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype reduceContainers178(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reducePsContainer2195 = [1] of {int};
	chan child_reducePsContainer2196 = [1] of {int};
	chan child_filterByNameIDMatches1114 = [1] of {int};
	chan child_foldFilter2443 = [1] of {int};
	int containerList = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run foldFilter244(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_foldFilter2443);
	child_foldFilter2443?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run filterByNameIDMatches111(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_filterByNameIDMatches1114);
	child_filterByNameIDMatches1114?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: containerList-1 != -3 -> 
				for(i : 0.. containerList-1) {
			for40: skip;
			run reducePsContainer219(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reducePsContainer2195);
			child_reducePsContainer2195?0;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true;
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for41: skip;
			run reducePsContainer219(daemon_linkIndex_mu,daemon_containerdCli_connMu,daemon_containerdCli_conn_csMgr_mu,daemon_containerdCli_conn_blockingpicker_mu,daemon_containerdCli_conn_mu,daemon_containerdCli_conn_resolverWrapper_resolverMu,daemon_containerdCli_conn_resolverWrapper_done_o_m,daemon_containerdCli_conn_resolverWrapper_pollingMu,daemon_containerdCli_conn_balancerWrapper_balancerMu,daemon_containerdCli_conn_balancerWrapper_scBuffer_mu,daemon_containerdCli_conn_balancerWrapper_done_o_m,daemon_containerdCli_conn_balancerWrapper_mu,daemon_containerdCli_conn_firstResolveEvent_o_m,daemon_attachableNetworkLock_mu,daemon_mdDB_freelistLoad_m,daemon_mdDB_batchMu,daemon_mdDB_batch_start_m,daemon_mdDB_rwlock,daemon_mdDB_metalock,daemon_mdDB_mmaplock,daemon_mdDB_statlock,child_reducePsContainer2196);
			child_reducePsContainer2196?0;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true;
			fi;
			for41_end: skip
		:: true -> 
			break
		od;
		for41_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype foldFilter244(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			fi
		fi
	:: true;
	fi;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype filterByNameIDMatches111(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype reducePsContainer219(Mutexdef daemon_linkIndex_mu;Mutexdef daemon_containerdCli_connMu;Mutexdef daemon_containerdCli_conn_csMgr_mu;Mutexdef daemon_containerdCli_conn_blockingpicker_mu;Mutexdef daemon_containerdCli_conn_mu;Mutexdef daemon_containerdCli_conn_resolverWrapper_resolverMu;Mutexdef daemon_containerdCli_conn_resolverWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_resolverWrapper_pollingMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_balancerMu;Mutexdef daemon_containerdCli_conn_balancerWrapper_scBuffer_mu;Mutexdef daemon_containerdCli_conn_balancerWrapper_done_o_m;Mutexdef daemon_containerdCli_conn_balancerWrapper_mu;Mutexdef daemon_containerdCli_conn_firstResolveEvent_o_m;Mutexdef daemon_attachableNetworkLock_mu;Mutexdef daemon_mdDB_freelistLoad_m;Mutexdef daemon_mdDB_batchMu;Mutexdef daemon_mdDB_batch_start_m;Mutexdef daemon_mdDB_rwlock;Mutexdef daemon_mdDB_metalock;Mutexdef daemon_mdDB_mmaplock;Mutexdef daemon_mdDB_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

