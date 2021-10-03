package com.sulake.habbo.advertisement
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IAdManager extends IUnknown
   {
       
      
      function showInterstitial() : Boolean;
      
      function get events() : IEventDispatcher;
      
      function showRoomAd() : void;
   }
}
