#define readSheetsFromZipFile_sheetCount  3

// https://github.com/henrylee2cn/pholcus/blob/bf4a87b9aa74fefaec49f991d3ac213a43a313d1/common/xlsx/lib.go#L612
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef sheetChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int sheetCount = readSheetsFromZipFile_sheetCount;
	

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
	:: sheetCount > 0 -> 
		sheetChan.size = sheetCount;
		run AsyncChan(sheetChan)
	:: else -> 
		run sync_monitor(sheetChan)
	fi;
	run go_Anonymous0(sheetChan);
	

	if
	:: 0 != -2 && sheetCount-1 != -3 -> 
				for(i : 0.. sheetCount-1) {
			for30675: skip;
			

			if
			:: sheetChan.async_rcv?state,num_msgs;
			:: sheetChan.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end675: skip
		};
		for30_exit675: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: sheetChan.async_rcv?state,num_msgs;
			:: sheetChan.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	goto stop_process;
	sheetChan.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef sheetChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_xlsxreadSheetFromFile0 = [0] of {int};
	chan child_xlsxreadSheetFromFile0 = [0] of {int};
	int workbookSheets = -2;
	

	if
	:: workbookSheets-1 != -3 -> 
				for(i : 0.. workbookSheets-1) {
			for20: skip;
			run xlsxreadSheetFromFile(sheetChan,child_xlsxreadSheetFromFile0);
			child_xlsxreadSheetFromFile0?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20674: skip;
			run xlsxreadSheetFromFile(sheetChan,child_xlsxreadSheetFromFile0);
			child_xlsxreadSheetFromFile0?0;
			for20_end674: skip
		:: true -> 
			break
		od;
		for20_exit674: skip
	fi;
	stop_process: skip
}
proctype xlsxreadSheetFromFile(Chandef sc;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: sc.async_send!0;
		:: sc.sync!false,0 -> 
			sc.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: sc.async_send!0;
	:: sc.sync!false,0 -> 
		sc.sending?state
	fi;
	stop_process: skip;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		fi;
		

		if
		:: sc.async_send!0;
		:: sc.sync!false,0 -> 
			sc.sending?state
		fi
	:: true;
	fi;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

