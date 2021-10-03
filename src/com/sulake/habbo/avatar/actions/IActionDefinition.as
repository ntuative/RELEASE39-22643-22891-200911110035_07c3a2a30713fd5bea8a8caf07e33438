package com.sulake.habbo.avatar.actions
{
   public interface IActionDefinition
   {
       
      
      function get isMain() : Boolean;
      
      function get lay() : String;
      
      function get activePartSet() : String;
      
      function get precedence() : int;
      
      function get geometryType() : String;
      
      function get state() : String;
      
      function get assetPartDefinition() : String;
      
      function get isDefault() : Boolean;
      
      function getPrevents(param1:String = "") : Array;
      
      function getOffsets(param1:String, param2:int) : Array;
      
      function get isAnimation() : Boolean;
      
      function get id() : String;
      
      function setOffsets(param1:String, param2:int, param3:Array) : void;
   }
}
