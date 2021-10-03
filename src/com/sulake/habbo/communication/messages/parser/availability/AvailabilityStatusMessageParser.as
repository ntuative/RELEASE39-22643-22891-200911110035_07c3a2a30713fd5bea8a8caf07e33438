package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class AvailabilityStatusMessageParser implements IMessageParser
   {
       
      
      private var var_866:Boolean;
      
      private var var_1061:Boolean;
      
      public function AvailabilityStatusMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_866 = param1.readInteger() > 0;
         var_1061 = param1.readInteger() > 0;
         return true;
      }
      
      public function get isOpen() : Boolean
      {
         return var_866;
      }
      
      public function get onShutDown() : Boolean
      {
         return var_1061;
      }
      
      public function flush() : Boolean
      {
         var_866 = false;
         var_1061 = false;
         return true;
      }
   }
}
