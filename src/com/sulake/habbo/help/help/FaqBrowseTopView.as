package com.sulake.habbo.help.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GetFaqCategoriesMessageComposer;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.help.SearchViewController;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.data.FaqCategory;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class FaqBrowseTopView extends SearchViewController implements IHelpViewController
   {
       
      
      public function FaqBrowseTopView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
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
      
      override public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "back":
               main.showUI(HabboHelpViewEnum.const_129);
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
         var _loc1_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         _loc1_ = main.getFaq();
         if(_loc1_ == null)
         {
            return;
         }
         if(container != null)
         {
            container.dispose();
         }
         disposed = false;
         container = buildXmlWindow("help_faq_categories") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         container.procedure = windowProcedure;
         if(_loc1_.getCategoryCount() == 0)
         {
            main.sendMessage(new GetFaqCategoriesMessageComposer());
            return;
         }
         var _loc2_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.destroyListItems();
         var _loc3_:String = "";
         var _loc4_:Array = _loc1_.getCategoryTitleArray();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = "#" + _loc5_ + " .. " + _loc4_[_loc5_];
            _loc3_ = _loc3_ + _loc6_ + String.fromCharCode(13);
            _loc7_ = buildListEntryItem(_loc6_,windowProcedure) as IWindow;
            if(_loc2_ != null && _loc7_ != null)
            {
               _loc7_.name = "list_entry";
               _loc2_.addListItem(_loc7_);
            }
            _loc5_++;
         }
         super.render();
      }
      
      private function handleListItemClick(param1:IWindow) : void
      {
         var _loc2_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(_loc2_ == null || param1 == null || param1.parent == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.getListItemIndex(param1.parent);
         var _loc4_:FaqIndex = main.getFaq();
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:FaqCategory = _loc4_.getCategoryByIndex(_loc3_);
         if(_loc5_ == null)
         {
            return;
         }
         main.showUI(HabboHelpViewEnum.const_230);
         main.tellUI(HabboHelpViewEnum.const_230,_loc5_);
      }
   }
}
