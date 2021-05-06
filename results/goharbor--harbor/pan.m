#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC wgMonitor */
	case 3: // STATE 1 - chartserver++DeleteChart37.pml:316 - [wg.update?i] (0:0:1 - 1)
		reached[6][1] = 1;
		if (q_zero(((P6 *)_this)->wg.update))
		{	if (boq != ((P6 *)_this)->wg.update) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P6 *)_this)->wg.update) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((P6 *)_this)->i;
		;
		((P6 *)_this)->i = qrecv(((P6 *)_this)->wg.update, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("wgMonitor:i", ((P6 *)_this)->i);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P6 *)_this)->wg.update);
		sprintf(simtmp, "%d", ((P6 *)_this)->i); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P6 *)_this)->wg.update))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 4: // STATE 2 - chartserver++DeleteChart37.pml:317 - [wg.Counter = (wg.Counter+i)] (0:11:1 - 1)
		IfNotBlocked
		reached[6][2] = 1;
		(trpt+1)->bup.oval = ((P6 *)_this)->wg.Counter;
		((P6 *)_this)->wg.Counter = (((P6 *)_this)->wg.Counter+((P6 *)_this)->i);
#ifdef VAR_RANGES
		logval("wgMonitor:wg.Counter", ((P6 *)_this)->wg.Counter);
#endif
		;
		/* merge: assert((wg.Counter>=0))(11, 3, 11) */
		reached[6][3] = 1;
		spin_assert((((P6 *)_this)->wg.Counter>=0), "(wg.Counter>=0)", II, tt, t);
		/* merge: .(goto)(0, 12, 11) */
		reached[6][12] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 5: // STATE 4 - chartserver++DeleteChart37.pml:319 - [((wg.Counter==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[6][4] = 1;
		if (!((((P6 *)_this)->wg.Counter==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 5 - chartserver++DeleteChart37.pml:321 - [wg.update?i] (0:0:1 - 1)
		reached[6][5] = 1;
		if (q_zero(((P6 *)_this)->wg.update))
		{	if (boq != ((P6 *)_this)->wg.update) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P6 *)_this)->wg.update) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((P6 *)_this)->i;
		;
		((P6 *)_this)->i = qrecv(((P6 *)_this)->wg.update, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("wgMonitor:i", ((P6 *)_this)->i);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P6 *)_this)->wg.update);
		sprintf(simtmp, "%d", ((P6 *)_this)->i); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P6 *)_this)->wg.update))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 7: // STATE 6 - chartserver++DeleteChart37.pml:322 - [wg.Counter = (wg.Counter+i)] (0:11:1 - 1)
		IfNotBlocked
		reached[6][6] = 1;
		(trpt+1)->bup.oval = ((P6 *)_this)->wg.Counter;
		((P6 *)_this)->wg.Counter = (((P6 *)_this)->wg.Counter+((P6 *)_this)->i);
#ifdef VAR_RANGES
		logval("wgMonitor:wg.Counter", ((P6 *)_this)->wg.Counter);
