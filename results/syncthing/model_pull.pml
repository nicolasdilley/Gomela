#define lb_for1651_0  -1
#define ub_for1651_1  -1
#define lb_for1449_2  -1
#define ub_for1449_3  -1
#define lb_for452_4  -1
#define ub_for452_5  -1
#define lb_for486_6  -1
#define ub_for486_7  -1

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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 0.. maxPullerIterations-1) {
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		chan child_fpullerIteration122 = [0] of {int};
		run fpullerIteration1(_ch0,child_fpullerIteration122);
		child_fpullerIteration122?0;
		
		if
		:: true -> 
			break
		:: true;
		fi
	};
for10_exit:	goto stop_process;
	_ch0.closing!true
stop_process:}

proctype fpullerIteration1(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	chan child_fprocessNeeded414 = [0] of {int};
	run Anonymous1(scanChan,pullChan,copyChan,finisherChan,dbUpdateChan,scanChan);
		for(i : 0.. f.Copiers-1) {
for12:		run Anonymous3(scanChan,pullChan,copyChan,finisherChan,dbUpdateChan,scanChan)
	};
for12_exit:	run Anonymous5(scanChan,pullChan,copyChan,finisherChan,dbUpdateChan,scanChan);
	run Anonymous9(scanChan,pullChan,copyChan,finisherChan,dbUpdateChan,scanChan);
	run fprocessNeeded4(scanChan,child_fprocessNeeded414);
	child_fprocessNeeded414?0;
	copyChan.closing!true;
	pullChan.closing!true;
	finisherChan.closing!true;
	
	if
	:: true -> 
		chan child_fprocessDeletions521 = [0] of {int};
		run fprocessDeletions5(scanChan,child_fprocessDeletions521);
		child_fprocessDeletions521?0
	:: true;
	fi;
	dbUpdateChan.closing!true;
	goto stop_process;
	child!0;
stop_process:
}
proctype fdbUpdaterRoutine1(chan child) {
	bool closed; 
	int i;
loop:		do
	:: true -> 
for11:		do
		:: true -> 
			
			if
			:: true -> 
				goto loop
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true;
			fi;
			break
		:: true -> 
			break
		od
	od;
for11_exit:;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef scanChan;Chandef pullChan;Chandef copyChan;Chandef finisherChan;Chandef dbUpdateChan;Chandef scanChan) {
	bool closed; 
	int i;
	chan child_fdbUpdaterRoutine10 = [0] of {int};
	run fdbUpdaterRoutine1(child_fdbUpdaterRoutine10);
	child_fdbUpdaterRoutine10?0;
stop_process:
}
proctype fcopierRoutine3(chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for13:
	od;
	do
	:: true -> 
for14:		
		if
		:: true -> 
			out.in!0;
			out.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			out.in!0;
			out.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			do
			:: true -> 
for15:
			od
		fi;
blocks:				do
		:: true -> 
for16:			do
			:: true -> 
				goto blocks;
				break
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				pullChan.in!0;
				pullChan.sending?state
			fi
		od;
		out.in!0;
		out.sending?state
	od;
	child!0;
stop_process:
}
proctype Anonymous3(Chandef scanChan;Chandef pullChan;Chandef copyChan;Chandef finisherChan;Chandef dbUpdateChan;Chandef scanChan) {
	bool closed; 
	int i;
	chan child_fcopierRoutine31 = [0] of {int};
	run fcopierRoutine3(child_fcopierRoutine31);
	child_fcopierRoutine31?0;
stop_process:
}
proctype fpullerRoutine2(chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for17:		
		if
		:: true -> 
			out.in!0;
			out.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			out.in!0;
			out.sending?state
		:: true;
		fi;
		run Anonymous6(in,out,in,out)
	od;
	child!0;
stop_process:
}
proctype fpullBlock2(Chandef out;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		out.in!0;
		out.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		out.in!0;
		out.sending?state;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for18:		do
		:: true -> 
			goto for18_exit
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		break
	od;
for18_exit:	out.in!0;
	out.sending?state;
	child!0;
stop_process:
}
proctype Anonymous6(Chandef in;Chandef out;Chandef in;Chandef out) {
	bool closed; 
	int i;
	chan child_fpullBlock22 = [0] of {int};
	run fpullBlock2(out,child_fpullBlock22);
	child_fpullBlock22?0;
stop_process:
}
proctype Anonymous5(Chandef scanChan;Chandef pullChan;Chandef copyChan;Chandef finisherChan;Chandef dbUpdateChan;Chandef scanChan) {
	bool closed; 
	int i;
	chan child_fpullerRoutine23 = [0] of {int};
	run fpullerRoutine2(child_fpullerRoutine23);
	child_fpullerRoutine23?0;
stop_process:
}
proctype ffinisherRoutine4(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	do
	:: in.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			in.in?0;
			
			if
			:: true -> 
				
				if
				:: true -> 
					chan child_fperformFinish77 = [0] of {int};
					run fperformFinish7(scanChan,child_fperformFinish77);
					child_fperformFinish77?0
				:: true;
				fi
			:: true;
			fi
		fi
	od;
	child!0;
stop_process:
}
proctype fperformFinish7(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
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
	
	if
	:: true -> 
		chan child_fscanIfItemChanged54 = [0] of {int};
		run fscanIfItemChanged5(scanChan,child_fscanIfItemChanged54);
		child_fscanIfItemChanged54?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			chan child_fdeleteItemOnDisk36 = [0] of {int};
			run fdeleteItemOnDisk3(scanChan,child_fdeleteItemOnDisk36);
			child_fdeleteItemOnDisk36?0
		fi;
		
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
	dbUpdateChan.in!0;
	dbUpdateChan.sending?state;
	goto stop_process;
	child!0;
stop_process:
}
proctype fscanIfItemChanged5(Chandef scanChan;chan child) {
	bool closed; 
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	
	if
	:: true -> 
		scanChan.in!0;
		scanChan.sending?state
	:: true;
	fi;
	child!0;
stop_process:
}
proctype fdeleteItemOnDisk3(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	

	if
	:: true -> 
		chan child_fdeleteDirOnDisk35 = [0] of {int};
		run fdeleteDirOnDisk3(scanChan,child_fdeleteDirOnDisk35);
		child_fdeleteDirOnDisk35?0;
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype fdeleteDirOnDisk3(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for110:		

		if
		:: true;
		:: true;
		fi;
		

		if
		:: true -> 
			scanChan.in!0;
			scanChan.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			scanChan.in!0;
			scanChan.sending?state
		:: true;
		fi;
		
		if
		:: true -> 
			scanChan.in!0;
			scanChan.sending?state
		:: true;
		fi
	od;
	
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
	do
	:: true -> 
for111:
	od;
	
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
	child!0;
stop_process:
}
proctype Anonymous9(Chandef scanChan;Chandef pullChan;Chandef copyChan;Chandef finisherChan;Chandef dbUpdateChan;Chandef scanChan) {
	bool closed; 
	int i;
	chan child_ffinisherRoutine48 = [0] of {int};
	run ffinisherRoutine4(scanChan,child_ffinisherRoutine48);
	child_ffinisherRoutine48?0;
stop_process:
}
proctype fprocessNeeded4(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
nextFile:		do
	:: true -> 
for112:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: lb_for486_6 != -1 && ub_for486_7 != -1 -> 
						for(i : lb_for486_6.. ub_for486_7) {
for113:				chan child_frenameFile612 = [0] of {int};
				run frenameFile6(scanChan,child_frenameFile612);
				child_frenameFile612?0
			}
		:: else -> 
			do
			:: true -> 
for113:				chan child_frenameFile612 = [0] of {int};
				run frenameFile6(scanChan,child_frenameFile612);
				child_frenameFile612?0
			:: true -> 
				break
			od
		fi;
for113_exit:		do
		:: true -> 
for114:			
			if
			:: true -> 
				chan child_fhandleFile313 = [0] of {int};
				run fhandleFile3(child_fhandleFile313);
				child_fhandleFile313?0
			:: true;
			fi
		od
	od;
for112_exit:;
	goto stop_process;
	child!0;
stop_process:
}
proctype frenameFile6(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	chan child_fperformFinish711 = [0] of {int};
	chan child_fcheckToBeDeleted610 = [0] of {int};
	run fcheckToBeDeleted6(scanChan,child_fcheckToBeDeleted610);
	child_fcheckToBeDeleted610?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		
		if
		:: true -> 
			break
		:: true;
		fi;
		scanChan.in!0;
		scanChan.sending?state
	:: true;
	:: true -> 
		scanChan.in!0;
		scanChan.sending?state
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				scanChan.in!0;
				scanChan.sending?state
			:: true;
			fi
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	chan child_fperformFinish711 = [0] of {int};
	run fperformFinish7(scanChan,child_fperformFinish711);
	child_fperformFinish711?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	dbUpdateChan.in!0;
	dbUpdateChan.sending?state;
	goto stop_process;
	child!0;
stop_process:
}
proctype fcheckToBeDeleted6(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	chan child_fscanIfItemChanged59 = [0] of {int};
	
	if
	:: true -> 
		dbUpdateChan.in!0;
		dbUpdateChan.sending?state;
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
			scanChan.in!0;
			scanChan.sending?state;
			goto stop_process
		:: true;
		fi;
		dbUpdateChan.in!0;
		dbUpdateChan.sending?state;
		goto stop_process
	:: true;
	fi;
	run fscanIfItemChanged5(scanChan,child_fscanIfItemChanged59);
	child_fscanIfItemChanged59?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype fhandleFile3(chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for115:
		od;
		do
		:: true -> 
for116:
		od
	fi;
	copyChan.in!0;
	copyChan.sending?state;
	child!0;
stop_process:
}
proctype fprocessDeletions5(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for117:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		chan child_fdeleteFile417 = [0] of {int};
		run fdeleteFile4(scanChan,child_fdeleteFile417);
		child_fdeleteFile417?0
	od;
	do
	:: true -> 
for118:		do
		:: true -> 
			goto stop_process
		:: true -> 
			break
		od;
		chan child_fdeleteDir420 = [0] of {int};
		run fdeleteDir4(scanChan,child_fdeleteDir420);
		child_fdeleteDir420?0
	od;
	child!0;
stop_process:
}
proctype fdeleteFile4(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	chan child_fdeleteFileWithCurrent516 = [0] of {int};
	run fdeleteFileWithCurrent5(scanChan,child_fdeleteFileWithCurrent516);
	child_fdeleteFileWithCurrent516?0;
	child!0;
stop_process:
}
proctype fdeleteFileWithCurrent5(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	chan child_fcheckToBeDeleted615 = [0] of {int};
	run fcheckToBeDeleted6(scanChan,child_fcheckToBeDeleted615);
	child_fcheckToBeDeleted615?0;
	
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
		dbUpdateChan.in!0;
		dbUpdateChan.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		dbUpdateChan.in!0;
		dbUpdateChan.sending?state;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		dbUpdateChan.in!0;
		dbUpdateChan.sending?state
	:: true;
	fi;
	child!0;
stop_process:
}
proctype fdeleteDir4(Chandef scanChan;chan child) {
	bool closed; 
	int i;
	chan child_fdeleteDirOnDisk319 = [0] of {int};
	chan child_fcheckToBeDeleted618 = [0] of {int};
	run fcheckToBeDeleted6(scanChan,child_fcheckToBeDeleted618);
	child_fcheckToBeDeleted618?0;
	chan child_fdeleteDirOnDisk319 = [0] of {int};
	run fdeleteDirOnDisk3(scanChan,child_fdeleteDirOnDisk319);
	child_fdeleteDirOnDisk319?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	dbUpdateChan.in!0;
	dbUpdateChan.sending?state;
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
