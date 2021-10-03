package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.avatar.structure.IFigureData;
   
   public interface IAvatarRenderManager extends IUnknown
   {
       
      
      function getFigureData(param1:String) : IFigureData;
      
      function createAvatarImage(param1:String, param2:String) : IAvatarImage;
      
      function createPetImage(param1:String, param2:String, param3:String) : IAvatarImage;
      
      function get assets() : IAssetLibrary;
      
      function getAssetByName(param1:String) : IAsset;
   }
}
