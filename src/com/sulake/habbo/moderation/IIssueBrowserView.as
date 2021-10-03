package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowContainer;
   
   public interface IIssueBrowserView
   {
       
      
      function update() : void;
      
      function set visible(param1:Boolean) : void;
      
      function get view() : IWindowContainer;
   }
}
