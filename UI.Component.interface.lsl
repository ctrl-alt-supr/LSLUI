//This script shows the definition of the functions that are expected to be
//declared inside UI components. All of this functions begin with a "_" in order
//to make easier to difference them from your other (not UI related) functions.

#include "UI.Protocol"
//This should return the unique name of this component type
string _getType(){
    //Returns an string that should identify this kind of component from any other kind
}
//This should return value of this component as an string use "" if doesn't report a value
string _getValue(){
    //Remember to cast the value to string before returning it if it isn't one already!
}
//Should be used whenever you want to change the value reported by a component.
_setValue(string newVal){
    //Remember to call _onEvent with UI_EVENT_TYPE_CHANGED if you want to be able to be
    //notified whenever a change happens.
}