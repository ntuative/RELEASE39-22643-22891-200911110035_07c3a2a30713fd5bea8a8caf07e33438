package com.sulake.habbo.window.utils
{
   public interface IAlertDialogWithLink extends IAlertDialog
   {
       
      
      function set linkUrl(param1:String) : void;
      
      function set linkTitle(param1:String) : void;
      
      function get linkUrl() : String;
      
      function get linkTitle() : String;
   }
}