#endif
		;
		/* merge: assert((wg.Counter>=0))(11, 7, 11) */
		reached[6][7] = 1;
		spin_assert((((P6 *)_this)->wg.Counter>=0), "(wg.Counter>=0)", II, tt, t);
		/* merge: .(goto)(0, 10, 11) */
		reached[6][10] = 1;
		;
		/* merge: .(goto)(0, 12, 11) */
		reached[6][12] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 8: // STATE 8 - chartserver++DeleteChart37.pml:324 - [wg.wait!0] (0:0:0 - 1)
		IfNotBlocked
		reached[6][8] = 1;
		if (q_full(((P6 *)_this)->wg.wait))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P6 *)_this)->wg.wait);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P6 *)_this)->wg.wait, 0, 0, 0, 1);
		if (q_zero(((P6 *)_this)->wg.wait)) { boq = ((P6 *)_this)->wg.wait; };
		_m = 2; goto P999; /* 0 */
	case 9: // STATE 14 - chartserver++DeleteChart37.pml:327 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[6][14] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC sync_monitor */
	case 10: // STATE 2 - chartserver++DeleteChart37.pml:290 - [(ch.closed)] (0:0:0 - 1)
		IfNotBlocked
		reached[5][2] = 1;
		if (!(((int)((P5 *)_this)->ch.closed)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 3 - chartserver++DeleteChart37.pml:292 - [ch.enq?0] (0:0:0 - 1)
		reached[5][3] = 1;
		if (q_zero(((P5 *)_this)->ch.enq))
		{	if (boq != ((P5 *)_this)->ch.enq) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P5 *)_this)->ch.enq) == 0) continue;

		XX=1;
		if (0 != qrecv(((P5 *)_this)->ch.enq, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P5 *)_this)->ch.enq-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P5 *)_this)->ch.enq, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P5 *)_this)->ch.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P5 *)_this)->ch.enq))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 12: // STATE 4 - chartserver++DeleteChart37.pml:293 - [assert((1==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[5][4] = 1;
		spin_assert((1==0), "(1==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 5 - chartserver++DeleteChart37.pml:294 - [ch.closing?1] (0:0:0 - 1)
		reached[5][5] = 1;
		if (q_zero(((P5 *)_this)->ch.closing))
		{	if (boq != ((P5 *)_this)->ch.closing) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P5 *)_this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P5 *)_this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P5 *)_this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P5 *)_this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P5 *)_this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P5 *)_this)->ch.closing))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 14: // STATE 6 - chartserver++DeleteChart37.pml:295 - [assert((2==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[5][6] = 1;
		spin_assert((2==0), "(2==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 7 - chartserver++DeleteChart37.pml:296 - [ch.sending?0] (0:0:0 - 1)
		reached[5][7] = 1;
		if (q_zero(((P5 *)_this)->ch.sending))
		{	if (boq != ((P5 *)_this)->ch.sending) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P5 *)_this)->ch.sending) == 0) continue;

		XX=1;
		if (0 != qrecv(((P5 *)_this)->ch.sending, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P5 *)_this)->ch.sending-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P5 *)_this)->ch.sending, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P5 *)_this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P5 *)_this)->ch.sending))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 16: // STATE 8 - chartserver++DeleteChart37.pml:297 - [assert((1==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[5][8] = 1;
		spin_assert((1==0), "(1==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 9 - chartserver++DeleteChart37.pml:298 - [ch.rcving?0] (0:0:0 - 1)
		reached[5][9] = 1;
		if (q_zero(((P5 *)_this)->ch.rcving))
		{	if (boq != ((P5 *)_this)->ch.rcving) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P5 *)_this)->ch.rcving) == 0) continue;

		XX=1;
		if (0 != qrecv(((P5 *)_this)->ch.rcving, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P5 *)_this)->ch.rcving-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P5 *)_this)->ch.rcving, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P5 *)_this)->ch.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P5 *)_this)->ch.rcving))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 18: // STATE 10 - chartserver++DeleteChart37.pml:299 - [ch.sync!1] (0:0:0 - 1)
		IfNotBlocked
		reached[5][10] = 1;
		if (q_full(((P5 *)_this)->ch.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P5 *)_this)->ch.sync);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P5 *)_this)->ch.sync, 0, 1, 0, 1);
		if (q_zero(((P5 *)_this)->ch.sync)) { boq = ((P5 *)_this)->ch.sync; };
		_m = 2; goto P999; /* 0 */
	case 19: // STATE 14 - chartserver++DeleteChart37.pml:303 - [ch.rcving?0] (0:0:0 - 1)
		reached[5][14] = 1;
		if (q_zero(((P5 *)_this)->ch.rcving))
		{	if (boq != ((P5 *)_this)->ch.rcving) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P5 *)_this)->ch.rcving) == 0) continue;

		XX=1;
		if (0 != qrecv(((P5 *)_this)->ch.rcving, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P5 *)_this)->ch.rcving-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P5 *)_this)->ch.rcving, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P5 *)_this)->ch.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P5 *)_this)->ch.rcving))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 20: // STATE 15 - chartserver++DeleteChart37.pml:304 - [ch.sending?0] (0:0:0 - 1)
		reached[5][15] = 1;
		if (q_zero(((P5 *)_this)->ch.sending))
		{	if (boq != ((P5 *)_this)->ch.sending) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P5 *)_this)->ch.sending) == 0) continue;

		XX=1;
		if (0 != qrecv(((P5 *)_this)->ch.sending, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P5 *)_this)->ch.sending-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P5 *)_this)->ch.sending, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P5 *)_this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P5 *)_this)->ch.sending))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 21: // STATE 16 - chartserver++DeleteChart37.pml:305 - [ch.closing?1] (0:0:0 - 1)
		reached[5][16] = 1;
		if (q_zero(((P5 *)_this)->ch.closing))
		{	if (boq != ((P5 *)_this)->ch.closing) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P5 *)_this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P5 *)_this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P5 *)_this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P5 *)_this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P5 *)_this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P5 *)_this)->ch.closing))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 22: // STATE 17 - chartserver++DeleteChart37.pml:306 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[5][17] = 1;
		(trpt+1)->bup.oval = ((int)((P5 *)_this)->ch.closed);
		((P5 *)_this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("sync_monitor:ch.closed", ((int)((P5 *)_this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 26 - chartserver++DeleteChart37.pml:311 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[5][26] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC AsyncChan */
	case 24: // STATE 2 - chartserver++DeleteChart37.pml:238 - [(ch.closed)] (0:0:0 - 1)
		IfNotBlocked
		reached[4][2] = 1;
		if (!(((int)((P4 *)_this)->ch.closed)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 25: // STATE 3 - chartserver++DeleteChart37.pml:240 - [ch.enq?0] (0:0:0 - 1)
		reached[4][3] = 1;
		if (q_zero(((P4 *)_this)->ch.enq))
		{	if (boq != ((P4 *)_this)->ch.enq) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.enq) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.enq, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.enq-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.enq, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.enq))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 26: // STATE 4 - chartserver++DeleteChart37.pml:241 - [assert((1==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[4][4] = 1;
		spin_assert((1==0), "(1==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 5 - chartserver++DeleteChart37.pml:242 - [ch.closing?1] (0:0:0 - 1)
		reached[4][5] = 1;
		if (q_zero(((P4 *)_this)->ch.closing))
		{	if (boq != ((P4 *)_this)->ch.closing) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P4 *)_this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.closing))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 28: // STATE 6 - chartserver++DeleteChart37.pml:243 - [assert((2==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[4][6] = 1;
		spin_assert((2==0), "(2==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 29: // STATE 7 - chartserver++DeleteChart37.pml:244 - [ch.rcving?0] (0:0:0 - 1)
		reached[4][7] = 1;
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	if (boq != ((P4 *)_this)->ch.rcving) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.rcving) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.rcving, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.rcving-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 30: // STATE 8 - chartserver++DeleteChart37.pml:245 - [ch.sending?0] (0:0:0 - 1)
		reached[4][8] = 1;
		if (q_zero(((P4 *)_this)->ch.sending))
		{	if (boq != ((P4 *)_this)->ch.sending) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.sending) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.sending, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.sending-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.sending, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.sending))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 31: // STATE 9 - chartserver++DeleteChart37.pml:246 - [assert((1==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[4][9] = 1;
		spin_assert((1==0), "(1==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 32: // STATE 10 - chartserver++DeleteChart37.pml:247 - [ch.sync!1] (0:0:0 - 1)
		IfNotBlocked
		reached[4][10] = 1;
		if (q_full(((P4 *)_this)->ch.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P4 *)_this)->ch.sync);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P4 *)_this)->ch.sync, 0, 1, 0, 1);
		if (q_zero(((P4 *)_this)->ch.sync)) { boq = ((P4 *)_this)->ch.sync; };
		_m = 2; goto P999; /* 0 */
	case 33: // STATE 11 - chartserver++DeleteChart37.pml:248 - [ch.num_msgs = (ch.num_msgs-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[4][11] = 1;
		(trpt+1)->bup.oval = ((P4 *)_this)->ch.num_msgs;
		((P4 *)_this)->ch.num_msgs = (((P4 *)_this)->ch.num_msgs-1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P4 *)_this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 34: // STATE 15 - chartserver++DeleteChart37.pml:252 - [((ch.num_msgs==ch.size))] (0:0:0 - 1)
		IfNotBlocked
		reached[4][15] = 1;
		if (!((((P4 *)_this)->ch.num_msgs==((P4 *)_this)->ch.size)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 35: // STATE 16 - chartserver++DeleteChart37.pml:254 - [ch.deq!0,ch.num_msgs] (0:0:0 - 1)
		IfNotBlocked
		reached[4][16] = 1;
		if (q_full(((P4 *)_this)->ch.deq))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P4 *)_this)->ch.deq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P4 *)_this)->ch.num_msgs); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P4 *)_this)->ch.deq, 0, 0, ((P4 *)_this)->ch.num_msgs, 2);
		if (q_zero(((P4 *)_this)->ch.deq)) { boq = ((P4 *)_this)->ch.deq; };
		_m = 2; goto P999; /* 0 */
	case 36: // STATE 17 - chartserver++DeleteChart37.pml:255 - [ch.num_msgs = (ch.num_msgs-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[4][17] = 1;
		(trpt+1)->bup.oval = ((P4 *)_this)->ch.num_msgs;
		((P4 *)_this)->ch.num_msgs = (((P4 *)_this)->ch.num_msgs-1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P4 *)_this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 37: // STATE 18 - chartserver++DeleteChart37.pml:256 - [ch.closing?1] (0:0:0 - 1)
		reached[4][18] = 1;
		if (q_zero(((P4 *)_this)->ch.closing))
		{	if (boq != ((P4 *)_this)->ch.closing) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P4 *)_this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.closing))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 38: // STATE 19 - chartserver++DeleteChart37.pml:257 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[4][19] = 1;
		(trpt+1)->bup.oval = ((int)((P4 *)_this)->ch.closed);
		((P4 *)_this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("AsyncChan:ch.closed", ((int)((P4 *)_this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 39: // STATE 20 - chartserver++DeleteChart37.pml:258 - [ch.rcving?0] (0:0:0 - 1)
		reached[4][20] = 1;
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	if (boq != ((P4 *)_this)->ch.rcving) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.rcving) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.rcving, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.rcving-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 40: // STATE 21 - chartserver++DeleteChart37.pml:259 - [ch.sending?0] (0:0:0 - 1)
		reached[4][21] = 1;
		if (q_zero(((P4 *)_this)->ch.sending))
		{	if (boq != ((P4 *)_this)->ch.sending) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.sending) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.sending, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.sending-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.sending, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.sending))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 41: // STATE 24 - chartserver++DeleteChart37.pml:261 - [((ch.num_msgs==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[4][24] = 1;
		if (!((((P4 *)_this)->ch.num_msgs==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 42: // STATE 25 - chartserver++DeleteChart37.pml:263 - [ch.enq?0] (0:0:0 - 1)
		reached[4][25] = 1;
		if (q_zero(((P4 *)_this)->ch.enq))
		{	if (boq != ((P4 *)_this)->ch.enq) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.enq) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.enq, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.enq-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.enq, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.enq))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 43: // STATE 26 - chartserver++DeleteChart37.pml:264 - [ch.num_msgs = (ch.num_msgs+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[4][26] = 1;
		(trpt+1)->bup.oval = ((P4 *)_this)->ch.num_msgs;
		((P4 *)_this)->ch.num_msgs = (((P4 *)_this)->ch.num_msgs+1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P4 *)_this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 44: // STATE 27 - chartserver++DeleteChart37.pml:265 - [ch.closing?1] (0:0:0 - 1)
		reached[4][27] = 1;
		if (q_zero(((P4 *)_this)->ch.closing))
		{	if (boq != ((P4 *)_this)->ch.closing) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P4 *)_this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.closing))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 45: // STATE 28 - chartserver++DeleteChart37.pml:266 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[4][28] = 1;
		(trpt+1)->bup.oval = ((int)((P4 *)_this)->ch.closed);
		((P4 *)_this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("AsyncChan:ch.closed", ((int)((P4 *)_this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 46: // STATE 29 - chartserver++DeleteChart37.pml:267 - [ch.rcving?0] (0:0:0 - 1)
		reached[4][29] = 1;
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	if (boq != ((P4 *)_this)->ch.rcving) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.rcving) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.rcving, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.rcving-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 47: // STATE 30 - chartserver++DeleteChart37.pml:268 - [ch.sending?0] (0:0:0 - 1)
		reached[4][30] = 1;
		if (q_zero(((P4 *)_this)->ch.sending))
		{	if (boq != ((P4 *)_this)->ch.sending) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.sending) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.sending, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.sending-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.sending, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.sending))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 48: // STATE 34 - chartserver++DeleteChart37.pml:272 - [ch.enq?0] (0:0:0 - 1)
		reached[4][34] = 1;
		if (q_zero(((P4 *)_this)->ch.enq))
		{	if (boq != ((P4 *)_this)->ch.enq) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.enq) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.enq, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.enq-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.enq, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.enq))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 49: // STATE 35 - chartserver++DeleteChart37.pml:273 - [ch.num_msgs = (ch.num_msgs+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[4][35] = 1;
		(trpt+1)->bup.oval = ((P4 *)_this)->ch.num_msgs;
		((P4 *)_this)->ch.num_msgs = (((P4 *)_this)->ch.num_msgs+1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P4 *)_this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 50: // STATE 36 - chartserver++DeleteChart37.pml:274 - [ch.deq!0,ch.num_msgs] (0:0:0 - 1)
		IfNotBlocked
		reached[4][36] = 1;
		if (q_full(((P4 *)_this)->ch.deq))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P4 *)_this)->ch.deq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P4 *)_this)->ch.num_msgs); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P4 *)_this)->ch.deq, 0, 0, ((P4 *)_this)->ch.num_msgs, 2);
		if (q_zero(((P4 *)_this)->ch.deq)) { boq = ((P4 *)_this)->ch.deq; };
		_m = 2; goto P999; /* 0 */
	case 51: // STATE 37 - chartserver++DeleteChart37.pml:275 - [ch.num_msgs = (ch.num_msgs-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[4][37] = 1;
		(trpt+1)->bup.oval = ((P4 *)_this)->ch.num_msgs;
		((P4 *)_this)->ch.num_msgs = (((P4 *)_this)->ch.num_msgs-1);
