package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   
   public class RoomChatHandler extends BaseHandler
   {
       
      
      public function RoomChatHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new ChatMessageEvent(onRoomChat));
         param1.addMessageEvent(new WhisperMessageEvent(onRoomWhisper));
         param1.addMessageEvent(new ShoutMessageEvent(onRoomShout));
         param1.addMessageEvent(new RespectNotificationMessageEvent(onRespectNotification));
      }
      
      private function onRoomWhisper(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(listener && false)
         {
            _loc2_ = param1 as WhisperMessageEvent;
            if(_loc2_ && _loc2_.getParser())
            {
               _loc3_ = listener.getSession(_xxxRoomId,var_51);
               if(_loc3_ == null)
               {
                  return;
               }
               _loc4_ = "null";
               _loc5_ = 0;
               _loc6_ = _loc2_.getParser();
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc4_,_loc3_,_loc6_.userId,_loc6_.text,_loc5_));
            }
         }
      }
      
      private function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:RespectNotificationMessageEvent = param1 as RespectNotificationMessageEvent;
         if(listener && false)
         {
            _loc3_ = listener.getSession(_xxxRoomId,var_51);
            if(_loc3_ == null)
            {
               return;
            }
            _loc4_ = "null";
            _loc5_ = 0;
            _loc6_ = _loc3_.userDataManager.getUserData(_loc2_.userId);
            if(_loc6_ == null)
            {
               return;
            }
            _loc7_ = "";
            listener.events.dispatchEvent(new RoomSessionChatEvent(_loc4_,_loc3_,_loc6_.id,_loc7_,_loc5_));
         }
      }
      
      private function onRoomChat(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(listener && false)
         {
            _loc2_ = param1 as ChatMessageEvent;
            if(_loc2_ && _loc2_.getParser())
            {
               _loc3_ = listener.getSession(_xxxRoomId,var_51);
               if(_loc3_ == null)
               {
                  return;
               }
               _loc4_ = "null";
               _loc5_ = 0;
               _loc6_ = _loc2_.getParser();
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc4_,_loc3_,_loc6_.userId,_loc6_.text,_loc5_));
            }
         }
      }
      
      private function onRoomShout(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(listener && false)
         {
            _loc2_ = param1 as ShoutMessageEvent;
            if(_loc2_ && _loc2_.getParser())
            {
               _loc3_ = listener.getSession(_xxxRoomId,var_51);
               if(_loc3_ == null)
               {
                  return;
               }
               _loc4_ = "null";
               _loc5_ = 0;
               _loc6_ = _loc2_.getParser();
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc4_,_loc3_,_loc6_.userId,_loc6_.text,_loc5_));
            }
         }
      }
   }
}
