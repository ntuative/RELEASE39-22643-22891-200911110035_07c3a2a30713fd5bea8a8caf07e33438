package com.sulake.room.object.visualization
{
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   
   public interface IRoomObjectGraphicVisualization extends IRoomObjectVisualization
   {
       
      
      function set assetCollection(param1:IGraphicAssetCollection) : void;
      
      function get assetCollection() : IGraphicAssetCollection;
   }
}
