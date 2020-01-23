

	chan ch1 = {0} of int;
	chan ch2 = {0} of int;
	chan ch3 = {0} of int;
	chan ch1_closed = {0} of int;
	chan ch2_closed = {0} of int;
	chan ch3_closed = {0} of int

init {
		run Producer();

		run Consumer();
		run Consumer();
		run ClosedChan()
}


// You are never stuck forever
// waiting_Stuck is not always true
// waiting_Stuck is infinitely often false
proctype Stuck(){
	//waiting_Stuck = true
	do
	:: ch1!0 ->
		ch1_closed?0;
		printf("HURRAY")
	:: ch2!0 ->
		ch1_closed?0;
		printf("HURRAY")
	:: ch1?0 -> printf("HURRAY")
	od
	//waiting_Stuck=false
}

proctype UnStuck(){
	 ch1.in?0 -> printf("HURRAY");
}

proctype Producer() {

	int i = 0;
	int val = 0;

	do
	:: (i < 5) ->
		ch.in!i
		ch.in?val
		i++
	:: else ->
		break
	od
	ch.closed!true;
}
proctype Consumer() {
	int val;
	do
	:: ch.out?val ->
		printf("%d\n",val)
	od
}

proctype ch1_closed() {
	bool closed = false;

end:	do
			:: true ->
				if
				:: closed ->
					if
					:: ch1_closed!0 ->
						assert(false)
					:: ch1_closed?0 ->
						assert(false)
					fi
				:: else ->
					if
					:: ch1_closed!0;
					:: ch1_closed?0->
						closed = true
					fi
				fi
		od
}

proctype ClosedChan() {
	int val
	bool is_closed = false;
	do
	:: is_closed ->
		if
		:: ch.in?val ->
			assert(false)
		:: ch.out!0;
		:: ch.closed?true ->
			assert(false)
		fi
	:: else ->
		if
		:: ch.in?val ->
			ch.out!val;
			ch.ack!val
		:: ch.closed?true ->
			is_closed = true
		fi
	od

}

