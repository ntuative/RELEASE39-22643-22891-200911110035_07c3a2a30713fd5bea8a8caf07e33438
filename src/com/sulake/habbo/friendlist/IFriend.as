package com.sulake.habbo.friendlist
{
   public interface IFriend
   {
       
      
      function get gender() : int;
      
      function get id() : int;
      
      function get online() : Boolean;
      
      function get figure() : String;
      
      function get followingAllowed() : Boolean;
      
      function get name() : String;
   }
}