#ifdef VAR_RANGES
		logval("AsyncChan:ch.num_msgs", ((P4 *)_this)->ch.num_msgs);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 52: // STATE 38 - chartserver++DeleteChart37.pml:276 - [ch.closing?1] (0:0:0 - 1)
		reached[4][38] = 1;
		if (q_zero(((P4 *)_this)->ch.closing))
		{	if (boq != ((P4 *)_this)->ch.closing) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.closing) == 0) continue;

		XX=1;
		if (1 != qrecv(((P4 *)_this)->ch.closing, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.closing-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.closing, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.closing))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 53: // STATE 39 - chartserver++DeleteChart37.pml:277 - [ch.closed = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[4][39] = 1;
		(trpt+1)->bup.oval = ((int)((P4 *)_this)->ch.closed);
		((P4 *)_this)->ch.closed = 1;
#ifdef VAR_RANGES
		logval("AsyncChan:ch.closed", ((int)((P4 *)_this)->ch.closed));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 54: // STATE 40 - chartserver++DeleteChart37.pml:278 - [ch.rcving?0] (0:0:0 - 1)
		reached[4][40] = 1;
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	if (boq != ((P4 *)_this)->ch.rcving) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.rcving) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.rcving, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.rcving-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.rcving, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.rcving))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 55: // STATE 41 - chartserver++DeleteChart37.pml:279 - [ch.sending?0] (0:0:0 - 1)
		reached[4][41] = 1;
		if (q_zero(((P4 *)_this)->ch.sending))
		{	if (boq != ((P4 *)_this)->ch.sending) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P4 *)_this)->ch.sending) == 0) continue;

		XX=1;
		if (0 != qrecv(((P4 *)_this)->ch.sending, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P4 *)_this)->ch.sending-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P4 *)_this)->ch.sending, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P4 *)_this)->ch.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P4 *)_this)->ch.sending))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 56: // STATE 51 - chartserver++DeleteChart37.pml:284 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[4][51] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC AnonymousDeleteChart9898 */
	case 57: // STATE 2 - chartserver++DeleteChart37.pml:213 - [errChan.enq!0] (0:0:0 - 1)
		IfNotBlocked
		reached[3][2] = 1;
		if (q_full(((P3 *)_this)->errChan.enq))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->errChan.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->errChan.enq, 0, 0, 0, 1);
		if (q_zero(((P3 *)_this)->errChan.enq)) { boq = ((P3 *)_this)->errChan.enq; };
		_m = 2; goto P999; /* 0 */
	case 58: // STATE 3 - chartserver++DeleteChart37.pml:214 - [errChan.sync!0] (0:0:0 - 1)
		IfNotBlocked
		reached[3][3] = 1;
		if (q_full(((P3 *)_this)->errChan.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->errChan.sync);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->errChan.sync, 0, 0, 0, 1);
		if (q_zero(((P3 *)_this)->errChan.sync)) { boq = ((P3 *)_this)->errChan.sync; };
		_m = 2; goto P999; /* 0 */
	case 59: // STATE 4 - chartserver++DeleteChart37.pml:215 - [errChan.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[3][4] = 1;
		if (q_full(((P3 *)_this)->errChan.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->errChan.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->errChan.sending, 0, 0, 0, 1);
		if (q_zero(((P3 *)_this)->errChan.sending)) { boq = ((P3 *)_this)->errChan.sending; };
		_m = 2; goto P999; /* 0 */
	case 60: // STATE 11 - chartserver++DeleteChart37.pml:223 - [tokenQueue.enq!0] (0:0:0 - 1)
		IfNotBlocked
		reached[3][11] = 1;
		if (q_full(((P3 *)_this)->tokenQueue.enq))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->tokenQueue.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->tokenQueue.enq, 0, 0, 0, 1);
		if (q_zero(((P3 *)_this)->tokenQueue.enq)) { boq = ((P3 *)_this)->tokenQueue.enq; };
		_m = 2; goto P999; /* 0 */
	case 61: // STATE 12 - chartserver++DeleteChart37.pml:224 - [tokenQueue.sync!0] (0:0:0 - 1)
		IfNotBlocked
		reached[3][12] = 1;
		if (q_full(((P3 *)_this)->tokenQueue.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->tokenQueue.sync);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->tokenQueue.sync, 0, 0, 0, 1);
		if (q_zero(((P3 *)_this)->tokenQueue.sync)) { boq = ((P3 *)_this)->tokenQueue.sync; };
		_m = 2; goto P999; /* 0 */
	case 62: // STATE 13 - chartserver++DeleteChart37.pml:225 - [tokenQueue.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[3][13] = 1;
		if (q_full(((P3 *)_this)->tokenQueue.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->tokenQueue.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->tokenQueue.sending, 0, 0, 0, 1);
		if (q_zero(((P3 *)_this)->tokenQueue.sending)) { boq = ((P3 *)_this)->tokenQueue.sending; };
		_m = 2; goto P999; /* 0 */
	case 63: // STATE 16 - chartserver++DeleteChart37.pml:227 - [waitGroup.update!-(1)] (0:0:0 - 3)
		IfNotBlocked
		reached[3][16] = 1;
		if (q_full(((P3 *)_this)->waitGroup.update))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->waitGroup.update);
		sprintf(simtmp, "%d",  -(1)); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->waitGroup.update, 0,  -(1), 0, 1);
		if (q_zero(((P3 *)_this)->waitGroup.update)) { boq = ((P3 *)_this)->waitGroup.update; };
		_m = 2; goto P999; /* 0 */
	case 64: // STATE 17 - chartserver++DeleteChart37.pml:228 - [child!0] (0:0:0 - 1)
		IfNotBlocked
		reached[3][17] = 1;
		if (q_full(((P3 *)_this)->child))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P3 *)_this)->child);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P3 *)_this)->child, 0, 0, 0, 1);
		if (q_zero(((P3 *)_this)->child)) { boq = ((P3 *)_this)->child; };
		_m = 2; goto P999; /* 0 */
	case 65: // STATE 18 - chartserver++DeleteChart37.pml:229 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[3][18] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC AnonymousDeleteChart7764 */
	case 66: // STATE 2 - chartserver++DeleteChart37.pml:169 - [errChan.deq?state,num_msgs] (0:0:2 - 1)
		reached[2][2] = 1;
		if (q_zero(((P2 *)_this)->errChan.deq))
		{	if (boq != ((P2 *)_this)->errChan.deq) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P2 *)_this)->errChan.deq) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P2 *)_this)->state);
		(trpt+1)->bup.ovals[1] = ((P2 *)_this)->num_msgs;
		;
		((P2 *)_this)->state = qrecv(((P2 *)_this)->errChan.deq, XX-1, 0, 0);
