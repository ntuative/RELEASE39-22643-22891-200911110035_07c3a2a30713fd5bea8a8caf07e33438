package com.sulake.core.window
{
   import com.sulake.core.window.utils.IIterable;
   import flash.geom.Point;
   
   public interface IWindowContainer extends IWindow, IIterable
   {
       
      
      function findChildByTag(param1:String) : IWindow;
      
      function groupChildrenUnderPoint(param1:Point, param2:Array) : void;
      
      function findChildByName(param1:String) : IWindow;
      
      function groupChildrenWithID(param1:uint, param2:Array, param3:Boolean = false) : uint;
      
      function setChildIndex(param1:IWindow, param2:int) : void;
      
      function getChildByName(param1:String) : IWindow;
      
      function removeChildAt(param1:int) : IWindow;
      
      function get numChildren() : int;
      
      function addChildAt(param1:IWindow, param2:int) : IWindow;
      
      function swapChildren(param1:IWindow, param2:IWindow) : void;
      
      function getChildIndex(param1:IWindow) : int;
      
      function swapChildrenAt(param1:int, param2:int) : void;
      
      function groupChildrenWithTag(param1:String, param2:Array, param3:Boolean = false) : uint;
      
      function removeChild(param1:IWindow) : IWindow;
      
      function getChildAt(param1:int) : IWindow;
      
      function addChild(param1:IWindow) : IWindow;
      
      function getChildByTag(param1:String) : IWindow;
      
      function getChildUnderPoint(param1:Point) : IWindow;
      
      function getChildByID(param1:uint) : IWindow;
   }
}
