package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   
   public interface IAvatarEditorCategoryModel
   {
       
      
      function categorySwitch(param1:String) : void;
      
      function toggleColourSelection(param1:String, param2:int) : void;
      
      function toggleItemSelection(param1:String, param2:int) : void;
      
      function getCategoryContent(param1:String) : CategoryData;
      
      function dispose() : void;
      
      function closingEditorView() : void;
      
      function getWindowContainer() : IWindowContainer;
      
      function get method_1() : HabboAvatarEditor;
      
      function updateView() : void;
      
      function reset() : void;
   }
}
