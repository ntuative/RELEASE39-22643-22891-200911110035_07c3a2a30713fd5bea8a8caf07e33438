package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class ConfirmDialog extends AlertDialog implements IConfirmDialog
   {
       
      
      public function ConfirmDialog(param1:IHabboWindowManager, param2:XML, param3:String, param4:String, param5:uint, param6:Function)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      override protected function dialogEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            switch(param2.name)
            {
               case "_alert_button_ok":
                  if(var_176 != null)
                  {
                     var_176(this,new WindowEvent(WindowEvent.const_199,null,null));
                  }
                  break;
               case "_alert_button_cancel":
               case "header_button_close":
                  if(var_176 != null)
                  {
                     var_176(this,new WindowEvent(WindowEvent.const_478,null,null));
                  }
            }
         }
      }
   }
}
