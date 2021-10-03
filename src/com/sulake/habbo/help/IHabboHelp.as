package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboHelp extends IUnknown
   {
       
      
      function get events() : IEventDispatcher;
      
      function reportUser(param1:int, param2:String) : void;
   }
}
