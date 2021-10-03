package com.sulake.core.window
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.utils.IRectLimiter;
   import flash.display.IBitmapDrawable;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public interface IWindow extends IEventDispatcher, IDisposable
   {
       
      
      function get y() : int;
      
      function getAbsoluteMousePosition(param1:Point) : void;
      
      function setStyleFlag(param1:uint, param2:Boolean = true) : void;
      
      function enable() : Boolean;
      
      function set clipping(param1:Boolean) : void;
      
      function getLocalPosition(param1:Point) : void;
      
      function getDrawRegion(param1:Rectangle) : void;
      
      function destroy() : Boolean;
      
      function hitTestLocalPoint(param1:Point) : Boolean;
      
      function get name() : String;
      
      function set width(param1:int) : void;
      
      function get param() : uint;
      
      function hitTestGlobalRectangle(param1:Rectangle) : Boolean;
      
      function getParamFlag(param1:uint) : Boolean;
      
      function get state() : uint;
      
      function maximize() : Boolean;
      
      function offset(param1:Number, param2:Number) : void;
      
      function restore() : Boolean;
      
      function set name(param1:String) : void;
      
      function get limits() : IRectLimiter;
      
      function get tags() : Array;
      
      function get id() : uint;
      
      function get desktop() : IDesktopWindow;
      
      function minimize() : Boolean;
      
      function getStyleFlag(param1:uint) : Boolean;
      
      function disable() : Boolean;
      
      function set blend(param1:Number) : void;
      
      function findParentByName(param1:String) : IWindow;
      
      function set procedure(param1:Function) : void;
      
      function get height() : int;
      
      function get host() : IWindow;
      
      function get position() : Point;
      
      function get parent() : IWindow;
      
      function testStateFlag(param1:uint, param2:uint = 0) : Boolean;
      
      function set debug(param1:Boolean) : void;
      
      function get background() : Boolean;
      
      function get context() : IWindowContext;
      
      function get style() : uint;
      
      function lock() : Boolean;
      
      function get properties() : Array;
      
      function set id(param1:uint) : void;
      
      function hitTestGlobalPoint(param1:Point) : Boolean;
      
      function get type() : uint;
      
      function invalidate(param1:Rectangle = null) : void;
      
      function hitTestLocalRectangle(param1:Rectangle) : Boolean;
      
      function buildFromXML(param1:XML, param2:Map = null) : Boolean;
      
      function convertPointFromGlobalToLocalSpace(param1:Point) : void;
      
      function getLocalRectangle(param1:Rectangle) : void;
      
      function get clipping() : Boolean;
      
      function getMouseRegion(param1:Rectangle) : void;
      
      function convertPointFromLocalToGlobalSpace(param1:Point) : void;
      
      function get width() : int;
      
      function testParamFlag(param1:uint, param2:uint = 0) : Boolean;
      
      function scale(param1:Number, param2:Number) : void;
      
      function testStyleFlag(param1:uint, param2:uint = 0) : Boolean;
      
      function set caption(param1:String) : void;
      
      function set color(param1:uint) : void;
      
      function set height(param1:int) : void;
      
      function get blend() : Number;
      
      function set position(param1:Point) : void;
      
      function get debug() : Boolean;
      
      function set parent(param1:IWindow) : void;
      
      function center() : void;
      
      function getGlobalRectangle(param1:Rectangle) : void;
      
      function setParamFlag(param1:uint, param2:Boolean = true) : void;
      
      function set alphaTreshold(param1:uint) : void;
      
      function get procedure() : Function;
      
      function getRelativeMousePosition(param1:Point) : void;
      
      function set background(param1:Boolean) : void;
      
      function clone() : IWindow;
      
      function set rectangle(param1:Rectangle) : void;
      
      function set style(param1:uint) : void;
      
      function get color() : uint;
      
      function set visible(param1:Boolean) : void;
      
      function get caption() : String;
      
      function getStateFlag(param1:uint) : Boolean;
      
      function resolveVerticalScale() : Number;
      
      function get alphaTreshold() : uint;
      
      function setStateFlag(param1:uint, param2:Boolean = true) : void;
      
      function resolve() : uint;
      
      function set properties(param1:Array) : void;
      
      function setGlobalPosition(param1:Point) : void;
      
      function get rectangle() : Rectangle;
      
      function set x(param1:int) : void;
      
      function getGlobalPosition(param1:Point) : void;
      
      function set y(param1:int) : void;
      
      function activate() : Boolean;
      
      function deactivate() : Boolean;
      
      function set filters(param1:Array) : void;
      
      function setGlobalRectangle(param1:Rectangle) : void;
      
      function get x() : int;
      
      function get visible() : Boolean;
      
      function resolveHorizontalScale() : Number;
      
      function get filters() : Array;
      
      function unlock() : Boolean;
      
      function fetchDrawBuffer() : IBitmapDrawable;
   }
}
