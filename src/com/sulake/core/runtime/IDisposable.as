package com.sulake.core.runtime
{
   public interface IDisposable
   {
       
      
      function get disposed() : Boolean;
      
      function dispose() : void;
   }
}
