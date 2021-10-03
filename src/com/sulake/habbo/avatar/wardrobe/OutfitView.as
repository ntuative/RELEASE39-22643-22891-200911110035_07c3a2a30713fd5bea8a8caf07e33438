package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class OutfitView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_419:IBitmapWrapperWindow;
      
      private var _window:IWindowContainer;
      
      public function OutfitView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:Boolean)
      {
         super();
         _windowManager = param1;
         _assetLibrary = param2;
         var _loc4_:XmlAsset = _assetLibrary.getAssetByName("Outfit") as XmlAsset;
         _window = IWindowContainer(_windowManager.buildFromXML(_loc4_.content as XML));
         if(_window != null)
         {
            var_419 = _window.findChildByName("bitmap") as IBitmapWrapperWindow;
         }
         if(!param3)
         {
            _window.findChildByName("button").disable();
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function windowEventProc(param1:Event, param2:IWindow = null) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            Logger.log("[OutfitView] Click! This should be over-ridden!");
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            _window.color = 13421772;
         }
         else if(param1.type == WindowMouseEvent.const_29)
         {
            _window.color = 6710886;
         }
      }
      
      public function udpate(param1:BitmapData) : void
      {
         var_419.bitmap = new BitmapData(var_419.width,var_419.height,true,16777215);
         var _loc2_:int = (0 - param1.width) / 2;
         var _loc3_:int = 0 - param1.height;
         var_419.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
      }
   }
}
