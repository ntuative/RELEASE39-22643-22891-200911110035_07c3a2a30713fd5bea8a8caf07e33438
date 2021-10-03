package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class RoomChatlogData
   {
       
      
      private var var_603:String;
      
      private var var_1262:Array;
      
      private var var_1261:Boolean;
      
      private var _roomId:int;
      
      public function RoomChatlogData(param1:IMessageDataWrapper)
      {
         var_1262 = new Array();
         super();
         var_1261 = param1.readBoolean();
         _roomId = param1.readInteger();
         var_603 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_1262.push(new ChatlineData(param1));
            _loc3_++;
         }
         Logger.log("READ ROOMCHATLOGDATA: " + var_1261 + ", " + _roomId + ", " + var_603 + ", " + chatlog.length);
      }
      
      public function get isPublic() : Boolean
      {
         return var_1261;
      }
      
      public function get roomName() : String
      {
         return var_603;
      }
      
      public function get chatlog() : Array
      {
         return var_1262;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}