#ifdef VAR_RANGES
		logval("AnonymousDeleteChart7764:state", ((int)((P2 *)_this)->state));
#endif
		;
		((P2 *)_this)->num_msgs = qrecv(((P2 *)_this)->errChan.deq, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval("AnonymousDeleteChart7764:num_msgs", ((P2 *)_this)->num_msgs);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P2 *)_this)->errChan.deq);
		sprintf(simtmp, "%d", ((int)((P2 *)_this)->state)); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P2 *)_this)->num_msgs); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P2 *)_this)->errChan.deq))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 67: // STATE 3 - chartserver++DeleteChart37.pml:170 - [errChan.sync?state] (0:0:1 - 1)
		reached[2][3] = 1;
		if (q_zero(((P2 *)_this)->errChan.sync))
		{	if (boq != ((P2 *)_this)->errChan.sync) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P2 *)_this)->errChan.sync) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->state);
		;
		((P2 *)_this)->state = qrecv(((P2 *)_this)->errChan.sync, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("AnonymousDeleteChart7764:state", ((int)((P2 *)_this)->state));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P2 *)_this)->errChan.sync);
		sprintf(simtmp, "%d", ((int)((P2 *)_this)->state)); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P2 *)_this)->errChan.sync))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 68: // STATE 4 - chartserver++DeleteChart37.pml:171 - [errChan.rcving!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (q_full(((P2 *)_this)->errChan.rcving))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->errChan.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->errChan.rcving, 0, 0, 0, 1);
		if (q_zero(((P2 *)_this)->errChan.rcving)) { boq = ((P2 *)_this)->errChan.rcving; };
		_m = 2; goto P999; /* 0 */
	case 69: // STATE 7 - chartserver++DeleteChart37.pml:176 - [((state&&(num_msgs<=0)))] (0:0:2 - 1)
		IfNotBlocked
		reached[2][7] = 1;
		if (!((((int)((P2 *)_this)->state)&&(((P2 *)_this)->num_msgs<=0))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: state */  (trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P2 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->state = 0;
		if (TstOnly) return 1; /* TT */
		/* dead 1: num_msgs */  (trpt+1)->bup.ovals[1] = ((P2 *)_this)->num_msgs;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->num_msgs = 0;
		_m = 3; goto P999; /* 0 */
	case 70: // STATE 20 - chartserver++DeleteChart37.pml:192 - [errWrapper.enq!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][20] = 1;
		if (q_full(((P2 *)_this)->errWrapper.enq))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->errWrapper.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->errWrapper.enq, 0, 0, 0, 1);
		if (q_zero(((P2 *)_this)->errWrapper.enq)) { boq = ((P2 *)_this)->errWrapper.enq; };
		_m = 2; goto P999; /* 0 */
	case 71: // STATE 21 - chartserver++DeleteChart37.pml:193 - [errWrapper.sync!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][21] = 1;
		if (q_full(((P2 *)_this)->errWrapper.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->errWrapper.sync);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->errWrapper.sync, 0, 0, 0, 1);
		if (q_zero(((P2 *)_this)->errWrapper.sync)) { boq = ((P2 *)_this)->errWrapper.sync; };
		_m = 2; goto P999; /* 0 */
	case 72: // STATE 22 - chartserver++DeleteChart37.pml:194 - [errWrapper.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][22] = 1;
		if (q_full(((P2 *)_this)->errWrapper.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->errWrapper.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->errWrapper.sending, 0, 0, 0, 1);
		if (q_zero(((P2 *)_this)->errWrapper.sending)) { boq = ((P2 *)_this)->errWrapper.sending; };
		_m = 2; goto P999; /* 0 */
	case 73: // STATE 28 - chartserver++DeleteChart37.pml:198 - [errWrapper.closing!1] (0:0:0 - 5)
		IfNotBlocked
		reached[2][28] = 1;
		if (q_full(((P2 *)_this)->errWrapper.closing))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->errWrapper.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->errWrapper.closing, 0, 1, 0, 1);
		if (q_zero(((P2 *)_this)->errWrapper.closing)) { boq = ((P2 *)_this)->errWrapper.closing; };
		_m = 2; goto P999; /* 0 */
	case 74: // STATE 29 - chartserver++DeleteChart37.pml:199 - [child!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][29] = 1;
		if (q_full(((P2 *)_this)->child))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)_this)->child);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)_this)->child, 0, 0, 0, 1);
		if (q_zero(((P2 *)_this)->child)) { boq = ((P2 *)_this)->child; };
		_m = 2; goto P999; /* 0 */
	case 75: // STATE 30 - chartserver++DeleteChart37.pml:200 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][30] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC DeleteChart37 */
	case 76: // STATE 21 - chartserver++DeleteChart37.pml:73 - [((qSize>0))] (23:0:1 - 1)
		IfNotBlocked
		reached[1][21] = 1;
		if (!((((P1 *)_this)->qSize>0)))
			continue;
		/* merge: tokenQueue.size = qSize(0, 22, 23) */
		reached[1][22] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->tokenQueue.size;
		((P1 *)_this)->tokenQueue.size = ((P1 *)_this)->qSize;
