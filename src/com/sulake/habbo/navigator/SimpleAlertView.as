package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class SimpleAlertView extends AlertView
   {
       
      
      private var var_197:String;
      
      public function SimpleAlertView(param1:HabboNavigator, param2:String, param3:String)
      {
         super(param1,"nav_simple_alert",param2);
         var_197 = param3;
      }
      
      private function onOk(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      override function setupContent(param1:IWindowContainer) : void
      {
         ITextWindow(param1.findChildByName("body_text")).text = var_197;
         param1.findChildByName("ok").procedure = onOk;
      }
   }
}
