package com.sulake.habbo.help.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GetFaqCategoryMessageComposer;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.help.SearchViewController;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.data.FaqCategory;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.help.help.data.FaqItem;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class FaqBrowseCategoryView extends SearchViewController implements IHelpViewController
   {
       
      
      private var _category:FaqCategory;
      
      public function FaqBrowseCategoryView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "help_faq_back":
               main.showUI(HabboHelpViewEnum.const_411);
               break;
            case "item_bg":
               handleListItemClick(param2);
               break;
            default:
               super.windowProcedure(param1,param2);
         }
      }
      
      override public function render() : void
      {
         if(container != null)
         {
            container.dispose();
         }
         container = buildXmlWindow("help_faq_category") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         container.procedure = windowProcedure;
         super.render();
         if(_category != null)
         {
            update();
         }
      }
      
      private function buildListEntryItem(param1:String, param2:Function = null) : IWindowContainer
      {
         var _loc3_:IWindowContainer = buildXmlWindow("help_itemlist_item") as IWindowContainer;
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:ITextWindow = _loc3_.findChildByTag("text") as ITextWindow;
         if(_loc4_ == null)
         {
            return null;
         }
         _loc4_.text = param1;
         if(param2 != null)
         {
            _loc3_.procedure = param2;
         }
         return _loc3_;
      }
      
      override public function update(param1:* = null) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         super.update(param1);
         var _loc2_:FaqIndex = main.getFaq();
         if(param1 != null)
         {
            if(_loc2_ == null || container == null || param1 == null)
            {
               return;
            }
            _category = FaqCategory(param1);
         }
         if(_category == null)
         {
            return;
         }
         if(!_category.hasContent())
         {
            main.sendMessage(new GetFaqCategoryMessageComposer(_category.categoryId));
            return;
         }
         var _loc3_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.destroyListItems();
         var _loc4_:Array = _category.getQuestionTitleArray();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = buildListEntryItem(_loc6_,windowProcedure);
            if(_loc7_ != null)
            {
               _loc3_.addListItem(_loc7_);
            }
            _loc5_++;
         }
      }
      
      private function handleListItemClick(param1:IWindow) : void
      {
         var _loc2_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         var _loc3_:FaqIndex = main.getFaq();
         if(_loc3_ == null || _loc2_ == null || param1 == null || param1.parent == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.getListItemIndex(param1.parent);
         if(_category == null)
         {
            return;
         }
         var _loc5_:FaqItem = _category.getItemByIndex(_loc4_);
         if(_loc5_ != null)
         {
            main.showUI(HabboHelpViewEnum.const_188);
            main.tellUI(HabboHelpViewEnum.const_188,_loc5_);
         }
      }
   }
}
