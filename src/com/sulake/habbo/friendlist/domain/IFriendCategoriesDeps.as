package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.IFriendsView;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.notifications.IHabboNotifications;
   
   public interface IFriendCategoriesDeps
   {
       
      
      function get notifications() : IHabboNotifications;
      
      function get messenger() : IHabboMessenger;
      
      function get view() : IFriendsView;
   }
}
