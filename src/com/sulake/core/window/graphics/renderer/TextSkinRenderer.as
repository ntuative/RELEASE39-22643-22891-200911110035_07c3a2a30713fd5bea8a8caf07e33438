package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.utils.ITextFieldContainer;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class TextSkinRenderer extends SkinRenderer
   {
       
      
      protected var var_821:Matrix;
      
      public function TextSkinRenderer(param1:Array)
      {
         super(param1);
         var_821 = new Matrix();
      }
      
      override public function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(param2 != null)
         {
            _loc6_ = ITextFieldContainer(param1);
            _loc7_ = ITextWindow(param1).autoSize;
            _loc8_ = _loc6_.textField;
            var_821.tx = _loc6_.margins.left;
            var_821.ty = _loc6_.margins.top;
            if(_loc7_ == TextFieldAutoSize.RIGHT)
            {
               var_821.tx = Math.floor(param1.width - _loc8_.width);
            }
            else if(_loc7_ == TextFieldAutoSize.CENTER)
            {
               var_821.tx = Math.floor(param1.width / 2 - _loc8_.width / 2);
            }
            BitmapData(param2).draw(_loc8_,var_821,null,null,null,false);
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}
