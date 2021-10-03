package com.sulake.habbo.friendlist
{
   import com.sulake.habbo.friendlist.domain.FriendRequest;
   
   public interface IFriendRequestsView
   {
       
      
      function removeRequest(param1:FriendRequest) : void;
      
      function addRequest(param1:FriendRequest) : void;
      
      function refreshRequestEntry(param1:FriendRequest) : void;
      
      function refreshShading(param1:FriendRequest, param2:Boolean) : void;
   }
}
