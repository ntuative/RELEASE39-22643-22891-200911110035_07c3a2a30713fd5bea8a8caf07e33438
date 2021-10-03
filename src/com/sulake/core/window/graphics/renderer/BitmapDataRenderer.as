package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.utils.IBitmapDataContainer;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class BitmapDataRenderer extends SkinRenderer
   {
       
      
      private var var_821:Matrix;
      
      private var _colorTransform:ColorTransform;
      
      public function BitmapDataRenderer(param1:Array)
      {
         super(param1);
         var_821 = new Matrix();
         _colorTransform = new ColorTransform();
      }
      
      override public function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc6_:BitmapData = IBitmapDataContainer(param1).bitmapData;
         var _loc7_:BitmapData = BitmapData(param2);
         if(param2 != null && _loc6_ != null)
         {
            var_821.a = param1.width / _loc6_.width;
            var_821.d = param1.height / _loc6_.height;
            _loc7_.lock();
            _loc7_.draw(_loc6_,var_821,_colorTransform,null,null,false);
            _loc7_.unlock();
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}
