package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class MeMenuRoomsView implements IMeMenuView
   {
       
      
      private var _widget:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      public function MeMenuRoomsView()
      {
         super();
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("memenu_rooms") as XmlAsset;
         Logger.log("Me Menu Room View: " + _loc2_);
         _window = (_widget.windowManager as ICoreWindowManager).buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.name = param1;
         var _loc4_:int = 0;
         while(_loc4_ < _window.numChildren)
         {
            _loc3_ = _window.getChildAt(_loc4_);
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
            _loc4_++;
         }
         _widget.mainContainer.addChild(_window);
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
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:IWindow = param1.target as IWindow;
         var _loc4_:String = _loc3_.name;
         switch(_loc4_)
         {
            case "back_btn":
               _widget.changeView(MeMenuWidget.const_153);
               break;
            default:
               Logger.log("Me Menu xx View: unknown button: " + _loc4_);
         }
      }
      
      public function dispose() : void
      {
         _widget = null;
         _window.dispose();
         _window = null;
      }
   }
}
