
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example403803433/modules/cryptoexchanges/cryptolive/widget.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int i;
	chan child_widget_priceWidgetRefresh0 = [0] of {int};
	Wgdef wg;
	chan child_widget_toplistWidgetRefresh1 = [0] of {int};
	bool state = false;
	run wgMonitor(wg);
	wg.Add!2;
	run widget_priceWidgetRefresh(wg,child_widget_priceWidgetRefresh0);
	child_widget_priceWidgetRefresh0?0;
	run widget_toplistWidgetRefresh(wg,child_widget_toplistWidgetRefresh1);
	child_widget_toplistWidgetRefresh1?0;
	wg.Wait?0
stop_process:}

proctype widget_priceWidgetRefresh(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:	child!0
}
proctype widget_toplistWidgetRefresh(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	wg.Add!-1;
stop_process:	child!0
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
	od
}
