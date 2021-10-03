package com.sulake.habbo.catalog.recycler
{
   public interface IRecyclerVisualization
   {
       
      
      function displayDisabledView() : void;
      
      function displayTimeOutView(param1:int) : void;
      
      function displayFinishedView() : void;
      
      function displayProcessingView() : void;
      
      function updateRecycleButton(param1:Boolean) : void;
      
      function updateSlots() : void;
      
      function displayNormalView() : void;
   }
}
