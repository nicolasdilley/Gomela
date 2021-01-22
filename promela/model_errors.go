package promela

const (
	UNPARSABLE_FUNCTION_NAME = "Could not parse the name of the function at pos: "
	UNPARSABLE_ARG           = "Could not parse an arguments at pos: "
	FUNC_DECLARED_AS_VAR     = "Function declared as a variable at pos: "
	WAITGROUP_IN_FOR         = "Waitgroup created in a for loop at pos: "
	CHAN_IN_FOR              = "Channel created in a for loop at pos: "
	UNKNOWN_ARG              = "Found a function call that contains an unknown chan or wg at pos: "
	UNKNOWN_NOTIFY           = "Can not find send of signal.Notify at pos: "
	UNKNOWN_RCV              = "A receive was found on a channel that could not be parsed at pos: "
	UNKNOWN_SEND             = "A send on a channel was found that could not be parsed at pos: "
	UNKNOWN_RANGE            = "A range on a channel was found but could not parse channel at pos: "
	UNKNOWN_DECL             = "Cannot find decl of concurrent function at pos: "
	DEFER_IN_FOR             = "Defer stmt in for at pos: "
	DEFER_IN_IF              = "Defer stmt in if at pos: "
	DEFER_IN_RANGE           = "Defer stmt in range at pos: "
	DEFER_IN_SELECT          = "Defer stmt in select statement at pos: "
	DEFER_IN_SWITCH          = "Defer stmt in switch statement at pos: "
	UNKNOWN_GO_FUNC          = "Concurrent function declaration of go statement not found at pos: "
	RETURN_CHAN              = "Returning a channel at pos: "
	RETURN_WG                = "Returning a waitgroup at pos: "
	SELECT_WITH_NO_BRANCH    = "Found a select with no branches at pos: "
)
