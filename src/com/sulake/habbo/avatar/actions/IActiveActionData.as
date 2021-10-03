package com.sulake.habbo.avatar.actions
{
   public interface IActiveActionData
   {
       
      
      function get actionType() : String;
      
      function get actionParameter() : String;
      
      function set actionParameter(param1:String) : void;
      
      function get definition() : IActionDefinition;
      
      function get id() : String;
      
      function set definition(param1:IActionDefinition) : void;
   }
}
