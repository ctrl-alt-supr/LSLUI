//This returns the unique identifier of this component (usually based on its description)
string _getIdentifier(){
    return _getType()+"^"+llGetObjectDesc();
}
//This sends all linked messages to notify about events. Should be called by the component whenever it wants
//to report any event change
_onEvent(string eventTypeId, string param1, string param2, string param3){
    string LosPars = llDumpList2String([param1,param2,param3],"|");
    string eventInfo = eventTypeId+"~"+LosPars;

    llMessageLinked(LINK_SET, UI_EVENT_NUMBER, eventInfo, (key)_getIdentifier());
}