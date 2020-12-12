
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/vt/orchestrator/app/cli.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int clusterPoolInstances = -2;
	Wgdef postponedFunctionsContainer_waitGroup;
	int untagged_GetInstanceKeys131424 = -2;
	int repointedReplicas = -2;
	int tags = -2;
	int unresolves = -2;
	int replicas = -2;
	int statements = -2;
	int clusters = -2;
	int keysDisplayStrings = -2;
	int nodes = -2;
	int i;
	int errs = -2;
	int movedReplicas = -2;
	int matchedReplicas = -2;
	int errantBinlogs = -2;
	int instances = -2;
	int kvPairs = -2;
	int instanceKeyMap_GetInstanceKeys127124 = -2;
	int untagged_GetInstanceKeys130024 = -2;
	int analysis = -2;
	int resolves = -2;
	int promotionRules = -2;
	bool state = false;
	run wgMonitor(postponedFunctionsContainer_waitGroup);
	

	if
	:: true;
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. errs-1) {
for10:
			};
						for(i : 0.. replicas-1) {
for20:
			}
		:: true -> 
						for(i : 0.. errs-1) {
for10:
			};
						for(i : 0.. replicas-1) {
for20:
			}
		fi
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. errs-1) {
for30:
			};
						for(i : 0.. movedReplicas-1) {
for40:
			}
		:: true -> 
						for(i : 0.. errs-1) {
for30:
			};
						for(i : 0.. movedReplicas-1) {
for40:
			}
		fi
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. errs-1) {
for50:
			};
						for(i : 0.. repointedReplicas-1) {
for60:
			}
		:: true -> 
						for(i : 0.. errs-1) {
for50:
			};
						for(i : 0.. repointedReplicas-1) {
for60:
			}
		fi
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. errs-1) {
for70:
			};
						for(i : 0.. movedReplicas-1) {
for80:
			}
		:: true -> 
						for(i : 0.. errs-1) {
for70:
			};
						for(i : 0.. movedReplicas-1) {
for80:
			}
		fi
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. errs-1) {
for90:
			};
						for(i : 0.. matchedReplicas-1) {
for100:
			}
		:: true -> 
						for(i : 0.. errs-1) {
for90:
			};
						for(i : 0.. matchedReplicas-1) {
for100:
			}
		fi
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. errs-1) {
for110:
			};
						for(i : 0.. matchedReplicas-1) {
for120:
			}
		:: true -> 
						for(i : 0.. errs-1) {
for110:
			};
						for(i : 0.. matchedReplicas-1) {
for120:
			}
		fi
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. statements-1) {
for130:
		}
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. errantBinlogs-1) {
for140:
		}
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. clusterPoolInstances-1) {
for150:
		}
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. instances-1) {
for160:
			}
		:: true -> 
						for(i : 0.. instances-1) {
for160:
			}
		fi
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. instances-1) {
for170:
			}
		:: true -> 
						for(i : 0.. instances-1) {
for170:
			}
		fi
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. instances-1) {
for180:
			}
		:: true -> 
						for(i : 0.. instances-1) {
for180:
			}
		fi
	:: true;
	:: true -> 
				for(i : 0.. clusters-1) {
for190:
		}
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. instances-1) {
for200:
			}
		:: true -> 
						for(i : 0.. instances-1) {
for200:
			}
		fi
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. instances-1) {
for210:
			}
		:: true -> 
						for(i : 0.. instances-1) {
for210:
			}
		fi
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. instances-1) {
for220:
		}
	:: true -> 
				for(i : 0.. instances-1) {
for230:
		}
	:: true -> 
				for(i : 0.. instances-1) {
for240:
		}
	:: true;
	:: true -> 
				for(i : 0.. instances-1) {
for250:
		}
	:: true -> 
				for(i : 0.. replicas-1) {
for260:
		}
	:: true -> 
				for(i : 0.. instances-1) {
for270:
		}
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. kvPairs-1) {
for280:
		}
	:: true -> 
				for(i : 0.. tags-1) {
for290:
		}
	:: true;
	:: true -> 
				for(i : 0.. instanceKeyMap_GetInstanceKeys127124-1) {
for300:
		};
				for(i : 0.. keysDisplayStrings-1) {
for310:
		}
	:: true;
	:: true -> 
				for(i : 0.. untagged_GetInstanceKeys130024-1) {
for320:
		}
	:: true -> 
				for(i : 0.. untagged_GetInstanceKeys131424-1) {
for330:
		}
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. analysis-1) {
for340:
		}
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. nodes-1) {
for350:
		}
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
				for(i : 0.. resolves-1) {
for360:
		}
	:: true -> 
				for(i : 0.. unresolves-1) {
for370:
		}
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : 0.. instances-1) {
for380:
		}
	:: true -> 
				for(i : 0.. promotionRules-1) {
for390:
		}
	:: true;
	fi
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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
	od
}
