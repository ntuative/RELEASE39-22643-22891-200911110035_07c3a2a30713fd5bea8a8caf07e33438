package com.sulake.core.window.graphics
{
   public interface IGraphicContextHost
   {
       
      
      function hasGraphicsContext() : Boolean;
      
      function get name() : String;
      
      function getGraphicContext(param1:Boolean) : IGraphicContext;
   }
}
