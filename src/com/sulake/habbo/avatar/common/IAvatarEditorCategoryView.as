package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowContainer;
   
   public interface IAvatarEditorCategoryView
   {
       
      
      function getWindowContainer() : IWindowContainer;
      
      function dispose() : void;
   }
}
