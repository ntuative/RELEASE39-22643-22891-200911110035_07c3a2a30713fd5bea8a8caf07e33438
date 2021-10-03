package com.sulake.core.window.graphics
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   
   public interface ISkinContainer
   {
       
      
      function addSkinRenderer(param1:uint, param2:uint, param3:ISkinRenderer) : void;
      
      function getSkinRendererByType(param1:uint, param2:uint) : ISkinRenderer;
      
      function getTheActualState(param1:uint, param2:uint, param3:uint) : uint;
      
      function get assets() : IAssetLibrary;
      
      function dispose() : void;
   }
}
