package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   import flash.events.Event;
   
   public class WindowMessage extends WindowEvent
   {
       
      
      public var message:String;
      
      public function WindowMessage(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false, param5:Boolean = false)
      {
         this.message = param1;
         super(WindowEvent.WINDOW_EVENT_MESSAGE,param2,param3,param4,param5);
      }
      
      override public function toString() : String
      {
         return formatToString("WindowMessage","type","bubbles","cancelable","eventPhase","message","window","related");
      }
      
      override public function clone() : Event
      {
         return new WindowMessage(message,window,related,bubbles,cancelable);
      }
   }
}
