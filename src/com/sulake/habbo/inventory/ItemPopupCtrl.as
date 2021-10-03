package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ItemPopupCtrl
   {
      
      private static const const_1051:int = 100;
      
      private static const const_1049:int = 200;
      
      private static const const_1052:int = 180;
      
      public static const const_890:int = 1;
      
      public static const const_387:int = 2;
      
      private static const const_1050:int = 250;
      
      private static const const_731:int = 5;
       
      
      private var var_531:BitmapData;
      
      private var var_286:Timer;
      
      private var var_23:IWindowContainer;
      
      private var var_646:BitmapData;
      
      private var var_285:Timer;
      
      private var var_77:IWindowContainer;
      
      private var var_1426:int = 2;
      
      private var _assets:IAssetLibrary;
      
      public function ItemPopupCtrl(param1:IWindowContainer, param2:IAssetLibrary)
      {
         var_285 = new Timer(const_1050,1);
         var_286 = new Timer(const_1051,1);
         super();
         if(param1 == null)
         {
            return;
         }
         if(param2 == null)
         {
            return;
         }
         var_77 = param1;
         var_77.visible = false;
         _assets = param2;
         var_285.addEventListener(TimerEvent.TIMER,onDisplayTimer);
         var_286.addEventListener(TimerEvent.TIMER,onHideTimer);
         var _loc3_:BitmapDataAsset = _assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset;
         if(_loc3_ != null && _loc3_.content != null)
         {
            var_646 = _loc3_.content as BitmapData;
         }
         _loc3_ = _assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset;
         if(_loc3_ != null && _loc3_.content != null)
         {
            var_531 = _loc3_.content as BitmapData;
         }
      }
      
      public function hide() : void
      {
         var_77.visible = false;
         var_286.reset();
         var_285.reset();
         if(var_23 != null)
         {
            var_23.removeChild(var_77);
         }
      }
      
      public function hideDelayed() : void
      {
         var_286.reset();
         var_285.reset();
         var_286.start();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         hide();
      }
      
      public function dispose() : void
      {
         if(var_285 != null)
         {
            var_285.removeEventListener(TimerEvent.TIMER,onDisplayTimer);
            var_285.stop();
            var_285 = null;
         }
         if(var_286 != null)
         {
            var_286.removeEventListener(TimerEvent.TIMER,onHideTimer);
            var_286.stop();
            var_286 = null;
         }
         _assets = null;
         var_77 = null;
         var_23 = null;
         var_531 = null;
         var_646 = null;
      }
      
      public function showDelayed() : void
      {
         var_286.reset();
         var_285.reset();
         var_285.start();
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         show();
      }
      
      public function updateContent(param1:IWindowContainer, param2:String, param3:BitmapData, param4:int = 2) : void
      {
         var _loc7_:* = null;
         if(var_77 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param3 == null)
         {
            param3 = new BitmapData(1,1,true,16777215);
         }
         if(var_23 != null)
         {
            var_23.removeChild(var_77);
         }
         var_23 = param1;
         var_1426 = param4;
         var _loc5_:ITextWindow = ITextWindow(var_77.findChildByName("item_name_text"));
         if(_loc5_)
         {
            _loc5_.text = param2;
         }
         var _loc6_:IBitmapWrapperWindow = var_77.findChildByName("item_image") as IBitmapWrapperWindow;
         if(_loc6_)
         {
            _loc7_ = new BitmapData(Math.min(const_1052,param3.width),Math.min(const_1049,param3.height),true,16777215);
            _loc7_.copyPixels(param3,new Rectangle(0,0,_loc7_.width,_loc7_.height),new Point(0,0),null,null,true);
            _loc6_.bitmap = _loc7_;
            _loc6_.width = _loc6_.bitmap.width;
            _loc6_.height = _loc6_.bitmap.height;
            _loc6_.x = (0 - _loc6_.width) / 2;
            var_77.height = _loc6_.rectangle.bottom + 10;
         }
      }
      
      private function refreshArrow(param1:int = 2) : void
      {
         if(var_77 == null || false)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(var_77.findChildByName("arrow_pointer"));
         if(!_loc2_)
         {
            return;
         }
         switch(param1)
         {
            case const_890:
               _loc2_.bitmap = var_646.clone();
               _loc2_.width = var_646.width;
               _loc2_.height = var_646.height;
               _loc2_.y = (0 - 0) / 2;
               _loc2_.x = -1;
               break;
            case const_387:
               _loc2_.bitmap = var_531.clone();
               _loc2_.width = var_531.width;
               _loc2_.height = var_531.height;
               _loc2_.y = (0 - 0) / 2;
               _loc2_.x = 1;
         }
         _loc2_.invalidate();
      }
      
      public function show() : void
      {
         var_286.reset();
         var_285.reset();
         if(var_23 == null)
         {
            return;
         }
         var_77.visible = true;
         var_23.addChild(var_77);
         refreshArrow(var_1426);
         switch(var_1426)
         {
            case const_890:
               var_77.x = 0 - const_731;
               break;
            case const_387:
               var_77.x = var_23.width + const_731;
         }
         var_77.y = (0 - 0) / 2;
      }
   }
}
