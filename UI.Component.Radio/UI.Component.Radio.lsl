#include "UI.Protocol"
#include "UI.Component"


//This should return the unique name of this component type
string _getType(){
    return "rad";
}


string _getGroup(){
    list lstDsc=llParseString2List(llGetObjectDesc(), ["_"], [])
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
}