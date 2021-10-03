package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.PlaceObjectErrorMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.PlaceObjectErrorMessageParser;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.enum.PlaceObjectErrorEnum;
   import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
   
   public class PlaceObjectErrorHandler extends BaseHandler
   {
       
      
      public function PlaceObjectErrorHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new PlaceObjectErrorMessageEvent(onPlaceObjectError));
      }
      
      private function onPlaceObjectError(param1:IMessageEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:PlaceObjectErrorMessageParser = (param1 as PlaceObjectErrorMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_xxxRoomId,var_51);
         if(_loc3_ == null)
         {
            return;
         }
         switch(_loc2_.errorCode)
         {
            case PlaceObjectErrorEnum.const_206:
               _loc4_ = "null";
               break;
            case PlaceObjectErrorEnum.const_186:
               _loc4_ = "null";
               break;
            case PlaceObjectErrorEnum.const_203:
               _loc4_ = "null";
               break;
            case PlaceObjectErrorEnum.const_184:
               _loc4_ = "null";
               break;
            case PlaceObjectErrorEnum.const_183:
               _loc4_ = "null";
               break;
            case PlaceObjectErrorEnum.const_189:
               _loc4_ = "null";
               break;
            case PlaceObjectErrorEnum.const_209:
               _loc4_ = "null";
               break;
            default:
               return;
         }
         if(listener && false)
         {
            listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc4_,_loc3_));
         }
      }
   }
}
