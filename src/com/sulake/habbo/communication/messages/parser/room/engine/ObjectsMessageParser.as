package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
   
   public class ObjectsMessageParser implements IMessageParser
   {
       
      
      private var _objects:Array;
      
      private var _roomCategory:int = 0;
      
      private var _roomId:int = 0;
      
      public function ObjectsMessageParser()
      {
         _objects = [];
         super();
      }
      
      public function flush() : Boolean
      {
         _objects = [];
         _roomId = 0;
         _roomCategory = 0;
         return true;
      }
      
      public function getObject(param1:int) : ObjectMessageData
      {
         if(param1 < 0 || param1 >= getObjectCount())
         {
            return null;
         }
         var _loc2_:ObjectMessageData = _objects[param1] as ObjectMessageData;
         if(_loc2_ != null)
         {
            _loc2_.setReadOnly();
         }
         return _loc2_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:* = null;
         if(param1 == null)
         {
            return false;
         }
         _objects = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ObjectDataParser.parseObjectData(param1);
            if(_loc4_ != null)
            {
               _objects.push(_loc4_);
            }
            _loc3_++;
         }
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
      
      public function getObjectCount() : int
      {
         return _objects.length;
      }
   }
}
