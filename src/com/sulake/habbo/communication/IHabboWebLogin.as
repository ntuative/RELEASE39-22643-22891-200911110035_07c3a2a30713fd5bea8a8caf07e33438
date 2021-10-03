package com.sulake.habbo.communication
{
   import flash.events.IEventDispatcher;
   
   public interface IHabboWebLogin extends IEventDispatcher
   {
       
      
      function init() : void;
      
      function requestReAuthenticate() : void;
   }
}
