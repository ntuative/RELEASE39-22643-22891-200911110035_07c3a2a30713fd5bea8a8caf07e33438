package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.inventory.common.IThumbListDrawableItem;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class Badge implements IThumbListDrawableItem
   {
       
      
      private const const_1486:int = 8947848;
      
      private const const_1487:int = 13421772;
      
      private var _isSelected:Boolean;
      
      private var _window:IWindowContainer;
      
      private var var_1190:Boolean;
      
      private var _image:BitmapData;
      
      private var _type:String;
      
      public function Badge(param1:String, param2:IWindowContainer)
      {
         _image = new BitmapData(1,1,false,4278255360);
         super();
         _type = param1;
         _window = param2;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         _image = param1;
         if(_image == null)
         {
            return;
         }
         if(_window == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("bitmap") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         param1 = _image;
         var _loc3_:BitmapData = !!_loc2_.bitmap ? _loc2_.bitmap : new BitmapData(_loc2_.width,_loc2_.height);
         _loc3_.fillRect(_loc3_.rect,0);
         _loc3_.copyPixels(param1,param1.rect,new Point(_loc3_.width / 2 - param1.width / 2,_loc3_.height / 2 - param1.height / 2));
         _loc2_.bitmap = _loc3_;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(param1)
         {
            _window.color = const_1486;
         }
         else
         {
            _window.color = const_1487;
         }
      }
      
      public function get isInUse() : Boolean
      {
         return var_1190;
      }
      
      public function get iconImage() : BitmapData
      {
         return _image;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         var_1190 = param1;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
