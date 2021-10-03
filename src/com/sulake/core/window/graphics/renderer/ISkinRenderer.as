package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindow;
   import flash.display.IBitmapDrawable;
   import flash.geom.Rectangle;
   
   public interface ISkinRenderer
   {
       
      
      function getLayoutByName(param1:String) : ISkinLayout;
      
      function removeLayoutFromRenderState(param1:uint) : void;
      
      function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean) : void;
      
      function isStateDrawable(param1:uint) : Boolean;
      
      function registerLayoutForRenderState(param1:uint, param2:String) : void;
      
      function getTemplateByState(param1:uint) : ISkinTemplate;
      
      function addLayout(param1:ISkinLayout) : ISkinLayout;
      
      function hasLayoutForState(param1:uint) : Boolean;
      
      function removeLayout(param1:ISkinLayout) : ISkinLayout;
      
      function registerTemplateForRenderState(param1:uint, param2:String) : void;
      
      function getTemplateByName(param1:String) : ISkinTemplate;
      
      function removeTemplateFromRenderState(param1:uint) : void;
      
      function getLayoutByState(param1:uint) : ISkinLayout;
      
      function addTemplate(param1:ISkinTemplate) : ISkinTemplate;
      
      function hasTemplateForState(param1:uint) : Boolean;
      
      function removeTemplate(param1:ISkinTemplate) : ISkinTemplate;
      
      function dispose() : void;
   }
}
