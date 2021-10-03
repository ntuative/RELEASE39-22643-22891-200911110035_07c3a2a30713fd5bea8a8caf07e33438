package com.sulake.habbo.help.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GetClientFaqsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.CallGuideBotMessageComposer;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.IHelpViewController;
   import com.sulake.habbo.help.SearchViewController;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.data.FaqCategory;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.help.help.data.FaqItem;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HelpMainView extends SearchViewController implements IHelpViewController
   {
      
      private static const const_1022:int = 60;
       
      
      public function HelpMainView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override public function update(param1:* = null) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         super.update(param1);
         if(container == null)
         {
            return;
         }
         var _loc2_:IWindow = container.findChildByName("help_cfh");
         if(_loc2_ != null)
         {
            _loc2_.visible = roomSessionActive;
         }
         var _loc3_:IWindow = container.findChildByName("help_report_user");
         if(_loc3_ != null)
         {
            _loc3_.visible = roomSessionActive;
         }
         var _loc4_:IWindow = container.findChildByName("call_guide_bot_container");
         if(_loc4_ != null)
         {
            _loc4_.visible = main.isCallForGuideBotEnabled() && roomSessionActive;
         }
         var _loc5_:FaqIndex = main.getFaq();
         if(_loc5_ != null)
         {
            _loc10_ = _loc5_.getFrontPageUrgentCategory().getQuestionTitleArray();
            _loc7_ = container.findChildByTag("content_urgent") as IItemListWindow;
            if(_loc7_ != null)
            {
               _loc7_.destroyListItems();
               _loc8_ = 0;
               while(_loc8_ < _loc10_.length)
               {
                  _loc11_ = _loc10_[_loc8_];
                  _loc9_ = buildListEntryItem(_loc11_,"help_itemlist_item_urgent",windowProcedure);
                  if(_loc9_ != null)
                  {
                     _loc9_.name = "content_urgent_item";
                     _loc7_.addListItem(_loc9_);
                  }
                  _loc8_++;
               }
            }
            _loc10_ = _loc5_.getFrontPageNormalCategory().getQuestionTitleArray();
            _loc7_ = container.findChildByTag("content_normal") as IItemListWindow;
            if(_loc7_ != null)
            {
               _loc7_.destroyListItems();
               _loc8_ = 0;
               while(_loc8_ < _loc10_.length)
               {
                  _loc11_ = _loc10_[_loc8_];
                  _loc9_ = buildListEntryItem(_loc11_,"help_itemlist_item_white_bg",windowProcedure);
                  if(_loc9_ != null)
                  {
                     _loc9_.name = "content_normal_item";
                     _loc7_.addListItem(_loc9_);
                  }
                  _loc8_++;
               }
            }
         }
         var _loc6_:IItemListWindow = container.findChildByName("help_itemlist") as IItemListWindow;
         _loc6_.arrangeListItems();
         main.updateWindowDimensions();
      }
      
      private function openWebPage(param1:String) : void
      {
         var key:String = param1;
         var urlString:String = getConfigurationKey(key,key);
         try
         {
            navigateToURL(new URLRequest(urlString),"habboMain");
         }
         catch(e:Error)
         {
            Logger.log("Error occurred!");
         }
      }
      
      override public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("* HELP Main view windowEventProc " + param1.type + "/" + param2.name);
         switch(param2.name)
         {
            case "help_faq_browse":
               main.showUI(HabboHelpViewEnum.const_411);
               break;
            case "help_habboway":
            case "help_habboway_text":
               _loc3_ = main.getText("help.button.habboway.url","");
               if(_loc3_ != "")
               {
                  openWebPage(_loc3_);
               }
               break;
            case "help_cfh":
               main.component.callForHelpData.reportedUserId = 0;
               main.showUI(HabboHelpViewEnum.const_293);
               break;
            case "help_report_user":
               main.component.callForHelpData.reportedUserId = 0;
               main.showUI(HabboHelpViewEnum.const_675);
            case "item_bg":
               handleListItemClick(param2);
               break;
            case "call_guide_bot":
               handleCallGuideBot();
               break;
            default:
               super.windowProcedure(param1,param2);
         }
      }
      
      private function buildListEntryItem(param1:String, param2:String, param3:Function = null) : IWindowContainer
      {
         var _loc4_:IWindowContainer = buildXmlWindow(param2) as IWindowContainer;
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc5_:ITextWindow = _loc4_.findChildByTag("text") as ITextWindow;
         if(_loc5_ == null)
         {
            return null;
         }
         _loc5_.text = param1;
         if(param3 != null)
         {
            _loc4_.procedure = param3;
         }
         return _loc4_;
      }
      
      override public function render() : void
      {
         var _loc3_:* = null;
         container = buildXmlWindow("help_front_page") as IWindowContainer;
         if(container == null)
         {
            return;
         }
         container.procedure = windowProcedure;
         var _loc1_:FaqIndex = main.getFaq();
         if(_loc1_ == null || _loc1_.getFrontPageUrgentCategory().getAgeSeconds() > const_1022)
         {
            main.sendMessage(new GetClientFaqsMessageComposer());
         }
         var _loc2_:IBitmapWrapperWindow = container.findChildByName("guidebot_icon") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc3_ = assetLibrary.getAssetByName("guidebot_icon_png").content as BitmapData;
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true);
            _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
         }
         super.render();
         update();
      }
      
      private function handleCallGuideBot() : void
      {
         main.sendMessage(new CallGuideBotMessageComposer());
         main.hideUI();
      }
      
      private function handleListItemClick(param1:IWindow) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:FaqIndex = main.getFaq();
         if(_loc2_ == null || param1 == null || param1.parent == null)
         {
            return;
         }
         if(param1.parent.name.indexOf("normal") > -1)
         {
            _loc4_ = container.findChildByTag("content_normal") as IItemListWindow;
            _loc3_ = _loc2_.getFrontPageNormalCategory();
         }
         else
         {
            _loc4_ = container.findChildByTag("content_urgent") as IItemListWindow;
            _loc3_ = _loc2_.getFrontPageUrgentCategory();
         }
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:int = _loc4_.getListItemIndex(param1.parent);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:FaqItem = _loc3_.getItemByIndex(_loc5_);
         if(_loc6_ != null)
         {
            main.showUI(HabboHelpViewEnum.const_188);
            main.tellUI(HabboHelpViewEnum.const_188,_loc6_);
         }
      }
   }
}
