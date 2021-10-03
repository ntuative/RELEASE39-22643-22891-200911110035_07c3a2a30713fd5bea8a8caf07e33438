package com.sulake.habbo.widget.furniture.placeholder
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.geom.Rectangle;
   
   public class PlaceholderView
   {
       
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _window:IWindowContainer;
      
      private var _windowManager:IHabboWindowManager;
      
      public function PlaceholderView(param1:IAssetLibrary, param2:IHabboWindowManager)
      {
         super();
         _assetLibrary = param1;
         _windowManager = param2;
      }
      
      public function toggleWindow() : void
      {
         if(_window != null && false)
         {
            hideWindow();
         }
         else
         {
            showWindow();
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         hideWindow();
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = _assetLibrary.getAssetByName("placeholder") as XmlAsset;
         if(_loc1_ == null || _loc1_.content == null)
         {
            return;
         }
         _window = _windowManager.createWindow("habbohelp_window","",HabboWindowType.const_53,HabboWindowStyle.const_38,0 | 0,new Rectangle(-300,300,10,10),null) as IWindowContainer;
         _window.buildFromXML(_loc1_.content as XML);
         _window.tags.push("habbo_help_window");
         _window.background = true;
         _window.color = 33554431;
         var _loc2_:IWindow = _window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.procedure = onWindowClose;
         }
      }
      
      public function showWindow() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         if(_window == null)
         {
            return;
         }
         _window.visible = true;
         _window.x = 200;
      }
      
      public function hideWindow() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
   }
}
