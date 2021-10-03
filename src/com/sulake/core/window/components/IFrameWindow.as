package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.utils.IMargins;
   
   public interface IFrameWindow extends IWindowContainer
   {
       
      
      function get margins() : IMargins;
      
      function resizeToFitContent() : void;
      
      function get title() : ITextWindow;
      
      function get content() : IWindowContainer;
      
      function get header() : IHeaderWindow;
      
      function get scaler() : IScalerWindow;
   }
}
