package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
   import com.sulake.habbo.friendlist.Util;
   import flash.utils.Dictionary;
   
   public class FriendCategories
   {
       
      
      private var var_306:Array;
      
      private var var_349:IFriendCategoriesDeps;
      
      private var var_1109:Dictionary;
      
      public function FriendCategories(param1:IFriendCategoriesDeps)
      {
         var_306 = new Array();
         var_1109 = new Dictionary();
         super();
         var_349 = param1;
      }
      
      public function getSelectedFriends() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in var_306)
         {
            _loc2_.getSelectedFriends(_loc1_);
         }
         return _loc1_;
      }
      
      private function updateCategories(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         flushReceivedStatus();
         findCategory(FriendCategory.const_423).received = true;
         findCategory(FriendCategory.const_734).received = true;
         for each(_loc2_ in param1)
         {
            _loc4_ = findCategory(_loc2_.id);
            if(_loc4_ != null)
            {
               _loc4_.received = true;
               if(_loc4_.name != _loc2_.name)
               {
                  _loc4_.name = _loc2_.name;
               }
            }
            else
            {
               _loc5_ = new FriendCategory(_loc2_.id,_loc2_.name);
               _loc5_.received = true;
               addCategory(_loc5_);
            }
         }
         for each(_loc3_ in getCategoriesNotReceived())
         {
            if(_loc3_.friends.length <= 0)
            {
               Util.remove(var_306,_loc3_);
               _loc3_.dispose();
            }
         }
      }
      
      private function removeFriend(param1:int, param2:Boolean) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param2)
         {
            var_1109[param1] = null;
         }
         var _loc3_:Boolean = false;
         for each(_loc4_ in var_306)
         {
            _loc5_ = _loc4_.removeFriend(param1);
            if(_loc5_ != null)
            {
               _loc3_ = _loc5_.selected;
               if(param2)
               {
                  _loc5_.dispose();
               }
            }
         }
         return _loc3_;
      }
      
      private function isFriendOnline(param1:int) : Boolean
      {
         var _loc2_:Friend = findFriend(param1);
         return _loc2_ == null ? false : Boolean(_loc2_.online);
      }
      
      public function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         Logger.log("Received friend list update");
         var _loc2_:FriendListUpdateMessageParser = (param1 as FriendListUpdateEvent).getParser();
         updateCategories(_loc2_.cats);
         for each(_loc3_ in _loc2_.removedFriendIds)
         {
            removeFriend(_loc3_,true);
         }
         for each(_loc4_ in _loc2_.updatedFriends)
         {
            Logger.log("Got UPDATE: " + _loc4_.id + ", " + _loc4_.online + ", " + _loc4_.name + ", " + _loc4_.followingAllowed);
            var_349.messenger.setFollowingAllowed(_loc4_.id,_loc4_.followingAllowed && _loc4_.online);
            _loc6_ = isFriendOnline(_loc4_.id);
            if(_loc6_ && !_loc4_.online)
            {
               var_349.messenger.setOnlineStatus(_loc4_.id,_loc4_.online);
               var_349.notifications.addOfflineNotification(_loc4_.name);
            }
            if(!_loc6_ && _loc4_.online)
            {
               var_349.messenger.setOnlineStatus(_loc4_.id,_loc4_.online);
               var_349.view.setNewMessageArrived();
               var_349.notifications.addOnlineNotification(_loc4_.name,_loc4_.figure);
            }
            _loc7_ = removeFriend(_loc4_.id,true);
            _loc8_ = new Friend(_loc4_);
            _loc8_.selected = _loc7_;
            addFriend(_loc8_);
         }
         for each(_loc5_ in _loc2_.addedFriends)
         {
            Logger.log("Got INSERT: " + _loc5_.id + ", " + _loc5_.name);
            removeFriend(_loc5_.id,true);
            addFriend(new Friend(_loc5_));
         }
         this.var_349.view.refreshList();
      }
      
      public function addCategory(param1:FriendCategory) : void
      {
         var_306.push(param1);
      }
      
      public function getSelectedFriend() : Friend
      {
         var _loc1_:Array = getSelectedFriends();
         return _loc1_.length == 1 ? _loc1_[0] : null;
      }
      
      private function getCategoriesNotReceived() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in var_306)
         {
            if(!_loc2_.received)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getCategories() : Array
      {
         return var_306;
      }
      
      public function findFriend(param1:int) : Friend
      {
         return var_1109[param1];
      }
      
      private function flushReceivedStatus() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_306)
         {
            _loc1_.received = false;
         }
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean = false) : int
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         for each(_loc4_ in var_306)
         {
            _loc3_ += _loc4_.getFriendCount(param1,param2);
         }
         return _loc3_;
      }
      
      public function findCategory(param1:int) : FriendCategory
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_306)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addFriend(param1:Friend) : FriendCategory
      {
         var _loc2_:int = !!param1.online ? int(param1.categoryId) : int(FriendCategory.const_423);
         var _loc3_:FriendCategory = findCategory(_loc2_);
         if(_loc3_ != null)
         {
            _loc3_.addFriend(param1);
            var_1109[param1.id] = param1;
            return _loc3_;
         }
         Logger.log("No category " + _loc2_ + " found for friend " + param1.id + ". Ignoring");
         return null;
      }
   }
}
