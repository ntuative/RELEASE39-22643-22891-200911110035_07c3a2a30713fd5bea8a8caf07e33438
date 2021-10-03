package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PollOfferParser implements IMessageParser
   {
       
      
      private var var_1101:String = "";
      
      private var _id:int = -1;
      
      public function PollOfferParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _id = param1.readInteger();
         var_1101 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         _id = -1;
         var_1101 = "";
         return true;
      }
      
      public function get summary() : String
      {
         return var_1101;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
