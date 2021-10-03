package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   
   public interface IHelpViewController extends IDisposable
   {
       
      
      function update(param1:* = null) : void;
      
      function set roomSessionActive(param1:Boolean) : void;
      
      function getWindowContainer() : IWindowContainer;
      
      function render() : void;
   }
}
