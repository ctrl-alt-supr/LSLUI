#include "UI.Protocol"

//Functions marked with an "_" at the begining are expected to be found in every component!!

//This function should be called by the component whenever it wants
//to report an event change
_onEvent(string eventTypeId, string param1, string param2, string param3){
    
}
//This should return the unique name of this component type
string _getType(){
    return "scrl";
}
//This should return the unique identifier of this component (usually based on its description)
string _getIdentifier(){
    return _getType()+"_"+llGetObjectDesc();
}
float gExtends = 0.8;
float gIncrement = 0.1;
float gValue = 0.0;
//This should return value of this component as an string use "" if doesn't report a value
string _getValue(){
    return (string)gValue;
}
_setValue(string newVal){
    float oldVal = gValue;
    gValue=min(max(newVal,0),1);
    updateTexture();
    _onEvent(UI_EVENT_TYPE_CHANGED, oldVal, gValue, "");
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
    return max(min(((0.9*gValue)/1)-0.4,0.4),-0.4);
}

updateTexture(){
    list pars=llGetPrimitiveParams([PRIM_TEXTURE, gFaceNod]);
    key origText = llList2Key(pars,0);
    vector origRep = llList2Vector(pars,1);
    vector origOff = llList2Vector(pars,2);
    llSetLinkPrimitiveParamsFast(LINK_THIS, [
            PRIM_TEXTURE, gFaceNod, origText,
            origRep, (vector)("<"+(string)origOff.x+", " + (string)textureOffset() + ", 0>"), 0
    ]); 
}
integer gFaceScrollUp=1;
integer gFaceScrollDown=3;
integer gFaceNod=0;
integer gTouchCounter = 0;
default
{
    state_entry()
    {
        _onEvent(UI_EVENT_TYPE_PAINT_START, "", "", "");
        gValue=0;
        updateTexture();
        _onEvent(UI_EVENT_TYPE_PAINT_END, "", "", "");
    }
    touch_start(integer total_number)
    {
        integer touchFace = llDetectedTouchFace(0);
        vector  touchST   = llDetectedTouchST(0);
        if (touchFace == gFaceScrollUp){
            _setValue(max(gValue-gIncrement,0));
            updateTexture();
        }else if(touchFace == gFaceScrollDown){
            _setValue(min(gValue+gIncrement,1));
            updateTexture();
            
        }else if(touchFace == gFaceNod){
            if (!(touchST == TOUCH_INVALID_TEXCOORD)){
                _setValue(1-touchST.y);
                updateTexture();
            }
        }
    }
    touch(integer numdetected)
    {
        gTouchCounter++;
        if(gTouchCounter%7){
            integer touchFace = llDetectedTouchFace(0);
            vector  touchST   = llDetectedTouchST(0);
            if(touchFace == gFaceNod){
                if (!(touchST == TOUCH_INVALID_TEXCOORD)){
                    _setValue(1-touchST.y);
                    updateTexture();
                }
            } 
        }
        if(gTouchCounter>gTouchCounter>1000){
            gTouchCounter=0;
        }
    }
}