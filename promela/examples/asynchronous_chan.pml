typedef Channel{
	chan in = [0] of {int};
	chan out = [0] of {int};
	chan closed = [0] of {bool};
}

Channel ch;
init {
		run Producer();
		run Consumer();
		run Consumer()
}

proctype Producer() {
	int i = 0;
	
	do
	:: (i < 5) -> 
		ch.in!i
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
		printf("test\n")
	od
}


active proctype ClosedChan() {
	int val;
	bool is_closed = false;
	int current_size = 0;
	int max_size = 5;

	do
	:: is_closed ->
		if
		::	ch.out!0;
		::	ch.in?val ->
			assert(false)
		:: ch.closed?true ->
			   assert(false)
		fi
	:: else -> 
		if 
		:: current_size == 0 ->
			if 
			:: ch.in?val ->
				ch.ack!0
			 	current_size++
			:: ch.closed?true ->
				is_closed = true
			fi
		:: current_size > 0 && current_size < max_size ->
			if 
			:: ch.in?val ->
				ch.ack!0
			 current_size++
			:: ch.out!val ->
			 current_size--
			:: ch.closed?true ->
				is_closed = true
			fi
		:: current_size == max_size ->
			if
			::	ch.out!val ->
			 current_size--
			:: ch.closed?true ->
				is_closed = true
			fi
		:: current_size > max_size ->
			assert(false) // Should never go over the max size
		fi
	od		
}

