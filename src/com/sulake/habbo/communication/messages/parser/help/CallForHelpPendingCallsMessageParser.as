package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class CallForHelpPendingCallsMessageParser implements IMessageParser
   {
       
      
      private var var_540:Array;
      
      public function CallForHelpPendingCallsMessageParser()
      {
         var_540 = new Array();
         super();
      }
      
      public function get callCount() : int
      {
         return var_540.length;
      }
      
      public function flush() : Boolean
      {
         var_540 = new Array();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var_540 = new Array();
         var _loc2_:int = param1.readInteger();
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new Object();
            _loc4_.callId = param1.readString();
            _loc4_.timeStamp = param1.readString();
            _loc4_.message = param1.readString();
            var_540.push(_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function get callArray() : Array
      {
         return var_540;
      }
   }
}
