package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowContainer;
   
   public interface IHeaderWindow extends IWindowContainer
   {
       
      
      function get title() : ITextWindow;
      
      function get controls() : IItemListWindow;
   }
}
