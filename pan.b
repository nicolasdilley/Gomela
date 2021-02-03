	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC sync_monitor */
;
		;
		
	case 4: // STATE 3
		;
		XX = 1;
		unrecv(((P2 *)this)->ch.async_send, XX-1, 0, 0, 1);
		;
		;
		goto R999;
;
		;
		
	case 6: // STATE 5
		;
		XX = 1;
		unrecv(((P2 *)this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;
;
		;
		
	case 8: // STATE 7
		;
		_m = unsend(((P2 *)this)->ch.sending);
		;
		goto R999;
;
		;
		
	case 10: // STATE 9
		;
		_m = unsend(((P2 *)this)->ch.sync);
		;
		goto R999;

	case 11: // STATE 13
		;
		_m = unsend(((P2 *)this)->ch.sending);
		;
		goto R999;

	case 12: // STATE 14
		;
		XX = 1;
		unrecv(((P2 *)this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 13: // STATE 15
		;
		((P2 *)this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 24
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC AsyncChan */
;
		;
		
	case 16: // STATE 3
		;
		XX = 1;
		unrecv(((P1 *)this)->ch.async_send, XX-1, 0, 0, 1);
		;
		;
		goto R999;
;
		;
		
	case 18: // STATE 5
		;
		XX = 1;
		unrecv(((P1 *)this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;
;
		;
		
	case 20: // STATE 7
		;
		_m = unsend(((P1 *)this)->ch.sending);
		;
		goto R999;
;
		;
		
	case 22: // STATE 9
		;
		_m = unsend(((P1 *)this)->ch.sync);
		;
		goto R999;

	case 23: // STATE 10
		;
		((P1 *)this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 25: // STATE 15
		;
		_m = unsend(((P1 *)this)->ch.async_rcv);
		;
		goto R999;

	case 26: // STATE 16
		;
		((P1 *)this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 27: // STATE 17
		;
		XX = 1;
		unrecv(((P1 *)this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 28: // STATE 18
		;
		((P1 *)this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 29: // STATE 19
		;
		_m = unsend(((P1 *)this)->ch.sending);
		;
		goto R999;
;
		;
		
	case 31: // STATE 23
		;
		XX = 1;
		unrecv(((P1 *)this)->ch.async_send, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 32: // STATE 24
		;
		((P1 *)this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 33: // STATE 25
		;
		XX = 1;
		unrecv(((P1 *)this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 34: // STATE 26
		;
		((P1 *)this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 35: // STATE 27
		;
		_m = unsend(((P1 *)this)->ch.sending);
		;
		goto R999;

	case 36: // STATE 31
		;
		XX = 1;
		unrecv(((P1 *)this)->ch.async_send, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 37: // STATE 32
		;
		((P1 *)this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 38: // STATE 33
		;
		_m = unsend(((P1 *)this)->ch.async_rcv);
		;
		goto R999;

	case 39: // STATE 34
		;
		((P1 *)this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 40: // STATE 35
		;
		XX = 1;
		unrecv(((P1 *)this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 41: // STATE 36
		;
		((P1 *)this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 42: // STATE 37
		;
		_m = unsend(((P1 *)this)->ch.sending);
		;
		goto R999;

	case 43: // STATE 47
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 44: // STATE 2
		;
		((P0 *)this)->errCh.size = trpt->bup.oval;
		;
		goto R999;

	case 45: // STATE 3
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 46: // STATE 5
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 47: // STATE 10
		;
		((P0 *)this)->limiter.size = trpt->bup.oval;
		;
		goto R999;

	case 48: // STATE 11
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 49: // STATE 13
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 50: // STATE 20
		;
		_m = unsend(((P0 *)this)->errCh.closing);
		;
		goto R999;

	case 51: // STATE 21
		;
	/* 1 */	((P0 *)this)->num_msgs = trpt->bup.ovals[3];
	/* 0 */	((P0 *)this)->state = trpt->bup.ovals[2];
		XX = 1;
		unrecv(((P0 *)this)->errCh.async_rcv, XX-1, 0, ((int)((P0 *)this)->state), 1);
		unrecv(((P0 *)this)->errCh.async_rcv, XX-1, 1, ((P0 *)this)->num_msgs, 0);
		((P0 *)this)->state = trpt->bup.ovals[0];
		((P0 *)this)->num_msgs = trpt->bup.ovals[1];
		;
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 52: // STATE 22
		;
	/* 1 */	((P0 *)this)->num_msgs = trpt->bup.ovals[3];
	/* 0 */	((P0 *)this)->state = trpt->bup.ovals[2];
		XX = 1;
		unrecv(((P0 *)this)->errCh.sync, XX-1, 0, ((int)((P0 *)this)->state), 1);
		unrecv(((P0 *)this)->errCh.sync, XX-1, 1, ((P0 *)this)->num_msgs, 0);
		((P0 *)this)->state = trpt->bup.ovals[0];
		((P0 *)this)->num_msgs = trpt->bup.ovals[1];
		;
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 53: // STATE 27
		;
		p_restor(II);
		;
		;
		goto R999;
	}

