package com.sulake.habbo.session
{
   public interface IUserDataManager
   {
       
      
      function getUserDataByIndex(param1:int) : IUserData;
      
      function getUserBadges(param1:int) : Array;
      
      function removeUserDataByIndex(param1:int) : void;
      
      function updateFigure(param1:int, param2:String) : void;
      
      function setUserData(param1:IUserData) : void;
      
      function getUserData(param1:int) : IUserData;
      
      function setUserBadges(param1:int, param2:Array) : void;
      
      function requestPetInfo(param1:int) : void;
   }
}
