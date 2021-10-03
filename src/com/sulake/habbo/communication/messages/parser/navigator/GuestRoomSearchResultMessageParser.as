package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
   
   public class GuestRoomSearchResultMessageParser implements IMessageParser
   {
       
      
      private var _data:GuestRoomSearchResultData;
      
      public function GuestRoomSearchResultMessageParser()
      {
         super();
      }
      
      public function get data() : GuestRoomSearchResultData
      {
         return _data;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._data = new GuestRoomSearchResultData(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
