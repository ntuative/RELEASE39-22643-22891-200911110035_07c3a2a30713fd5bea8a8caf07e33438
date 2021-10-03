package com.sulake.habbo.help.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class FaqBrowseSearchResults extends FaqBrowseCategoryView implements IHelpViewController
   {
       
      
      public function FaqBrowseSearchResults(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function update(param1:* = null) : void
      {
         var _loc2_:* = null;
         super.update(param1);
         if(container != null)
         {
            _loc2_ = container.findChildByName("help_faq_search_input") as ITextFieldWindow;
            if(_loc2_ != null)
            {
               _loc2_.text = main.lastSearchString;
            }
         }
      }
      
      override public function render() : void
      {
         super.render();
      }
   }
}