#ifdef VAR_RANGES
		logval("DeleteChart37:tokenQueue.size", ((P1 *)_this)->tokenQueue.size);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 77: // STATE 23 - chartserver++DeleteChart37.pml:75 - [(run AsyncChan(tokenQueue.sync,tokenQueue.enq,tokenQueue.deq,tokenQueue.sending,tokenQueue.rcving,tokenQueue.closing,tokenQueue.size,tokenQueue.num_msgs,tokenQueue.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][23] = 1;
		if (!(addproc(II, 1, 4, ((P1 *)_this)->tokenQueue.sync, ((P1 *)_this)->tokenQueue.enq, ((P1 *)_this)->tokenQueue.deq, ((P1 *)_this)->tokenQueue.sending, ((P1 *)_this)->tokenQueue.rcving, ((P1 *)_this)->tokenQueue.closing, ((P1 *)_this)->tokenQueue.size, ((P1 *)_this)->tokenQueue.num_msgs, ((int)((P1 *)_this)->tokenQueue.closed), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 78: // STATE 25 - chartserver++DeleteChart37.pml:77 - [(run sync_monitor(tokenQueue.sync,tokenQueue.enq,tokenQueue.deq,tokenQueue.sending,tokenQueue.rcving,tokenQueue.closing,tokenQueue.size,tokenQueue.num_msgs,tokenQueue.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][25] = 1;
		if (!(addproc(II, 1, 5, ((P1 *)_this)->tokenQueue.sync, ((P1 *)_this)->tokenQueue.enq, ((P1 *)_this)->tokenQueue.deq, ((P1 *)_this)->tokenQueue.sending, ((P1 *)_this)->tokenQueue.rcving, ((P1 *)_this)->tokenQueue.closing, ((P1 *)_this)->tokenQueue.size, ((P1 *)_this)->tokenQueue.num_msgs, ((int)((P1 *)_this)->tokenQueue.closed), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 79: // STATE 28 - chartserver++DeleteChart37.pml:82 - [((1>0))] (30:0:1 - 1)
		IfNotBlocked
		reached[1][28] = 1;
		if (!((1>0)))
			continue;
		/* merge: errChan.size = 1(0, 29, 30) */
		reached[1][29] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->errChan.size;
		((P1 *)_this)->errChan.size = 1;
#ifdef VAR_RANGES
		logval("DeleteChart37:errChan.size", ((P1 *)_this)->errChan.size);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 80: // STATE 30 - chartserver++DeleteChart37.pml:84 - [(run AsyncChan(errChan.sync,errChan.enq,errChan.deq,errChan.sending,errChan.rcving,errChan.closing,errChan.size,errChan.num_msgs,errChan.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][30] = 1;
		if (!(addproc(II, 1, 4, ((P1 *)_this)->errChan.sync, ((P1 *)_this)->errChan.enq, ((P1 *)_this)->errChan.deq, ((P1 *)_this)->errChan.sending, ((P1 *)_this)->errChan.rcving, ((P1 *)_this)->errChan.closing, ((P1 *)_this)->errChan.size, ((P1 *)_this)->errChan.num_msgs, ((int)((P1 *)_this)->errChan.closed), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 81: // STATE 32 - chartserver++DeleteChart37.pml:86 - [(run sync_monitor(errChan.sync,errChan.enq,errChan.deq,errChan.sending,errChan.rcving,errChan.closing,errChan.size,errChan.num_msgs,errChan.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][32] = 1;
		if (!(addproc(II, 1, 5, ((P1 *)_this)->errChan.sync, ((P1 *)_this)->errChan.enq, ((P1 *)_this)->errChan.deq, ((P1 *)_this)->errChan.sending, ((P1 *)_this)->errChan.rcving, ((P1 *)_this)->errChan.closing, ((P1 *)_this)->errChan.size, ((P1 *)_this)->errChan.num_msgs, ((int)((P1 *)_this)->errChan.closed), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 82: // STATE 35 - chartserver++DeleteChart37.pml:88 - [(run wgMonitor(waitGroup.update,waitGroup.wait,waitGroup.Counter))] (0:0:0 - 3)
		IfNotBlocked
		reached[1][35] = 1;
		if (!(addproc(II, 1, 6, ((P1 *)_this)->waitGroup.update, ((P1 *)_this)->waitGroup.wait, ((P1 *)_this)->waitGroup.Counter, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 83: // STATE 36 - chartserver++DeleteChart37.pml:89 - [waitGroup.update!allVersions] (0:0:0 - 1)
		IfNotBlocked
		reached[1][36] = 1;
		if (q_full(((P1 *)_this)->waitGroup.update))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->waitGroup.update);
		sprintf(simtmp, "%d", ((P1 *)_this)->allVersions); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->waitGroup.update, 0, ((P1 *)_this)->allVersions, 0, 1);
		if (q_zero(((P1 *)_this)->waitGroup.update)) { boq = ((P1 *)_this)->waitGroup.update; };
		_m = 2; goto P999; /* 0 */
	case 84: // STATE 37 - chartserver++DeleteChart37.pml:93 - [(((0!=-(2))&&((qSize-1)!=-(3))))] (50:0:1 - 1)
		IfNotBlocked
		reached[1][37] = 1;
		if (!(((0!= -(2))&&((((P1 *)_this)->qSize-1)!= -(3)))))
			continue;
		/* merge: i = 0(0, 38, 50) */
		reached[1][38] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->i;
		((P1 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval("DeleteChart37:i", ((P1 *)_this)->i);
#endif
		;
		/* merge: .(goto)(0, 51, 50) */
		reached[1][51] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 85: // STATE 39 - chartserver++DeleteChart37.pml:94 - [((i<=(qSize-1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][39] = 1;
		if (!((((P1 *)_this)->i<=(((P1 *)_this)->qSize-1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 86: // STATE 41 - chartserver++DeleteChart37.pml:99 - [tokenQueue.enq!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][41] = 1;
		if (q_full(((P1 *)_this)->tokenQueue.enq))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->tokenQueue.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->tokenQueue.enq, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->tokenQueue.enq)) { boq = ((P1 *)_this)->tokenQueue.enq; };
		_m = 2; goto P999; /* 0 */
	case 87: // STATE 42 - chartserver++DeleteChart37.pml:100 - [tokenQueue.sync!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][42] = 1;
		if (q_full(((P1 *)_this)->tokenQueue.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->tokenQueue.sync);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->tokenQueue.sync, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->tokenQueue.sync)) { boq = ((P1 *)_this)->tokenQueue.sync; };
		_m = 2; goto P999; /* 0 */
	case 88: // STATE 43 - chartserver++DeleteChart37.pml:101 - [tokenQueue.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][43] = 1;
		if (q_full(((P1 *)_this)->tokenQueue.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->tokenQueue.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->tokenQueue.sending, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->tokenQueue.sending)) { boq = ((P1 *)_this)->tokenQueue.sending; };
		_m = 2; goto P999; /* 0 */
	case 89: // STATE 46 - chartserver++DeleteChart37.pml:103 - [(1)] (50:0:1 - 3)
		IfNotBlocked
		reached[1][46] = 1;
		if (!(1))
			continue;
		/* merge: i = (i+1)(0, 47, 50) */
		reached[1][47] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->i;
		((P1 *)_this)->i = (((P1 *)_this)->i+1);
#ifdef VAR_RANGES
		logval("DeleteChart37:i", ((P1 *)_this)->i);
#endif
		;
		/* merge: .(goto)(0, 51, 50) */
		reached[1][51] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 90: // STATE 57 - chartserver++DeleteChart37.pml:113 - [tokenQueue.enq!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][57] = 1;
		if (q_full(((P1 *)_this)->tokenQueue.enq))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->tokenQueue.enq);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->tokenQueue.enq, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->tokenQueue.enq)) { boq = ((P1 *)_this)->tokenQueue.enq; };
		_m = 2; goto P999; /* 0 */
	case 91: // STATE 58 - chartserver++DeleteChart37.pml:114 - [tokenQueue.sync!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][58] = 1;
		if (q_full(((P1 *)_this)->tokenQueue.sync))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->tokenQueue.sync);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->tokenQueue.sync, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->tokenQueue.sync)) { boq = ((P1 *)_this)->tokenQueue.sync; };
		_m = 2; goto P999; /* 0 */
	case 92: // STATE 59 - chartserver++DeleteChart37.pml:115 - [tokenQueue.sending!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][59] = 1;
		if (q_full(((P1 *)_this)->tokenQueue.sending))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->tokenQueue.sending);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->tokenQueue.sending, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->tokenQueue.sending)) { boq = ((P1 *)_this)->tokenQueue.sending; };
		_m = 2; goto P999; /* 0 */
	case 93: // STATE 71 - chartserver++DeleteChart37.pml:126 - [((1>0))] (73:0:1 - 1)
		IfNotBlocked
		reached[1][71] = 1;
		if (!((1>0)))
			continue;
		/* merge: errWrapper.size = 1(0, 72, 73) */
		reached[1][72] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->errWrapper.size;
		((P1 *)_this)->errWrapper.size = 1;
#ifdef VAR_RANGES
		logval("DeleteChart37:errWrapper.size", ((P1 *)_this)->errWrapper.size);
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 94: // STATE 73 - chartserver++DeleteChart37.pml:128 - [(run AsyncChan(errWrapper.sync,errWrapper.enq,errWrapper.deq,errWrapper.sending,errWrapper.rcving,errWrapper.closing,errWrapper.size,errWrapper.num_msgs,errWrapper.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][73] = 1;
		if (!(addproc(II, 1, 4, ((P1 *)_this)->errWrapper.sync, ((P1 *)_this)->errWrapper.enq, ((P1 *)_this)->errWrapper.deq, ((P1 *)_this)->errWrapper.sending, ((P1 *)_this)->errWrapper.rcving, ((P1 *)_this)->errWrapper.closing, ((P1 *)_this)->errWrapper.size, ((P1 *)_this)->errWrapper.num_msgs, ((int)((P1 *)_this)->errWrapper.closed), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 95: // STATE 75 - chartserver++DeleteChart37.pml:130 - [(run sync_monitor(errWrapper.sync,errWrapper.enq,errWrapper.deq,errWrapper.sending,errWrapper.rcving,errWrapper.closing,errWrapper.size,errWrapper.num_msgs,errWrapper.closed))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][75] = 1;
		if (!(addproc(II, 1, 5, ((P1 *)_this)->errWrapper.sync, ((P1 *)_this)->errWrapper.enq, ((P1 *)_this)->errWrapper.deq, ((P1 *)_this)->errWrapper.sending, ((P1 *)_this)->errWrapper.rcving, ((P1 *)_this)->errWrapper.closing, ((P1 *)_this)->errWrapper.size, ((P1 *)_this)->errWrapper.num_msgs, ((int)((P1 *)_this)->errWrapper.closed), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 96: // STATE 78 - chartserver++DeleteChart37.pml:132 - [(run AnonymousDeleteChart7764(tokenQueue.sync,tokenQueue.enq,tokenQueue.deq,tokenQueue.sending,tokenQueue.rcving,tokenQueue.closing,tokenQueue.size,tokenQueue.num_msgs,tokenQueue.closed,errChan.sync,errChan.enq,errChan.deq,errChan.sending,errChan.rcving,errChan.closing,errChan.size,errChan.num_msgs,errChan.closed,errWrapper.sync,errWrapper.enq,errWrapper.deq,errWrapper.sending,errWrapper.rcving,errWrapper.closing,errWrapper.size,errWrapper.num_msgs,errWrapper.closed,waitGroup.update,waitGroup.wait,waitGroup.Counter,child_AnonymousDeleteChart77640))] (0:0:0 - 3)
		IfNotBlocked
		reached[1][78] = 1;
		if (!(addproc(II, 1, 2, ((P1 *)_this)->tokenQueue.sync, ((P1 *)_this)->tokenQueue.enq, ((P1 *)_this)->tokenQueue.deq, ((P1 *)_this)->tokenQueue.sending, ((P1 *)_this)->tokenQueue.rcving, ((P1 *)_this)->tokenQueue.closing, ((P1 *)_this)->tokenQueue.size, ((P1 *)_this)->tokenQueue.num_msgs, ((int)((P1 *)_this)->tokenQueue.closed), ((P1 *)_this)->errChan.sync, ((P1 *)_this)->errChan.enq, ((P1 *)_this)->errChan.deq, ((P1 *)_this)->errChan.sending, ((P1 *)_this)->errChan.rcving, ((P1 *)_this)->errChan.closing, ((P1 *)_this)->errChan.size, ((P1 *)_this)->errChan.num_msgs, ((int)((P1 *)_this)->errChan.closed), ((P1 *)_this)->errWrapper.sync, ((P1 *)_this)->errWrapper.enq, ((P1 *)_this)->errWrapper.deq, ((P1 *)_this)->errWrapper.sending, ((P1 *)_this)->errWrapper.rcving, ((P1 *)_this)->errWrapper.closing, ((P1 *)_this)->errWrapper.size, ((P1 *)_this)->errWrapper.num_msgs, ((int)((P1 *)_this)->errWrapper.closed), ((P1 *)_this)->waitGroup.update, ((P1 *)_this)->waitGroup.wait, ((P1 *)_this)->waitGroup.Counter, ((P1 *)_this)->child_AnonymousDeleteChart77640)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 97: // STATE 79 - chartserver++DeleteChart37.pml:133 - [i = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][79] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->i;
		((P1 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval("DeleteChart37:i", ((P1 *)_this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 98: // STATE 80 - chartserver++DeleteChart37.pml:133 - [((i<=(allVersions-1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][80] = 1;
		if (!((((P1 *)_this)->i<=(((P1 *)_this)->allVersions-1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 99: // STATE 82 - chartserver++DeleteChart37.pml:138 - [tokenQueue.deq?state,num_msgs] (0:0:4 - 1)
		reached[1][82] = 1;
		if (q_zero(((P1 *)_this)->tokenQueue.deq))
		{	if (boq != ((P1 *)_this)->tokenQueue.deq) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P1 *)_this)->tokenQueue.deq) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->state);
		(trpt+1)->bup.ovals[1] = ((P1 *)_this)->num_msgs;
		;
		((P1 *)_this)->state = qrecv(((P1 *)_this)->tokenQueue.deq, XX-1, 0, 0);
#ifdef VAR_RANGES
		logval("DeleteChart37:state", ((int)((P1 *)_this)->state));
#endif
		;
		((P1 *)_this)->num_msgs = qrecv(((P1 *)_this)->tokenQueue.deq, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval("DeleteChart37:num_msgs", ((P1 *)_this)->num_msgs);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)_this)->tokenQueue.deq);
		sprintf(simtmp, "%d", ((int)((P1 *)_this)->state)); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P1 *)_this)->num_msgs); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)_this)->tokenQueue.deq))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: state */  (trpt+1)->bup.ovals[2] = ((P1 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->state = 0;
		if (TstOnly) return 1; /* TT */
		/* dead 2: num_msgs */  (trpt+1)->bup.ovals[3] = ((P1 *)_this)->num_msgs;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->num_msgs = 0;
		_m = 4; goto P999; /* 0 */
	case 100: // STATE 83 - chartserver++DeleteChart37.pml:139 - [tokenQueue.sync?state] (0:0:2 - 1)
		reached[1][83] = 1;
		if (q_zero(((P1 *)_this)->tokenQueue.sync))
		{	if (boq != ((P1 *)_this)->tokenQueue.sync) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P1 *)_this)->tokenQueue.sync) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->state);
		;
		((P1 *)_this)->state = qrecv(((P1 *)_this)->tokenQueue.sync, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("DeleteChart37:state", ((int)((P1 *)_this)->state));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)_this)->tokenQueue.sync);
		sprintf(simtmp, "%d", ((int)((P1 *)_this)->state)); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)_this)->tokenQueue.sync))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: state */  (trpt+1)->bup.ovals[1] = ((P1 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->state = 0;
		_m = 4; goto P999; /* 0 */
	case 101: // STATE 84 - chartserver++DeleteChart37.pml:140 - [tokenQueue.rcving!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][84] = 1;
		if (q_full(((P1 *)_this)->tokenQueue.rcving))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->tokenQueue.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->tokenQueue.rcving, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->tokenQueue.rcving)) { boq = ((P1 *)_this)->tokenQueue.rcving; };
		_m = 2; goto P999; /* 0 */
	case 102: // STATE 87 - chartserver++DeleteChart37.pml:142 - [(run AnonymousDeleteChart9898(tokenQueue.sync,tokenQueue.enq,tokenQueue.deq,tokenQueue.sending,tokenQueue.rcving,tokenQueue.closing,tokenQueue.size,tokenQueue.num_msgs,tokenQueue.closed,errChan.sync,errChan.enq,errChan.deq,errChan.sending,errChan.rcving,errChan.closing,errChan.size,errChan.num_msgs,errChan.closed,errWrapper.sync,errWrapper.enq,errWrapper.deq,errWrapper.sending,errWrapper.rcving,errWrapper.closing,errWrapper.size,errWrapper.num_msgs,errWrapper.closed,waitGroup.update,waitGroup.wait,waitGroup.Counter,child_AnonymousDeleteChart98981))] (0:0:0 - 3)
		IfNotBlocked
		reached[1][87] = 1;
		if (!(addproc(II, 1, 3, ((P1 *)_this)->tokenQueue.sync, ((P1 *)_this)->tokenQueue.enq, ((P1 *)_this)->tokenQueue.deq, ((P1 *)_this)->tokenQueue.sending, ((P1 *)_this)->tokenQueue.rcving, ((P1 *)_this)->tokenQueue.closing, ((P1 *)_this)->tokenQueue.size, ((P1 *)_this)->tokenQueue.num_msgs, ((int)((P1 *)_this)->tokenQueue.closed), ((P1 *)_this)->errChan.sync, ((P1 *)_this)->errChan.enq, ((P1 *)_this)->errChan.deq, ((P1 *)_this)->errChan.sending, ((P1 *)_this)->errChan.rcving, ((P1 *)_this)->errChan.closing, ((P1 *)_this)->errChan.size, ((P1 *)_this)->errChan.num_msgs, ((int)((P1 *)_this)->errChan.closed), ((P1 *)_this)->errWrapper.sync, ((P1 *)_this)->errWrapper.enq, ((P1 *)_this)->errWrapper.deq, ((P1 *)_this)->errWrapper.sending, ((P1 *)_this)->errWrapper.rcving, ((P1 *)_this)->errWrapper.closing, ((P1 *)_this)->errWrapper.size, ((P1 *)_this)->errWrapper.num_msgs, ((int)((P1 *)_this)->errWrapper.closed), ((P1 *)_this)->waitGroup.update, ((P1 *)_this)->waitGroup.wait, ((P1 *)_this)->waitGroup.Counter, ((P1 *)_this)->child_AnonymousDeleteChart98981)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 103: // STATE 88 - chartserver++DeleteChart37.pml:143 - [(1)] (92:0:1 - 1)
		IfNotBlocked
		reached[1][88] = 1;
		if (!(1))
			continue;
		/* merge: i = (i+1)(0, 89, 92) */
		reached[1][89] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->i;
		((P1 *)_this)->i = (((P1 *)_this)->i+1);
#ifdef VAR_RANGES
		logval("DeleteChart37:i", ((P1 *)_this)->i);
#endif
		;
		/* merge: .(goto)(0, 93, 92) */
		reached[1][93] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 104: // STATE 96 - chartserver++DeleteChart37.pml:146 - [waitGroup.wait?0] (0:0:0 - 1)
		reached[1][96] = 1;
		if (q_zero(((P1 *)_this)->waitGroup.wait))
		{	if (boq != ((P1 *)_this)->waitGroup.wait) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P1 *)_this)->waitGroup.wait) == 0) continue;

		XX=1;
		if (0 != qrecv(((P1 *)_this)->waitGroup.wait, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(((P1 *)_this)->waitGroup.wait-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(((P1 *)_this)->waitGroup.wait, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)_this)->waitGroup.wait);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)_this)->waitGroup.wait))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 105: // STATE 97 - chartserver++DeleteChart37.pml:147 - [errChan.closing!1] (0:0:0 - 1)
		IfNotBlocked
		reached[1][97] = 1;
		if (q_full(((P1 *)_this)->errChan.closing))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->errChan.closing);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->errChan.closing, 0, 1, 0, 1);
		if (q_zero(((P1 *)_this)->errChan.closing)) { boq = ((P1 *)_this)->errChan.closing; };
		_m = 2; goto P999; /* 0 */
	case 106: // STATE 98 - chartserver++DeleteChart37.pml:151 - [errWrapper.deq?state,num_msgs] (0:0:4 - 1)
		reached[1][98] = 1;
		if (q_zero(((P1 *)_this)->errWrapper.deq))
		{	if (boq != ((P1 *)_this)->errWrapper.deq) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P1 *)_this)->errWrapper.deq) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->state);
		(trpt+1)->bup.ovals[1] = ((P1 *)_this)->num_msgs;
		;
		((P1 *)_this)->state = qrecv(((P1 *)_this)->errWrapper.deq, XX-1, 0, 0);
