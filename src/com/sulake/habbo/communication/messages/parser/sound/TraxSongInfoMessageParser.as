package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class TraxSongInfoMessageParser implements IMessageParser
   {
       
      
      private var _data:String;
      
      private var _name:String;
      
      private var _id:int;
      
      public function TraxSongInfoMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _id = param1.readInteger();
         _name = param1.readString();
         _data = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         _id = -1;
         _name = "";
         _data = null;
         return true;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}
