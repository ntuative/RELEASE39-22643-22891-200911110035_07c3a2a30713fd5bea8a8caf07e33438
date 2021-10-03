package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.habbo.communication.messages.incoming.poll.VoteQuestionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.poll.VoteResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.poll.VoteQuestionMessageParser;
   import com.sulake.habbo.communication.messages.parser.poll.VoteResultMessageParser;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionVoteEvent;
   
   public class VoteHandler extends BaseHandler
   {
       
      
      public function VoteHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(!param1)
         {
            return;
         }
         param1.addMessageEvent(new VoteQuestionMessageEvent(onVoteQuestionEvent));
         param1.addMessageEvent(new VoteResultMessageEvent(onVoteResultEvent));
      }
      
      private function onVoteQuestionEvent(param1:VoteQuestionMessageEvent) : void
      {
         var _loc4_:* = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(_xxxRoomId,var_51);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:VoteQuestionMessageParser = param1.getParser();
         _loc4_ = new RoomSessionVoteEvent(RoomSessionVoteEvent.const_119,_loc2_,_loc3_.question,_loc3_.choices);
         listener.events.dispatchEvent(_loc4_);
      }
      
      private function onVoteResultEvent(param1:VoteResultMessageEvent) : void
      {
         var _loc4_:* = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(_xxxRoomId,var_51);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:VoteResultMessageParser = param1.getParser();
         _loc4_ = new RoomSessionVoteEvent(RoomSessionVoteEvent.const_108,_loc2_,_loc3_.question,_loc3_.choices,_loc3_.votes,_loc3_.totalVotes);
         listener.events.dispatchEvent(_loc4_);
      }
   }
}