#ifdef VAR_RANGES
		logval("DeleteChart37:state", ((int)((P1 *)_this)->state));
#endif
		;
		((P1 *)_this)->num_msgs = qrecv(((P1 *)_this)->errWrapper.deq, XX-1, 1, 1);
#ifdef VAR_RANGES
		logval("DeleteChart37:num_msgs", ((P1 *)_this)->num_msgs);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)_this)->errWrapper.deq);
		sprintf(simtmp, "%d", ((int)((P1 *)_this)->state)); strcat(simvals, simtmp);		strcat(simvals, ",");
		sprintf(simtmp, "%d", ((P1 *)_this)->num_msgs); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)_this)->errWrapper.deq))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: state */  (trpt+1)->bup.ovals[2] = ((P1 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->state = 0;
		if (TstOnly) return 1; /* TT */
		/* dead 2: num_msgs */  (trpt+1)->bup.ovals[3] = ((P1 *)_this)->num_msgs;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->num_msgs = 0;
		_m = 4; goto P999; /* 0 */
	case 107: // STATE 99 - chartserver++DeleteChart37.pml:152 - [errWrapper.sync?state] (0:0:2 - 1)
		reached[1][99] = 1;
		if (q_zero(((P1 *)_this)->errWrapper.sync))
		{	if (boq != ((P1 *)_this)->errWrapper.sync) continue;
		} else
		{	if (boq != -1) continue;
		}
		if (q_len(((P1 *)_this)->errWrapper.sync) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->state);
		;
		((P1 *)_this)->state = qrecv(((P1 *)_this)->errWrapper.sync, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("DeleteChart37:state", ((int)((P1 *)_this)->state));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)_this)->errWrapper.sync);
		sprintf(simtmp, "%d", ((int)((P1 *)_this)->state)); strcat(simvals, simtmp);		}
