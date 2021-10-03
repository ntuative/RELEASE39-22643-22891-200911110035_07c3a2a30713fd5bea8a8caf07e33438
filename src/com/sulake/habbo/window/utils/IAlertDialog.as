package com.sulake.habbo.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface IAlertDialog extends IDisposable
   {
       
      
      function set title(param1:String) : void;
      
      function get callback() : Function;
      
      function set description(param1:String) : void;
      
      function set callback(param1:Function) : void;
      
      function get description() : String;
      
      function get title() : String;
   }
}
