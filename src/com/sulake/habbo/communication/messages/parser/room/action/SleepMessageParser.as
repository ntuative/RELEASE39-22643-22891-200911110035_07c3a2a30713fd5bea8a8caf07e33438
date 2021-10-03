package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class SleepMessageParser implements IMessageParser
   {
       
      
      private var _userId:int = 0;
      
      private var var_1713:Boolean = false;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function SleepMessageParser()
      {
         super();
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
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
      
      public function get sleeping() : Boolean
      {
         return var_1713;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         var_1713 = param1.readBoolean();
         return true;
      }
   }
}
