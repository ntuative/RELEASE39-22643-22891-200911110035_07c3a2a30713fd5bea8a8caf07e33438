package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindowContainer;
   
   public interface IViewCtrl
   {
       
      
      function get content() : IWindowContainer;
      
      function set content(param1:IWindowContainer) : void;
      
      function refresh() : void;
   }
}
