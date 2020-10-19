#define loadDebugInfoMaps_cu_ranges  5
#define loadDebugInfoMaps_bi_Functions  5
#define loadDebugInfoMaps_image_compileUnits  5
#define loadDebugInfoMaps_cu_lineInfo_FileNames  5
#define lb_for1526_4  -1
#define ub_for1526_5  -1
#define loadSymbolName_symSecs  5
#define setGStructOffsetElf_symbols  5
#define setGStructOffsetElf_exe_Progs  5
#define loadDebugInfoMaps_cu_ranges  5
#define loadDebugInfoMaps_bi_Functions  5
#define loadDebugInfoMaps_image_compileUnits  5
#define loadDebugInfoMaps_cu_lineInfo_FileNames  5
#define loadDebugInfoMaps_cu_ranges  5
#define loadDebugInfoMaps_bi_Functions  5
#define loadDebugInfoMaps_image_compileUnits  5
#define loadDebugInfoMaps_cu_lineInfo_FileNames  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example902149894/pkg/proc/bininfo.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	Wgdef wg;
	bool state = false;
	run wgMonitor(wg);
	

	if
	:: true -> 
		chan child_procloadBinaryInfoElf0 = [0] of {int};
		run procloadBinaryInfoElf(wg,child_procloadBinaryInfoElf0);
		child_procloadBinaryInfoElf0?0;
		goto stop_process
	:: true -> 
		chan child_procloadBinaryInfoPE1 = [0] of {int};
		run procloadBinaryInfoPE(wg,child_procloadBinaryInfoPE1);
		child_procloadBinaryInfoPE1?0;
		goto stop_process
	:: true -> 
		chan child_procloadBinaryInfoMacho2 = [0] of {int};
		run procloadBinaryInfoMacho(wg,child_procloadBinaryInfoMacho2);
		child_procloadBinaryInfoMacho2?0;
		goto stop_process
	fi;
	goto stop_process;
	wg.Wait?0
stop_process:}

proctype procloadBinaryInfoElf(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!3;
	run go_biparseDebugFrameElf(wg);
	run go_biloadDebugInfoMaps(wg);
	run go_biloadSymbolName(wg);
	
	if
	:: true -> 
		wg.Add!1;
		run go_bisetGStructOffsetElf(wg)
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype go_biparseDebugFrameElf(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
	wg.Add!-1;
stop_process:
}
proctype go_biloadDebugInfoMaps(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		wg.Add!-1
	:: true;
	fi;
	
	if
	:: lb_for1526_4 != -1 && ub_for1526_5 != -1 -> 
				for(i : lb_for1526_4.. ub_for1526_5) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
								for(i : 1.. cu_ranges) {
for11:
				}
			:: true;
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
								for(i : 1.. cu_ranges) {
for11:
				}
			:: true;
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : 1.. bi_Functions) {
for20:
	};
		for(i : 1.. image_compileUnits) {
for30:		
		if
		:: true -> 
						for(i : 1.. cu_lineInfo_FileNames) {
for31:
			}
		:: true;
		fi
	};
stop_process:
}
proctype go_biloadSymbolName(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 1.. symSecs) {
for40:
		}
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype go_bisetGStructOffsetElf(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. symbols) {
for50:		
		if
		:: true -> 
			break
		:: true;
		fi
	};
		for(i : 1.. exe_Progs) {
for60:		
		if
		:: true -> 
			break
		:: true;
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype procloadBinaryInfoPE(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!2;
	run go_biparseDebugFramePE(wg);
	run go_biloadDebugInfoMaps(wg);
	goto stop_process;
	child!0;
stop_process:
}
proctype go_biparseDebugFramePE(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
	wg.Add!-1;
stop_process:
}
proctype procloadBinaryInfoMacho(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	wg.Add!2;
	run go_biparseDebugFrameMacho(wg);
	run go_biloadDebugInfoMaps(wg);
	goto stop_process;
	child!0;
stop_process:
}
proctype go_biparseDebugFrameMacho(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
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
	wg.Add!-1;
stop_process:
}
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
	od;
stop_process:
}
