package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.enum.GenericErrorEnum;
   import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
   
   public class GenericErrorHandler extends BaseHandler
   {
       
      
      public function GenericErrorHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new GenericErrorEvent(onGenericError));
      }
      
      private function onGenericError(param1:IMessageEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:GenericErrorParser = (param1 as GenericErrorEvent).getParser();
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
            case GenericErrorEnum.const_1127:
               _loc4_ = "null";
               break;
            case GenericErrorEnum.const_193:
               _loc4_ = "null";
               break;
            case GenericErrorEnum.const_194:
               _loc4_ = "null";
               break;
            case GenericErrorEnum.const_181:
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
