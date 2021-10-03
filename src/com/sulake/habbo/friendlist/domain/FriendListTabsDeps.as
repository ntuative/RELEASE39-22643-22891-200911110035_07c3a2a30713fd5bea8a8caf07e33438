package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.HabboFriendList;
   
   public class FriendListTabsDeps implements IFriendListTabsDeps
   {
       
      
      private var _friendList:HabboFriendList;
      
      public function FriendListTabsDeps(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function getFriendList() : HabboFriendList
      {
         return _friendList;
      }
      
      public function getWindowHeight() : int
      {
         return _friendList.view.mainWindow.height;
      }
   }
}
