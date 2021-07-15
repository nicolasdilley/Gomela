	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC wgMonitor */

	case 3: // STATE 1
		;
		XX = 1;
		unrecv(((P6 *)_this)->wg.update, XX-1, 0, ((P6 *)_this)->i, 1);
		((P6 *)_this)->i = trpt->bup.oval;
		;
		;
		goto R999;

	case 4: // STATE 2
		;
		((P6 *)_this)->wg.Counter = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 6: // STATE 5
		;
		XX = 1;
		unrecv(((P6 *)_this)->wg.update, XX-1, 0, ((P6 *)_this)->i, 1);
		((P6 *)_this)->i = trpt->bup.oval;
		;
		;
		goto R999;

	case 7: // STATE 6
		;
		((P6 *)_this)->wg.Counter = trpt->bup.oval;
		;
		goto R999;

	case 8: // STATE 8
		;
		_m = unsend(((P6 *)_this)->wg.wait);
		;
		goto R999;

	case 9: // STATE 14
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC sync_monitor */
;
		;
		
	case 11: // STATE 3
		;
		XX = 1;
		unrecv(((P5 *)_this)->ch.enq, XX-1, 0, 0, 1);
		;
		;
		goto R999;
;
		;
		
	case 13: // STATE 5
		;
		XX = 1;
		unrecv(((P5 *)_this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;
;
		;
		
	case 15: // STATE 7
		;
		XX = 1;
		unrecv(((P5 *)_this)->ch.sending, XX-1, 0, 0, 1);
		;
		;
		goto R999;
;
		;
		
	case 17: // STATE 9
		;
		XX = 1;
		unrecv(((P5 *)_this)->ch.rcving, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 18: // STATE 10
		;
		_m = unsend(((P5 *)_this)->ch.sync);
		;
		goto R999;

	case 19: // STATE 14
		;
		XX = 1;
		unrecv(((P5 *)_this)->ch.rcving, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 20: // STATE 15
		;
		XX = 1;
		unrecv(((P5 *)_this)->ch.sending, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 21: // STATE 16
		;
		XX = 1;
		unrecv(((P5 *)_this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 22: // STATE 17
		;
		((P5 *)_this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 26
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC AsyncChan */
;
		;
		
	case 25: // STATE 3
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.enq, XX-1, 0, 0, 1);
		;
		;
		goto R999;
;
		;
		
	case 27: // STATE 5
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;
;
		;
		
	case 29: // STATE 7
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 30: // STATE 8
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.sending, XX-1, 0, 0, 1);
		;
		;
		goto R999;
;
		;
		
	case 32: // STATE 10
		;
		_m = unsend(((P4 *)_this)->ch.sync);
		;
		goto R999;

	case 33: // STATE 11
		;
		((P4 *)_this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 35: // STATE 16
		;
		_m = unsend(((P4 *)_this)->ch.deq);
		;
		goto R999;

	case 36: // STATE 17
		;
		((P4 *)_this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 37: // STATE 18
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 38: // STATE 19
		;
		((P4 *)_this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 39: // STATE 20
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 40: // STATE 21
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.sending, XX-1, 0, 0, 1);
		;
		;
		goto R999;
;
		;
		
	case 42: // STATE 25
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.enq, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 43: // STATE 26
		;
		((P4 *)_this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 44: // STATE 27
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 45: // STATE 28
		;
		((P4 *)_this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 46: // STATE 29
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 47: // STATE 30
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.sending, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 48: // STATE 34
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.enq, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 49: // STATE 35
		;
		((P4 *)_this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 50: // STATE 36
		;
		_m = unsend(((P4 *)_this)->ch.deq);
		;
		goto R999;

	case 51: // STATE 37
		;
		((P4 *)_this)->ch.num_msgs = trpt->bup.oval;
		;
		goto R999;

	case 52: // STATE 38
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 53: // STATE 39
		;
		((P4 *)_this)->ch.closed = trpt->bup.oval;
		;
		goto R999;

	case 54: // STATE 40
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 55: // STATE 41
		;
		XX = 1;
		unrecv(((P4 *)_this)->ch.sending, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 56: // STATE 51
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC AnonymousDeleteChart9898 */

	case 57: // STATE 2
		;
		_m = unsend(((P3 *)_this)->errChan.enq);
		;
		goto R999;

	case 58: // STATE 3
		;
		_m = unsend(((P3 *)_this)->errChan.sync);
		;
		goto R999;

	case 59: // STATE 4
		;
		_m = unsend(((P3 *)_this)->errChan.sending);
		;
		goto R999;

	case 60: // STATE 11
		;
		_m = unsend(((P3 *)_this)->tokenQueue.enq);
		;
		goto R999;

	case 61: // STATE 12
		;
		_m = unsend(((P3 *)_this)->tokenQueue.sync);
		;
		goto R999;

	case 62: // STATE 13
		;
		_m = unsend(((P3 *)_this)->tokenQueue.sending);
		;
		goto R999;

	case 63: // STATE 16
		;
		_m = unsend(((P3 *)_this)->waitGroup.update);
		;
		goto R999;

	case 64: // STATE 17
		;
		_m = unsend(((P3 *)_this)->child);
		;
		goto R999;

	case 65: // STATE 18
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC AnonymousDeleteChart7764 */

	case 66: // STATE 2
		;
		XX = 1;
		unrecv(((P2 *)_this)->errChan.deq, XX-1, 0, ((int)((P2 *)_this)->state), 1);
		unrecv(((P2 *)_this)->errChan.deq, XX-1, 1, ((P2 *)_this)->num_msgs, 0);
		((P2 *)_this)->state = trpt->bup.ovals[0];
		((P2 *)_this)->num_msgs = trpt->bup.ovals[1];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 67: // STATE 3
		;
		XX = 1;
		unrecv(((P2 *)_this)->errChan.sync, XX-1, 0, ((int)((P2 *)_this)->state), 1);
		((P2 *)_this)->state = trpt->bup.oval;
		;
		;
		goto R999;

	case 68: // STATE 4
		;
		_m = unsend(((P2 *)_this)->errChan.rcving);
		;
		goto R999;

	case 69: // STATE 7
		;
	/* 1 */	((P2 *)_this)->num_msgs = trpt->bup.ovals[1];
	/* 0 */	((P2 *)_this)->state = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 70: // STATE 20
		;
		_m = unsend(((P2 *)_this)->errWrapper.enq);
		;
		goto R999;

	case 71: // STATE 21
		;
		_m = unsend(((P2 *)_this)->errWrapper.sync);
		;
		goto R999;

	case 72: // STATE 22
		;
		_m = unsend(((P2 *)_this)->errWrapper.sending);
		;
		goto R999;

	case 73: // STATE 28
		;
		_m = unsend(((P2 *)_this)->errWrapper.closing);
		;
		goto R999;

	case 74: // STATE 29
		;
		_m = unsend(((P2 *)_this)->child);
		;
		goto R999;

	case 75: // STATE 30
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC DeleteChart37 */

	case 76: // STATE 22
		;
		((P1 *)_this)->tokenQueue.size = trpt->bup.oval;
		;
		goto R999;

	case 77: // STATE 23
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 78: // STATE 25
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 79: // STATE 29
		;
		((P1 *)_this)->errChan.size = trpt->bup.oval;
		;
		goto R999;

	case 80: // STATE 30
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 81: // STATE 32
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 82: // STATE 35
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 83: // STATE 36
		;
		_m = unsend(((P1 *)_this)->waitGroup.update);
		;
		goto R999;

	case 84: // STATE 38
		;
		((P1 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 86: // STATE 41
		;
		_m = unsend(((P1 *)_this)->tokenQueue.enq);
		;
		goto R999;

	case 87: // STATE 42
		;
		_m = unsend(((P1 *)_this)->tokenQueue.sync);
		;
		goto R999;

	case 88: // STATE 43
		;
		_m = unsend(((P1 *)_this)->tokenQueue.sending);
		;
		goto R999;

	case 89: // STATE 47
		;
		((P1 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 90: // STATE 57
		;
		_m = unsend(((P1 *)_this)->tokenQueue.enq);
		;
		goto R999;

	case 91: // STATE 58
		;
		_m = unsend(((P1 *)_this)->tokenQueue.sync);
		;
		goto R999;

	case 92: // STATE 59
		;
		_m = unsend(((P1 *)_this)->tokenQueue.sending);
		;
		goto R999;

	case 93: // STATE 72
		;
		((P1 *)_this)->errWrapper.size = trpt->bup.oval;
		;
		goto R999;

	case 94: // STATE 73
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 95: // STATE 75
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 96: // STATE 78
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 97: // STATE 79
		;
		((P1 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 99: // STATE 82
		;
	/* 1 */	((P1 *)_this)->num_msgs = trpt->bup.ovals[3];
	/* 0 */	((P1 *)_this)->state = trpt->bup.ovals[2];
		XX = 1;
		unrecv(((P1 *)_this)->tokenQueue.deq, XX-1, 0, ((int)((P1 *)_this)->state), 1);
		unrecv(((P1 *)_this)->tokenQueue.deq, XX-1, 1, ((P1 *)_this)->num_msgs, 0);
		((P1 *)_this)->state = trpt->bup.ovals[0];
		((P1 *)_this)->num_msgs = trpt->bup.ovals[1];
		;
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 100: // STATE 83
		;
	/* 0 */	((P1 *)_this)->state = trpt->bup.ovals[1];
		XX = 1;
		unrecv(((P1 *)_this)->tokenQueue.sync, XX-1, 0, ((int)((P1 *)_this)->state), 1);
		((P1 *)_this)->state = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 101: // STATE 84
		;
		_m = unsend(((P1 *)_this)->tokenQueue.rcving);
		;
		goto R999;

	case 102: // STATE 87
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 103: // STATE 89
		;
		((P1 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 104: // STATE 96
		;
		XX = 1;
		unrecv(((P1 *)_this)->waitGroup.wait, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 105: // STATE 97
		;
		_m = unsend(((P1 *)_this)->errChan.closing);
		;
		goto R999;

	case 106: // STATE 98
		;
	/* 1 */	((P1 *)_this)->num_msgs = trpt->bup.ovals[3];
	/* 0 */	((P1 *)_this)->state = trpt->bup.ovals[2];
		XX = 1;
		unrecv(((P1 *)_this)->errWrapper.deq, XX-1, 0, ((int)((P1 *)_this)->state), 1);
		unrecv(((P1 *)_this)->errWrapper.deq, XX-1, 1, ((P1 *)_this)->num_msgs, 0);
		((P1 *)_this)->state = trpt->bup.ovals[0];
		((P1 *)_this)->num_msgs = trpt->bup.ovals[1];
		;
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 107: // STATE 99
		;
	/* 0 */	((P1 *)_this)->state = trpt->bup.ovals[1];
		XX = 1;
		unrecv(((P1 *)_this)->errWrapper.sync, XX-1, 0, ((int)((P1 *)_this)->state), 1);
		((P1 *)_this)->state = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 108: // STATE 100
		;
		_m = unsend(((P1 *)_this)->errWrapper.rcving);
		;
		goto R999;

	case 109: // STATE 105
		;
		_m = unsend(((P1 *)_this)->child);
		;
		goto R999;

	case 110: // STATE 106
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 111: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 112: // STATE 3
		;
		p_restor(II);
		;
		;
		goto R999;
	}

