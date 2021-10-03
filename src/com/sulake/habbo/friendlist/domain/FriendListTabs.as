package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.FriendRequestsView;
   import com.sulake.habbo.friendlist.FriendsView;
   import com.sulake.habbo.friendlist.SearchView;
   
   public class FriendListTabs
   {
       
      
      private var var_1860:int = 200;
      
      private var var_619:int = 200;
      
      private var var_349:IFriendListTabsDeps;
      
      private var var_388:Array;
      
      private var var_1378:FriendListTab;
      
      private var var_1377:int = 200;
      
      public function FriendListTabs(param1:IFriendListTabsDeps)
      {
         var_388 = new Array();
         super();
         var_349 = param1;
         var_388.push(new FriendListTab(var_349.getFriendList(),FriendListTab.const_79,new FriendsView(),"${friendlist.friends}","friends_footer","hdr_friends"));
         var_388.push(new FriendListTab(var_349.getFriendList(),FriendListTab.const_90,new FriendRequestsView(),"${friendlist.tab.friendrequests}","friend_requests_footer","hdr_friend_requests"));
         var_388.push(new FriendListTab(var_349.getFriendList(),FriendListTab.const_294,new SearchView(),"${generic.search}","search_footer","hdr_search"));
         toggleSelected(null);
      }
      
      public function findSelectedTab() : FriendListTab
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_388)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get tabContentWidth() : int
      {
         return var_1377 - 2;
      }
      
      public function toggleSelected(param1:FriendListTab) : void
      {
         var _loc2_:FriendListTab = findSelectedTab();
         if(_loc2_ == null)
         {
            var_619 = var_1860;
            setSelected(determineDisplayedTab(param1),true);
         }
         else if(_loc2_ == param1 || param1 == null)
         {
            var_1860 = var_619;
            var_619 = 0;
            clearSelections();
         }
         else
         {
            setSelected(determineDisplayedTab(param1),true);
         }
      }
      
      public function clearSelections() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_388)
         {
            _loc1_.setSelected(false);
         }
      }
      
      public function set tabContentHeight(param1:int) : void
      {
         var_619 = param1;
      }
      
      public function findTab(param1:int) : FriendListTab
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_388)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function setSelected(param1:FriendListTab, param2:Boolean) : void
      {
         var _loc3_:FriendListTab = findSelectedTab();
         clearSelections();
         param1.setSelected(param2);
         if(param2)
         {
            var_1378 = param1;
         }
      }
      
      private function determineDisplayedTab(param1:FriendListTab) : FriendListTab
      {
         if(param1 != null)
         {
            return param1;
         }
         if(var_1378 != null)
         {
            return var_1378;
         }
         return var_388[0];
      }
      
      public function get tabContentHeight() : int
      {
         return var_619;
      }
      
      public function set windowWidth(param1:int) : void
      {
         var_1377 = param1;
      }
      
      public function getTabs() : Array
      {
         return var_388;
      }
      
      public function get windowWidth() : int
      {
         return var_1377;
      }
   }
}
