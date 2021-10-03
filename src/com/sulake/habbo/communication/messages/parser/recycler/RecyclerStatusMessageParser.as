package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RecyclerStatusMessageParser implements IMessageParser
   {
       
      
      private var _recyclerStatus:int = -1;
      
      private var var_1002:int = 0;
      
      public function RecyclerStatusMessageParser()
      {
         super();
      }
      
      public function get recyclerStatus() : int
      {
         return _recyclerStatus;
      }
      
      public function flush() : Boolean
      {
         _recyclerStatus = -1;
         var_1002 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _recyclerStatus = param1.readInteger();
         var_1002 = param1.readInteger();
         return true;
      }
      
      public function get recyclerTimeoutSeconds() : int
      {
         return var_1002;
      }
   }
}
