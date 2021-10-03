package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.IFriendRequestsView;
   
   public class FriendRequestsDeps implements IFriendRequestsDeps
   {
       
      
      private var _friendList:HabboFriendList;
      
      public function FriendRequestsDeps(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function get view() : IFriendRequestsView
      {
         return _friendList.tabs.findTab(FriendListTab.const_90).tabView as IFriendRequestsView;
      }
   }
}
