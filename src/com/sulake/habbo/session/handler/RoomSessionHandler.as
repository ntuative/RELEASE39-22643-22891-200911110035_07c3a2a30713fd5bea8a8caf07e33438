package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomQueueStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.YouAreSpectatorMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.session.GoToFlatMessageComposer;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueSet;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.session.events.RoomSessionQueueEvent;
   
   public class RoomSessionHandler extends BaseHandler
   {
      
      public static const const_760:String = "RS_CONNECTED";
      
      public static const const_491:String = "RS_DISCONNECTED";
      
      public static const const_768:String = "RS_READY";
       
      
      public function RoomSessionHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new OpenConnectionMessageEvent(onRoomConnected));
         param1.addMessageEvent(new FlatAccessibleMessageEvent(onFlatAccessible));
         param1.addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
         param1.addMessageEvent(new CloseConnectionMessageEvent(onRoomDisconnected));
         param1.addMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
         param1.addMessageEvent(new RoomQueueStatusMessageEvent(onRoomQueueStatus));
         param1.addMessageEvent(new YouAreSpectatorMessageEvent(onYouAreSpectator));
      }
      
      private function onRoomQueueStatus(param1:RoomQueueStatusMessageEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         if(listener == null || true)
         {
            return;
         }
         var _loc2_:RoomQueueStatusMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_xxxRoomId,var_51);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:Array = _loc2_.getQueueSetTargets();
         var _loc8_:int = _loc2_.activeTarget;
         for each(_loc9_ in _loc6_)
         {
            _loc4_ = _loc2_.getQueueSet(_loc9_);
            _loc5_ = new RoomSessionQueueEvent(_loc3_,_loc4_.name,_loc4_.target,_loc4_.target == _loc8_);
            _loc7_ = _loc4_.queueTypes;
            for each(_loc10_ in _loc7_)
            {
               _loc5_.addQueue(_loc10_,_loc4_.getQueueSize(_loc10_));
            }
            listener.events.dispatchEvent(_loc5_);
         }
      }
      
      private function onRoomDisconnected(param1:IMessageEvent) : void
      {
         var _loc2_:int = _xxxRoomId;
         var _loc3_:int = var_51;
         if(listener)
         {
            listener.sessionUpdate(_loc2_,_loc3_,RoomSessionHandler.const_491);
         }
      }
      
      private function onFlatAccessDenied(param1:FlatAccessDeniedMessageEvent) : void
      {
         var _loc6_:* = null;
         var _loc2_:int = _xxxRoomId;
         var _loc3_:int = var_51;
         var _loc4_:FlatAccessDeniedMessageParser = param1.getParser();
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:String = _loc4_.userName;
         if(_loc5_ == null || _loc5_.length == 0)
         {
            if(listener)
            {
               listener.sessionUpdate(_loc2_,_loc3_,RoomSessionHandler.const_491);
            }
         }
         else if(listener && false)
         {
            _loc6_ = listener.getSession(_loc2_,_loc3_);
            if(_loc6_ != null)
            {
               listener.events.dispatchEvent(new RoomSessionDoorbellEvent(RoomSessionDoorbellEvent.const_105,_loc6_,_loc5_));
            }
         }
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         var _loc7_:* = null;
         var _loc2_:int = _xxxRoomId;
         var _loc3_:int = var_51;
         var _loc4_:int = _loc2_;
         var _loc5_:int = _loc3_;
         var _loc6_:RoomReadyMessageEvent = param1 as RoomReadyMessageEvent;
         if(_loc6_ != null)
         {
            _loc7_ = _loc6_.getParser();
            if(_loc7_ != null)
            {
               _loc4_ = _loc7_.roomId;
               _loc5_ = _loc7_.roomCategory;
            }
         }
         if(listener)
         {
            listener.sessionReinitialize(_loc2_,_loc3_,_loc4_,_loc5_);
            listener.sessionUpdate(_loc2_,_loc3_,RoomSessionHandler.const_768);
         }
      }
      
      private function onYouAreSpectator(param1:YouAreSpectatorMessageEvent) : void
      {
         if(listener == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(_xxxRoomId,var_51);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.isSpectatorMode = true;
      }
      
      private function onFlatAccessible(param1:IMessageEvent) : void
      {
         var _loc2_:int = _xxxRoomId;
         connection.send(new GoToFlatMessageComposer(_loc2_));
      }
      
      private function onRoomConnected(param1:IMessageEvent) : void
      {
         var _loc2_:int = _xxxRoomId;
         var _loc3_:int = var_51;
         if(listener)
         {
            listener.sessionUpdate(_loc2_,_loc3_,RoomSessionHandler.const_760);
         }
      }
   }
}
