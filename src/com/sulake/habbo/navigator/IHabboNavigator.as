package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboNavigator extends IUnknown
   {
       
      
      function performTagSearch(param1:String) : void;
      
      function get events() : IEventDispatcher;
      
      function goToHomeRoom() : Boolean;
      
      function goToRoom(param1:int, param2:Boolean, param3:String = "") : void;
      
      function showOwnRooms() : void;
   }
}
