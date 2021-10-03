package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.ISearchView;
   
   public class AvatarSearchDeps implements IAvatarSearchDeps
   {
       
      
      private var _friendList:HabboFriendList;
      
      public function AvatarSearchDeps(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function get view() : ISearchView
      {
         return _friendList.tabs.findTab(FriendListTab.const_294).tabView as ISearchView;
      }
   }
}
