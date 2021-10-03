package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
   
   public class ObjectAddMessageParser implements IMessageParser
   {
       
      
      private var _data:ObjectMessageData;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function ObjectAddMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         _roomId = 0;
         _roomCategory = 0;
         return true;
      }
      
      public function get data() : ObjectMessageData
      {
         var _loc1_:ObjectMessageData = _data;
         if(_loc1_ != null)
         {
            _loc1_.setReadOnly();
         }
         return _loc1_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _data = ObjectDataParser.parseObjectData(param1);
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
   }
}
