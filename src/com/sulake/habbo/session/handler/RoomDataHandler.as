package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomDataHandler extends BaseHandler
   {
       
      
      public function RoomDataHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new GetGuestRoomResultEvent(onRoomResult));
      }
      
      private function onRoomResult(param1:IMessageEvent) : void
      {
         var _loc2_:GetGuestRoomResultEvent = param1 as GetGuestRoomResultEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_xxxRoomId,var_51);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:GuestRoomData = (_loc2_.getParser() as GetGuestRoomResultMessageParser).data;
         _loc3_.isTradingRoom = _loc4_.allowTrading;
      }
   }
}
