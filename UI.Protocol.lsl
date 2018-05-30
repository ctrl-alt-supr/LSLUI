//Events from the UI come with this number
#define UI_EVENT_NUMBER 81
//Calls to the UI go with this number
#define UI_CALL_NUMBER 82
//Sent from the UI as a response to discovery calls
#define UI_EVENT_TYPE_ECHO "ui_echo"
//Gets called when all UI components are ready to go
#define UI_EVENT_TYPE_INITIALIZED "ui_initialized"
//Gets called when some unexpected errors are caught during execution
#define UI_EVENT_TYPE_GENERICERROR "ui_error"
//Called whenever the reported value on a component changes. Parameters are the component's identifier, the old value and the new value.
#define UI_EVENT_TYPE_CHANGED "ui_changed"
//When a component starts to get painted
#define UI_EVENT_TYPE_PAINT_START "ui_paint_start"
//When a component finishes to get painted
#define UI_EVENT_TYPE_PAINT_END "ui_paint_end"

