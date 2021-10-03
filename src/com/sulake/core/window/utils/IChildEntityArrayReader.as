package com.sulake.core.window.utils
{
   public interface IChildEntityArrayReader
   {
       
      
      function get numChildren() : int;
      
      function groupChildrenWithID(param1:uint, param2:Array) : uint;
      
      function getChildByID(param1:uint) : IChildEntity;
      
      function getChildAt(param1:int) : IChildEntity;
      
      function getChildIndex(param1:IChildEntity) : int;
      
      function getChildByTag(param1:String) : IChildEntity;
      
      function groupChildrenWithTag(param1:String, param2:Array) : uint;
      
      function getChildByName(param1:String) : IChildEntity;
   }
}
