package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.IDisposable;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public interface IGraphicContext extends IBitmapDrawable, IEventDispatcher, IDisposable
   {
       
      
      function getAbsoluteMousePosition(param1:Point) : void;
      
      function addChildContextAt(param1:IGraphicContext, param2:int) : IGraphicContext;
      
      function getRelativeMousePosition(param1:Point) : void;
      
      function swapChildContexts(param1:IGraphicContext, param2:IGraphicContext) : void;
      
      function getDrawRegion() : Rectangle;
      
      function get blend() : Number;
      
      function set parent(param1:DisplayObjectContainer) : void;
      
      function removeChildContext(param1:IGraphicContext) : IGraphicContext;
      
      function setDrawRegion(param1:Rectangle, param2:Boolean) : void;
      
      function setChildContextIndex(param1:IGraphicContext, param2:int) : void;
      
      function setDisplayObject(param1:DisplayObject) : DisplayObject;
      
      function swapChildContextsAt(param1:int, param2:int) : void;
      
      function set blend(param1:Number) : void;
      
      function set visible(param1:Boolean) : void;
      
      function showRedrawRegion(param1:Rectangle) : void;
      
      function getChildContextIndex(param1:IGraphicContext) : int;
      
      function get parent() : DisplayObjectContainer;
      
      function getDisplayObject() : DisplayObject;
      
      function removeChildContextAt(param1:int) : IGraphicContext;
      
      function get visible() : Boolean;
      
      function addChildContext(param1:IGraphicContext) : IGraphicContext;
      
      function set filters(param1:Array) : void;
      
      function get numChildContexts() : int;
      
      function get filters() : Array;
      
      function getChildContextAt(param1:int) : IGraphicContext;
      
      function fetchDrawBuffer() : IBitmapDrawable;
   }
}
