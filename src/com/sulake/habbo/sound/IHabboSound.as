package com.sulake.habbo.sound
{
   public interface IHabboSound
   {
       
      
      function stop() : Boolean;
      
      function set position(param1:Number) : void;
      
      function get ready() : Boolean;
      
      function set volume(param1:Number) : void;
      
      function get length() : Number;
      
      function get position() : Number;
      
      function get volume() : Number;
      
      function play() : Boolean;
      
      function get finished() : Boolean;
   }
}
