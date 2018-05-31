//Events from the UI come with this number
#define UI_EVENT_NUMBER 81

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
//Called whenever the reported value on a component changes. Parameters are the component's identifier, the old value and the new value. This event should be triggered
//when the value changes in a component and the change should ALWAYS be listened by other components even if ui_call_set is tells to not throw events
#define UI_EVENT_TYPE_INTERNALCHANGE "ui_internalchanged"

//Calls to the UI go with this number
#define UI_CALL_NUMBER 82
//Sent to the UI whenever it wants to receive a discovery callback. Optional parameter is the component's identifier.
#define UI_CALL_TYPE_ECHO "ui_call_echo"
//Used to stabilish a new value for a component. The first parameter is the component's identifier, the second one is the value to set and an optional third parameter determines wether or not an event should be fired for this change
#define UI_CALL_TYPE_SET "ui_call_set"
//Used to get the value reported by a component. The parameter is the component name
#define UI_CALL_TYPE_GET "ui_call_get"
//Sets wether this component should be shown or hidden (visually, the component will still react to touches and fire events accordingly)
#define UI_CALL_TYPE_VISIBLE "ui_call_visible"