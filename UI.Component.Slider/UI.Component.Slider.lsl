#include "UI.Protocol"
#include "UI.Component"


//This should return the unique name of this component type
string _getType(){
    return "sldr";
}
float gExtends = 0.8;
float gIncrement = 0.1;
float gValue = 0.0;
//This should return value of this component as an string use "" if doesn't report a value
string _getValue(){
    return (string)gValue;
}
_setValue(string newVal, integer raiseEvents){
    float oldVal = gValue;
    gValue=min(max((float)newVal,0),1);
    updateTexture();
    if(oldVal!=gValue){
        if(raiseEvents){ 
            _onEvent(UI_EVENT_TYPE_CHANGED, (string)oldVal, (string)gValue, ""); 
        }
        _onEvent(UI_EVENT_TYPE_INTERNALCHANGE, (string)oldVal, (string)gValue, "");
    }
}
setValue(float newVal){
    _setValue((string)newVal, TRUE);
}
float max(float x,float y)
{
    return ( ( llAbs( x >= y ) ) * x ) + ( ( llAbs( x<y ) ) * y );
}
 
float min(float x, float y)
{
    return ( ( llAbs( x >= y ) ) * y ) + ( ( llAbs( x<y ) ) * x );
}
float textureOffset(){
    return  max(min((gValue),0.47),0);
}

updateTexture(){
    list pars=llGetPrimitiveParams([PRIM_TEXTURE, gFaceTouch]);
    key origText = llList2Key(pars,0);
    vector origRep = llList2Vector(pars,1);
    vector origOff = llList2Vector(pars,2);
    //llOwnerSay((string)gValue+" <"+(string)textureOffset()+", " + (string)origOff.y + ", 0>");
    llSetLinkPrimitiveParamsFast(LINK_THIS, [
            PRIM_TEXTURE, gFaceTouch, origText,
            origRep, (vector)("<"+(string)textureOffset()+", " + (string)origOff.y + ", 0>"), 0
    ]); 
}
integer gFaceTouch=0;
integer gTouchCounter = 0;
default
{
    state_entry()
    {
        _onEvent(UI_EVENT_TYPE_PAINT_START, "", "", "");
        gValue=0.0;
        updateTexture();
        _onEvent(UI_EVENT_TYPE_PAINT_END, "", "", "");
    }
    touch_start(integer total_number)
    {
        integer touchFace = llDetectedTouchFace(0);
        vector  touchST   = llDetectedTouchST(0);
        if(touchFace == gFaceTouch){
            if (!(touchST == TOUCH_INVALID_TEXCOORD)){
                setValue(0.5-touchST.x);
                updateTexture();
            }
        }
    }
    touch(integer numdetected)
    {
        gTouchCounter++;
        //if(gTouchCounter%7){
            integer touchFace = llDetectedTouchFace(0);
            vector  touchST   = llDetectedTouchST(0);
            if(touchFace == gFaceTouch){
                if (!(touchST == TOUCH_INVALID_TEXCOORD)){
                    setValue(0.5-touchST.x);
                    updateTexture();
                }
            } 
        //}
        if(gTouchCounter>1000){
            gTouchCounter=0;
        }
    }
}