#include "UI.Protocol"
#include "UI.Component"


//This should return the unique name of this component type
string _getType(){
    return "chk";
}

integer gValue = FALSE

//This should return value of this component as an string use "" if doesn't report a value
string _getValue(){
    return (string)gValue;
}
_setValue(string newVal){
    float oldVal = gValue;
    gValue=(integer)newVal;
    updateTexture();
    _onEvent(UI_EVENT_TYPE_CHANGED, (string)oldVal, (string)gValue, "");
}
setValue(integer newVal){
    _setValue((string)newVal);
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
integer gFaceTick=2;
integer gFaceCross=1;
integer gFaceBg=3;
integer gFaceTouch=0;
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
            setValue(max(gValue-gIncrement,0));
            updateTexture();
        }else if(touchFace == gFaceScrollDown){
            setValue(min(gValue+gIncrement,1));
            updateTexture();
            
        }else if(touchFace == gFaceNod){
            if (!(touchST == TOUCH_INVALID_TEXCOORD)){
                setValue(1-touchST.y);
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
            if(touchFace == gFaceNod){
                if (!(touchST == TOUCH_INVALID_TEXCOORD)){
                    setValue(1-touchST.y);
                    updateTexture();
                }
            } 
        //}
        if(gTouchCounter>gTouchCounter>1000){
            gTouchCounter=0;
        }
    }
}