package com.sulake.core.window.components
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface IFocusWindow extends IDisposable
   {
       
      
      function focus() : Boolean;
      
      function unfocus() : Boolean;
      
      function get focused() : Boolean;
   }
}
