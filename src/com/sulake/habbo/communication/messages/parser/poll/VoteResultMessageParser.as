package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class VoteResultMessageParser implements IMessageParser
   {
       
      
      private var var_1195:int;
      
      private var var_935:String;
      
      private var var_615:Array;
      
      private var var_952:Array;
      
      public function VoteResultMessageParser()
      {
         super();
      }
      
      public function get votes() : Array
      {
         return var_615.slice();
      }
      
      public function flush() : Boolean
      {
         var_935 = "";
         var_952 = [];
         var_615 = [];
         var_1195 = 0;
         return true;
      }
      
      public function get totalVotes() : int
      {
         return var_1195;
      }
      
      public function get question() : String
      {
         return var_935;
      }
      
      public function get choices() : Array
      {
         return var_952.slice();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_935 = param1.readString();
         var_952 = [];
         var_615 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.readInteger();
            var_952.push(param1.readString());
            var_615.push(param1.readInteger());
            _loc3_++;
         }
         var_1195 = param1.readInteger();
         return true;
      }
   }
}
