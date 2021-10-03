package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class LoginFailedHotelClosedMessageParser implements IMessageParser
   {
       
      
      private var _openHour:int;
      
      private var var_1050:int;
      
      public function LoginFailedHotelClosedMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _openHour = param1.readInteger();
         var_1050 = param1.readInteger();
         return true;
      }
      
      public function get openHour() : int
      {
         return _openHour;
      }
      
      public function flush() : Boolean
      {
         _openHour = 0;
         var_1050 = 0;
         return true;
      }
      
      public function get openMinute() : int
      {
         return var_1050;
      }
   }
}
