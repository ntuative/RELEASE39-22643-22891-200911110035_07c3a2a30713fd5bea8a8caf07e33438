package com.sulake.core.localization
{
   public interface ILocalization
   {
       
      
      function get raw() : String;
      
      function get value() : String;
      
      function get isInitialized() : Boolean;
      
      function get key() : String;
   }
}
