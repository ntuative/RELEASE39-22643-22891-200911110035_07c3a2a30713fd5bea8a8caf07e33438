package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class InstantMessageErrorMessageParser implements IMessageParser
   {
       
      
      private var _userId:int;
      
      private var var_983:int;
      
      public function InstantMessageErrorMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_983 = param1.readInteger();
         this._userId = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get errorCode() : int
      {
         return this.var_983;
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
   }
}
