#define readSheetsFromZipFile_workbook_DefinedNames_DefinedName 3
#define readSheetsFromZipFile_workbook_Sheets_Sheet 1
#define readSheetsFromZipFile_sheetCount 0
#define readSheetsFromZipFile_workbookSheets 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example393281122/lib.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef sheetChan;
	int workbookSheets = readSheetsFromZipFile_workbookSheets;
	int workbook_Sheets_Sheet = readSheetsFromZipFile_workbook_Sheets_Sheet;
	bool state = false;
	int workbook_DefinedNames_DefinedName = readSheetsFromZipFile_workbook_DefinedNames_DefinedName;
	int sheetCount = readSheetsFromZipFile_sheetCount;
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
		for(i : 0.. workbook_DefinedNames_DefinedName-1) {
for10:
	};
		for(i : 0.. workbook_Sheets_Sheet-1) {
for20:
	};
	
	if
	:: sheetCount > 0 -> 
		sheetChan.size = sheetCount;
		run emptyChan(sheetChan)
	:: else -> 
		run sync_monitor(sheetChan)
	fi;
		for(i : 0.. workbookSheets-1) {
for30:		run Anonymous0(sheetChan)
	};
	
	if
	:: 0 != -1 && sheetCount-1 != -1 -> 
				for(i : 0.. sheetCount-1) {
for40:			
			if
			:: sheetChan.async_rcv?0;
			:: sheetChan.sync?0;
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
			fi
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: sheetChan.async_rcv?0;
			:: sheetChan.sync?0;
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
			fi
		:: true -> 
			break
		od
	fi;
for40_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sheetChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: sheetChan.async_send!0;
	:: sheetChan.sync!0 -> 
		sheetChan.sending?0
	fi;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}


