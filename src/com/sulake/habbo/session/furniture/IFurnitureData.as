package com.sulake.habbo.session.furniture
{
   public interface IFurnitureData
   {
       
      
      function get revision() : int;
      
      function get colourIndex() : int;
      
      function get colours() : Array;
      
      function get tileSizeX() : int;
      
      function get tileSizeY() : int;
      
      function get name() : String;
      
      function get tileSizeZ() : int;
      
      function get title() : String;
      
      function get type() : String;
      
      function get id() : int;
      
      function get description() : String;
   }
}
