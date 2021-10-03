package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.IAsset;
   
   public interface IGraphicAsset
   {
       
      
      function get asset() : IAsset;
      
      function get flipH() : Boolean;
      
      function get offsetX() : int;
      
      function get offsetY() : int;
      
      function get flipV() : Boolean;
      
      function get name() : String;
   }
}