#endif
		if (q_zero(((P1 *)_this)->errWrapper.sync))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: state */  (trpt+1)->bup.ovals[1] = ((P1 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->state = 0;
		_m = 4; goto P999; /* 0 */
	case 108: // STATE 100 - chartserver++DeleteChart37.pml:153 - [errWrapper.rcving!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][100] = 1;
		if (q_full(((P1 *)_this)->errWrapper.rcving))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->errWrapper.rcving);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->errWrapper.rcving, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->errWrapper.rcving)) { boq = ((P1 *)_this)->errWrapper.rcving; };
		_m = 2; goto P999; /* 0 */
	case 109: // STATE 105 - chartserver++DeleteChart37.pml:157 - [child!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][105] = 1;
		if (q_full(((P1 *)_this)->child))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->child);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->child, 0, 0, 0, 1);
		if (q_zero(((P1 *)_this)->child)) { boq = ((P1 *)_this)->child; };
		_m = 2; goto P999; /* 0 */
	case 110: // STATE 106 - chartserver++DeleteChart37.pml:158 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][106] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 111: // STATE 1 - chartserver++DeleteChart37.pml:25 - [(run DeleteChart37(child_DeleteChart370))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!(addproc(II, 1, 1, ((P0 *)_this)->child_DeleteChart370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 112: // STATE 3 - chartserver++DeleteChart37.pml:27 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

