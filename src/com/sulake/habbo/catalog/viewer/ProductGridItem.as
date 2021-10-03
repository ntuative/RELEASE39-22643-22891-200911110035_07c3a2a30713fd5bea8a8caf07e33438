package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ProductGridItem implements IGridItem
   {
       
      
      protected var _view:IWindowContainer;
      
      private var var_408:IItemGrid;
      
      private var _icon:IBitmapWrapperWindow;
      
      public function ProductGridItem()
      {
         super();
      }
      
      protected function setIconImage(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_icon == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc2_:int = (0 - param1.width) / 2;
         var _loc3_:int = (0 - param1.height) / 2;
         if(true)
         {
            _icon.bitmap = new BitmapData(_icon.width,_icon.height,true,16777215);
         }
         _icon.bitmap.fillRect(_icon.bitmap.rect,16777215);
         _icon.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_),null,null,false);
         _icon.invalidate();
      }
      
      public function deActivate() : void
      {
         _view.style = 3;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(var_408 != null)
         {
            var_408.select(this);
         }
      }
      
      public function set grid(param1:IItemGrid) : void
      {
         var_408 = param1;
      }
      
      public function set view(param1:IWindowContainer) : void
      {
         _view = param1;
         _view.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onClick);
         _icon = _view.findChildByName("image") as IBitmapWrapperWindow;
         _view.findChildByName("multiContainer").visible = false;
      }
      
      public function get view() : IWindowContainer
      {
         return _view;
      }
      
      public function activate() : void
      {
         _view.style = HabboWindowStyle.const_37;
      }
      
      public function dispose() : void
      {
         var_408 = null;
         _icon = null;
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
      }
   }
}
