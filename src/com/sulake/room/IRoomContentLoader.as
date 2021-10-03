package com.sulake.room
{
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import flash.events.IEventDispatcher;
   
   public interface IRoomContentLoader
   {
       
      
      function hasInternalContent(param1:String) : Boolean;
      
      function getPlaceHolderTypes() : Array;
      
      function getContentType(param1:String) : String;
      
      function getVisualizationType(param1:String) : String;
      
      function getVisualizationXML(param1:String) : XML;
      
      function getLogicXML(param1:String) : XML;
      
      function getLogicType(param1:String) : String;
      
      function loadObjectContent(param1:String, param2:IEventDispatcher) : Boolean;
      
      function getPlaceHolderType(param1:String) : String;
      
      function getGraphicAssetCollection(param1:String) : IGraphicAssetCollection;
      
      function getAssetXML(param1:String) : XML;
      
      function dispose() : void;
   }
}
