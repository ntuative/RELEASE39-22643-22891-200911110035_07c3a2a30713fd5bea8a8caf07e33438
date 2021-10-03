package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WaveMessageParser implements IMessageParser
   {
       
      
      private var _userId:int = 0;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1510:Boolean = true;
      
      public function WaveMessageParser()
      {
         super();
      }
      
      public function get isWaving() : Boolean
      {
         return var_1510;
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         _roomCategory = 0;
         _userId = 0;
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         return true;
      }
   }
}
