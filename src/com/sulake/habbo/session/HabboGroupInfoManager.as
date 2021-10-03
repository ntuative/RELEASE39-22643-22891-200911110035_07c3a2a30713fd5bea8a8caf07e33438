package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class HabboGroupInfoManager
   {
       
      
      private var var_170:Map;
      
      private var var_164:Map;
      
      private var _sessionManager:SessionDataManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var name_1:IEventDispatcher;
      
      private var var_928:Dictionary;
      
      public function HabboGroupInfoManager(param1:SessionDataManager, param2:IEventDispatcher)
      {
         var_928 = new Dictionary();
         super();
         _sessionManager = param1;
         var_164 = new Map();
         var_170 = new Map();
         name_1 = param2;
      }
      
      private function onGroupDetails(param1:IMessageEvent) : void
      {
         var _loc2_:HabboGroupDetailsMessageEvent = param1 as HabboGroupDetailsMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:HabboGroupDetails = new HabboGroupDetails(_loc2_.groupId);
         _loc3_.name = _loc2_.name;
         _loc3_.description = _loc2_.description;
         _loc3_.roomId = _loc2_.roomId;
         _loc3_.roomName = _loc2_.roomName;
         _loc3_.badgeId = var_164.getValue(_loc2_.groupId);
         var_928[_loc2_.groupId] = _loc3_;
         _sessionManager.showGroupBadgeInfo(_loc2_.groupId);
      }
      
      private function onHabboGroupBadges(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:HabboGroupBadgesMessageEvent = param1 as HabboGroupBadgesMessageEvent;
         var _loc3_:Map = _loc2_.badges;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc4_ = _loc3_.getKey(_loc6_);
            if(var_164.getValue(_loc4_) != null)
            {
               var_164.remove(_loc4_);
            }
            var_164.add(_loc4_,_loc3_.getWithIndex(_loc6_));
            _loc6_++;
         }
      }
      
      public function getBadgeId(param1:int) : String
      {
         return var_164.getValue(param1);
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         _communication.getHabboMainConnection(null).send(new GetHabboGroupBadgesMessageComposer());
      }
      
      public function getGroupDetails(param1:int) : HabboGroupDetails
      {
         var _loc2_:HabboGroupDetails = var_928[param1];
         if(_loc2_ == null)
         {
            _communication.getHabboMainConnection(null).send(new GetHabboGroupDetailsMessageComposer(param1));
         }
         return _loc2_;
      }
      
      public function set communication(param1:IHabboCommunicationManager) : void
      {
         _communication = param1;
         _communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(onRoomReady) as IMessageEvent);
         _communication.addHabboConnectionMessageEvent(new HabboGroupBadgesMessageEvent(onHabboGroupBadges));
         _communication.addHabboConnectionMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails));
      }
      
      public function dispose() : void
      {
         _communication = null;
         var_928 = null;
      }
   }
}
