package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class VoteQuestionMessageParser implements IMessageParser
   {
       
      
      private var var_952:Array;
      
      private var var_935:String;
      
      public function VoteQuestionMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_935 = param1.readString();
         var_952 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.readInteger();
            var_952.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get choices() : Array
      {
         return var_952.slice();
      }
      
      public function flush() : Boolean
      {
         var_935 = "";
         var_952 = [];
         return true;
      }
      
      public function get question() : String
      {
         return var_935;
      }
   }
}
