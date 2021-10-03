package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;
   
   public class IgnoredUsersManager
   {
       
      
      private var var_1022:Array;
      
      private var _ignoredUsers:Array;
      
      private var var_45:SessionDataManager;
      
      public function IgnoredUsersManager(param1:SessionDataManager)
      {
         _ignoredUsers = [];
         var_1022 = [];
         super();
         var_45 = param1;
      }
      
      public function ignoreUser(param1:String) : void
      {
         var_1022.push(param1);
         var _loc2_:IConnection = var_45.communication.getHabboMainConnection(null);
         _loc2_.send(new IgnoreUserMessageComposer(param1));
      }
      
      public function initIgnoreList() : void
      {
         var _loc1_:IConnection = var_45.communication.getHabboMainConnection(null);
         _loc1_.send(new GetIgnoredUsersMessageComposer(var_45.userName));
      }
      
      public function isIgnored(param1:String) : Boolean
      {
         return _ignoredUsers.indexOf(param1) >= 0;
      }
      
      private function removeUserFromIgnoreList(param1:String) : void
      {
         var _loc2_:int = _ignoredUsers.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _ignoredUsers.splice(_loc2_,1);
         }
      }
      
      private function onIgnoreResult(param1:IMessageEvent) : void
      {
         var _loc2_:IgnoreResultMessageEvent = param1 as IgnoreResultMessageEvent;
         var _loc3_:String = String(var_1022.shift());
         switch(_loc2_.result)
         {
            case 0:
               break;
            case 1:
               addUserToIgnoreList(_loc3_);
               break;
            case 2:
               addUserToIgnoreList(_loc3_);
               _ignoredUsers.shift();
               break;
            case 3:
               removeUserFromIgnoreList(_loc3_);
         }
      }
      
      private function onIgnoreList(param1:IMessageEvent) : void
      {
         var _loc2_:IgnoredUsersMessageEvent = param1 as IgnoredUsersMessageEvent;
         _ignoredUsers = _loc2_.ignoredUsers;
      }
      
      public function unignoreUser(param1:String) : void
      {
         var_1022.push(param1);
         var _loc2_:IConnection = var_45.communication.getHabboMainConnection(null);
         _loc2_.send(new UnignoreUserMessageComposer(param1));
      }
      
      public function registerMessageEvents() : void
      {
         var _loc1_:IConnection = var_45.communication.getHabboMainConnection(null);
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.addMessageEvent(new IgnoreResultMessageEvent(onIgnoreResult));
         _loc1_.addMessageEvent(new IgnoredUsersMessageEvent(onIgnoreList));
      }
      
      private function addUserToIgnoreList(param1:String) : void
      {
         if(_ignoredUsers.indexOf(param1) < 0)
         {
            _ignoredUsers.push(param1);
         }
      }
      
      public function dispose() : void
      {
         var_45 = null;
      }
   }
}
