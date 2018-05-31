#include "UI.Protocol"
#include "UI.Component"


//This should return the unique name of this component type
string _getType(){
    return "rad";
}


string getGroup(){
    return getGroupByDesc(llGetObjectDesc());
}
string getGroupByDesc(string desc){
    list lstDsc=llParseString2List(desc, ["_"], [])
    if(llGetListLength(lstDsc)>1){
        return llList2String(lstDsc, 1);
    }else{
        return "default";
    }
}

integer gValue = FALSE;

//This should return value of this component as an string use "" if doesn't report a value
string _getValue(){
    return (string)gValue;
}
_setValue(string newVal, integer raiseEvents){
    integer oldVal = gValue;
    gValue=(integer)newVal;
    updateTexture();
    if(oldVal!=gValue){
        if(raiseEvents){ 
            _onEvent(UI_EVENT_TYPE_CHANGED, (string)oldVal, (string)gValue, ""); 
        }
        _onEvent(UI_EVENT_TYPE_INTERNALCHANGE, (string)oldVal, (string)gValue, "");
    }
}
setValue(integer newVal){
    _setValue((string)newVal, TRUE);
}

updateTexture(){
    llSetLinkAlpha( LINK_THIS, 0, gFaceUpper);
    if(gValue){
        llSetLinkAlpha( LINK_THIS, 1, gFaceLower);
    }else{
        llSetLinkAlpha( LINK_THIS, 0, gFaceLower);
    }
}
integer startswith(string haystack, string needle)
{
    return llDeleteSubString(haystack, llStringLength(needle), 0x7FFFFFF0) == needle;
}
integer endswith(string haystack, string needle)
{
    return llDeleteSubString(haystack, 0x8000000F, ~llStringLength(needle)) == needle;
}
integer gFaceLower=2;
integer gFaceUpper=1;
integer gFaceBg=3;
integer gFaceTouch=0;
default
{
    state_entry()
    {
        _onEvent(UI_EVENT_TYPE_PAINT_START, "", "", "");
        gValue=FALSE;
        updateTexture();
        _onEvent(UI_EVENT_TYPE_PAINT_END, "", "", "");
    }
    touch_start(integer total_number)
    {
        integer touchFace = llDetectedTouchFace(0);
        if(touchFace == gFaceTouch){
            if(gValue==TRUE){
                setValue(FALSE);
            }else{
                setValue(TRUE);
            }
            updateTexture();
        }
    }
    link_message(integer source, integer num, string str, key id){
        //This component needs to listen to events fired by other components to make sure only
        //one radio of this group is selected at a given time.
        if(gValue){
            if(num==UI_EVENT_NUMBER){
                if(startswith((string)id, _getType()) && getGroupByDesc(id)==getGroup()){
                    list evTypeAndPars = llParseString2List(str, ["^"],[]);
                    if(llGetListLength(evTypeAndPars)>1){
                        //llList2String
                    }
                }
            }
        }
    }
}