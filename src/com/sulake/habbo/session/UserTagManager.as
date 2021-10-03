package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.users.UserTagsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetUserTagsMessageComposer;
   import com.sulake.habbo.session.events.UserTagsReceivedEvent;
   import flash.events.IEventDispatcher;
   
   public class UserTagManager
   {
       
      
      private var var_1336:Map;
      
      private var _communication:IHabboCommunicationManager;
      
      private var name_1:IEventDispatcher;
      
      public function UserTagManager(param1:IEventDispatcher)
      {
         super();
         var_1336 = new Map();
         name_1 = param1;
      }
      
      private function onUserTags(param1:IMessageEvent) : void
      {
         var _loc2_:UserTagsMessageEvent = param1 as UserTagsMessageEvent;
         var _loc3_:int = _loc2_.userId;
         var _loc4_:Array = _loc2_.tags;
         var_1336.add(_loc3_,_loc4_);
         name_1.dispatchEvent(new UserTagsReceivedEvent(_loc3_,_loc4_.slice()));
      }
      
      public function set communication(param1:IHabboCommunicationManager) : void
      {
         _communication = param1;
         _communication.addHabboConnectionMessageEvent(new UserTagsMessageEvent(onUserTags));
      }
      
      public function getTags(param1:int) : Array
      {
         var _loc2_:Array = var_1336.getValue(param1) as Array;
         if(_loc2_ != null)
         {
            return _loc2_.slice();
         }
         if(_communication == null)
         {
            Logger.log("oops! communication interface not ready");
         }
         var _loc3_:IConnection = _communication.getHabboMainConnection(null);
         _loc3_.send(new GetUserTagsMessageComposer(param1));
         return null;
      }
   }
}
