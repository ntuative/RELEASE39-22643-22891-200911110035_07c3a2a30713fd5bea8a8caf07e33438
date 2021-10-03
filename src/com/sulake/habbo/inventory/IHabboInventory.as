package com.sulake.habbo.inventory
{
   import com.sulake.core.runtime.IUnknown;
   
   public interface IHabboInventory extends IUnknown
   {
       
      
      function setupRecycler(param1:Boolean) : void;
      
      function setupTrading(param1:int, param2:String) : void;
      
      function get tradingActive() : Boolean;
      
      function get clubHasEverBeenMember() : Boolean;
      
      function get clubPastPeriods() : int;
      
      function get clubDays() : int;
      
      function setEffectSelected(param1:int) : void;
      
      function setEffectDeselected(param1:int) : void;
      
      function getAvatarEffects() : Array;
      
      function getActivatedAvatarEffects() : Array;
      
      function toggleInventorySubPage(param1:String) : void;
      
      function toggleInventoryPage(param1:String) : void;
      
      function returnInventoryFurniFromRecycler(param1:int) : Boolean;
      
      function get clubPeriods() : int;
      
      function requestSelectedFurniToRecycler() : int;
      
      function deselectAllEffects() : void;
   }
}
