package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.graphics.WindowRedrawFlag;
   import com.sulake.core.window.utils.IBitmapDataContainer;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class BitmapWrapperController extends WindowController implements IBitmapWrapperWindow, IBitmapDataContainer
   {
       
      
      protected var var_397:Boolean = true;
      
      protected var _bitmapData:BitmapData;
      
      protected var var_980:String;
      
      public function BitmapWrapperController(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:IWindow, param9:Function = null, param10:Array = null, param11:Array = null, param12:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function get disposesBitmap() : Boolean
      {
         return var_397;
      }
      
      public function set disposesBitmap(param1:Boolean) : void
      {
         var_397 = param1;
      }
      
      override public function clone() : IWindow
      {
         var _loc1_:BitmapWrapperController = super.clone() as BitmapWrapperController;
         _loc1_._bitmapData = _bitmapData;
         _loc1_.var_397 = var_397;
         _loc1_.var_980 = var_980;
         return _loc1_;
      }
      
      public function set bitmap(param1:BitmapData) : void
      {
         if(var_397 && _bitmapData && param1 != _bitmapData)
         {
            _bitmapData.dispose();
         }
         _bitmapData = param1;
         _context.invalidate(this,var_22,WindowRedrawFlag.const_70);
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc2_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_] as PropertyStruct;
            switch(_loc3_.key)
            {
               case "handle_bitmap_disposing":
                  var_397 = _loc3_.value as Boolean;
                  break;
               case "bitmap_asset_name":
                  var_980 = _loc3_.value as String;
                  break;
            }
            _loc4_++;
         }
         super.properties = param1;
      }
      
      override public function dispose() : void
      {
         if(_bitmapData)
         {
            if(var_397)
            {
               _bitmapData.dispose();
            }
            _bitmapData = null;
         }
         super.dispose();
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmapData;
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         bitmap = param1;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(new PropertyStruct("handle_bitmap_disposing",var_397,PropertyStruct.const_58,var_397 != true));
         _loc1_.push(new PropertyStruct("bitmap_asset_name",var_980,PropertyStruct.const_233,var_980 != null));
         return _loc1_;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
   }
}
