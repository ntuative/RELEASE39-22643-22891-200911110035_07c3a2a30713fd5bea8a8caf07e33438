package com.sulake.habbo.catalog.viewer
{
   public interface IPageLocalization
   {
       
      
      function getTextElementContent(param1:int) : String;
      
      function getImageElementContent(param1:int) : String;
      
      function getLinks(param1:String) : Array;
      
      function getTextElementName(param1:int, param2:String) : String;
      
      function dispose() : void;
      
      function getImageElementName(param1:int, param2:String) : String;
      
      function hasColors(param1:String) : Boolean;
      
      function getColorSources(param1:String) : Array;
      
      function get textCount() : int;
      
      function get imageCount() : int;
      
      function getColorTargets(param1:String) : Array;
      
      function getColorUintFromText(param1:int) : uint;
      
      function hasLinks(param1:String) : Boolean;
   }
}
