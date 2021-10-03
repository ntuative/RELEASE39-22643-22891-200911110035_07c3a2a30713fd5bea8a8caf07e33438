package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
   
   public class ItemsMessageParser implements IMessageParser
   {
       
      
      private var _items:Array;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function ItemsMessageParser()
      {
         _items = [];
         super();
      }
      
      public function flush() : Boolean
      {
         _items = [];
         _roomId = 0;
         _roomCategory = 0;
         return true;
      }
      
      public function getItemCount() : int
      {
         return _items.length;
      }
      
      public function getItem(param1:int) : ItemMessageData
      {
         if(param1 < 0 || param1 >= getItemCount())
         {
            return null;
         }
         var _loc2_:ItemMessageData = _items[param1] as ItemMessageData;
         if(_loc2_ != null)
         {
            _loc2_.setReadOnly();
         }
         return _loc2_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _items = [];
         var _loc2_:int = param1.readInteger();
         Logger.log("We have: " + _loc2_ + " items");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _items.push(ItemDataParser.parseItemData(param1));
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
   }
}
