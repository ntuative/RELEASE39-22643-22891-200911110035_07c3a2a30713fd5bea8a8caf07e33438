package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetAvatarEditorMessage;
   
   public class MeMenuClothesView implements IMeMenuView
   {
       
      
      private var _widget:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      public function MeMenuClothesView()
      {
         super();
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("memenu_clothes") as XmlAsset;
         _window = (_widget.windowManager as ICoreWindowManager).buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.name = param1;
         _widget.mainContainer.addChild(_window);
         _widget.messageListener.processWidgetMessage(new RoomWidgetAvatarEditorMessage(RoomWidgetAvatarEditorMessage.const_651,_window));
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         _widget = param1;
         createWindow(param2);
      }
      
      private function onResized(param1:WindowEvent) : void
      {
         _window.x = 0;
         _window.y = 0;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function dispose() : void
      {
         _widget = null;
         if(false)
         {
            _window.removeChildAt(0);
         }
         _window.dispose();
         _window = null;
      }
   }
}
