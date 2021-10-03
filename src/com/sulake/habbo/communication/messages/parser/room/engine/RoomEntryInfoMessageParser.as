package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
   
   public class RoomEntryInfoMessageParser implements IMessageParser
   {
       
      
      private var var_1996:int;
      
      private var var_326:Boolean;
      
      private var var_1995:Boolean;
      
      private var var_800:PublicRoomShortData;
      
      public function RoomEntryInfoMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1995 = param1.readBoolean();
         if(var_1995)
         {
            var_1996 = param1.readInteger();
            var_326 = param1.readBoolean();
         }
         else
         {
            var_800 = new PublicRoomShortData(param1);
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         if(var_800 != null)
         {
            var_800.dispose();
            var_800 = null;
         }
         return true;
      }
      
      public function get guestRoomId() : int
      {
         return var_1996;
      }
      
      public function get owner() : Boolean
      {
         return var_326;
      }
      
      public function get guestRoom() : Boolean
      {
         return var_1995;
      }
      
      public function get publicSpace() : PublicRoomShortData
      {
         return var_800;
      }
   }
}
