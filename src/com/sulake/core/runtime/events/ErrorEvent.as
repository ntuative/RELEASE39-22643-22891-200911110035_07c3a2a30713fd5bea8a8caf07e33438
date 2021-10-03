package com.sulake.core.runtime.events
{
   import flash.events.Event;
   
   public class ErrorEvent extends Event
   {
       
      
      protected var _message:String;
      
      protected var var_2044:Boolean;
      
      public function ErrorEvent(param1:String, param2:String, param3:Boolean)
      {
         _message = param2;
         var_2044 = param3;
         super(param1);
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get critical() : Boolean
      {
         return var_2044;
      }
   }
}
