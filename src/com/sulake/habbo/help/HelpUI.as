package com.sulake.habbo.help
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.help.cfh.CallForHelpPendingItemView;
   import com.sulake.habbo.help.cfh.CallForHelpReportUserSelection;
   import com.sulake.habbo.help.cfh.CallForHelpSentView;
   import com.sulake.habbo.help.cfh.CallForHelpTextInput;
   import com.sulake.habbo.help.cfh.CallForHelpTopicSelection;
   import com.sulake.habbo.help.enum.CallForHelpResultEnum;
   import com.sulake.habbo.help.enum.HabboHelpTrackingEvent;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.FaqBrowseCategoryView;
   import com.sulake.habbo.help.help.FaqBrowseEntry;
   import com.sulake.habbo.help.help.FaqBrowseSearchResults;
   import com.sulake.habbo.help.help.FaqBrowseTopView;
   import com.sulake.habbo.help.help.HelpMainView;
   import com.sulake.habbo.help.help.PlaceholderView;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class HelpUI
   {
      
      private static const const_1306:int = 0;
      
      private static const const_1307:int = 0;
       
      
      private var var_1342:int = 0;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _window:IWindowContainer;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1746:Boolean = false;
      
      private var var_363:IWindowContainer;
      
      private var var_497:Array;
      
      private var var_113:Map;
      
      private var var_198:IHabboToolbar;
      
      private var var_1745:String = "HHVE_HELP_FRONTPAGE";
      
      private var var_1343:int = 0;
      
      private var var_1747:String = "";
      
      private var var_498:Array;
      
      private var var_246:String;
      
      private var var_90:HabboHelp;
      
      public function HelpUI(param1:HabboHelp, param2:IAssetLibrary, param3:IHabboWindowManager, param4:IHabboLocalizationManager, param5:IHabboToolbar)
      {
         var_246 = var_1745;
         var_498 = new Array();
         var_497 = new Array();
         super();
         var_90 = param1;
         _assetLibrary = param2;
         _windowManager = param3;
         _windowManager.registerLocalizationParameter("info.client.version","version","22643-22891-200911110010");
         var_198 = param5;
         var_113 = new Map();
         var_113.add(HabboHelpViewEnum.const_1137,IHelpViewController(new PlaceholderView(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_129,IHelpViewController(new HelpMainView(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_411,IHelpViewController(new FaqBrowseTopView(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_230,IHelpViewController(new FaqBrowseCategoryView(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_188,IHelpViewController(new FaqBrowseEntry(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_663,IHelpViewController(new FaqBrowseSearchResults(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_293,IHelpViewController(new CallForHelpTopicSelection(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_504,IHelpViewController(new CallForHelpTextInput(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_202,IHelpViewController(new CallForHelpSentView(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_864,IHelpViewController(new CallForHelpPendingItemView(this,_windowManager,_assetLibrary)));
         var_113.add(HabboHelpViewEnum.const_675,IHelpViewController(new CallForHelpReportUserSelection(this,_windowManager,_assetLibrary)));
      }
      
      public function tellUI(param1:String, param2:* = null) : void
      {
         if(var_246 != param1)
         {
            return;
         }
         var _loc3_:IHelpViewController = getViewController();
         if(_loc3_ != null)
         {
            _loc3_.update(param2);
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:ICoreWindowManager = ICoreWindowManager(_windowManager);
         var _loc2_:XmlAsset = XmlAsset(_assetLibrary.getAssetByName("help_frame_xml"));
         if(_loc2_ == null)
         {
            return;
         }
         _window = _loc1_.buildFromXML(XML(_loc2_.content)) as IWindowContainer;
         if(_window == null)
         {
            return;
         }
         _window.procedure = windowProcedure;
         var _loc3_:IItemListWindow = _window.findChildByName("content_list") as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var_1342 = 0 - _loc3_.width;
         var_1343 = _window.height;
      }
      
      private function addBackButtonWindow() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(var_246 == HabboHelpViewEnum.const_129 || false)
         {
            return;
         }
         if(var_363 == null)
         {
            _loc2_ = ICoreWindowManager(_windowManager);
            _loc3_ = XmlAsset(_assetLibrary.getAssetByName("help_back_button_xml"));
            if(_loc3_ == null)
            {
               return;
            }
            var_363 = _loc2_.buildFromXML(XML(_loc3_.content)) as IWindowContainer;
         }
         var _loc1_:IItemListWindow = _window.findChildByName("content_list") as IItemListWindow;
         if(_loc1_ == null || var_363 == null)
         {
            return;
         }
         if(_loc1_.getListItemIndex(var_363 as IWindow) > -1)
         {
            return;
         }
         _loc1_.addListItem(var_363 as IWindow);
         setBackButtonActiveState(false);
      }
      
      public function get lastSearchString() : String
      {
         return var_1747;
      }
      
      private function getViewController() : IHelpViewController
      {
         return var_113.getValue(var_246);
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return var_90.localization;
      }
      
      private function removeCurrentView() : void
      {
         var _loc2_:* = null;
         if(_window != null)
         {
            _loc2_ = _window.findChildByName("content_list") as IItemListWindow;
            if(_loc2_ != null)
            {
               while(_loc2_.numListItems > 1)
               {
                  _loc2_.getListItemAt(0).dispose();
                  _loc2_.removeListItemAt(0);
               }
            }
         }
         var _loc1_:IHelpViewController = getViewController();
         if(_loc1_ != null)
         {
            _loc1_.dispose();
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc1_:Array = var_113.getKeys();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = var_113.getValue(_loc3_) as IHelpViewController;
            if(_loc4_ != null)
            {
               _loc4_.dispose();
            }
            _loc2_++;
         }
         var_113.dispose();
         if(var_363 != null)
         {
            var_363.dispose();
            var_363 = null;
         }
      }
      
      public function updateCallForGuideBotUI(param1:Boolean) : void
      {
         var_1746 = param1;
         var _loc2_:IHelpViewController = var_113.getValue(HabboHelpViewEnum.const_129) as IHelpViewController;
         if(_loc2_ != null && !_loc2_.disposed)
         {
            _loc2_.update();
         }
      }
      
      public function getText(param1:String, param2:String = null) : String
      {
         if(param2 == null)
         {
            param2 = param1;
         }
         return localization.getKey(param1,param2);
      }
      
      public function showCallForHelpResult(param1:String) : void
      {
         switch(param1)
         {
            case CallForHelpResultEnum.const_202:
               showUI(HabboHelpViewEnum.const_202);
               break;
            case CallForHelpResultEnum.const_937:
               showUI(HabboHelpViewEnum.const_864);
         }
      }
      
      public function set lastSearchString(param1:String) : void
      {
         var_1747 = param1;
      }
      
      private function setBackButtonActiveState(param1:Boolean = false) : void
      {
         var _loc3_:* = null;
         if(var_246 == HabboHelpViewEnum.const_129)
         {
            return;
         }
         if(true)
         {
            _loc3_ = _assetLibrary.getAssetByName("back_png") as BitmapDataAsset;
            var_497.push(_loc3_.content as BitmapData);
            _loc3_ = _assetLibrary.getAssetByName("back_hi_png") as BitmapDataAsset;
            var_497.push(_loc3_.content as BitmapData);
         }
         var _loc2_:IBitmapWrapperWindow = var_363.findChildByName("back_image") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true);
         if(param1)
         {
            _loc2_.bitmap.copyPixels(var_497[1],var_497[1].rect,new Point(0,0));
         }
         else
         {
            _loc2_.bitmap.copyPixels(var_497[0],var_497[0].rect,new Point(0,0));
         }
      }
      
      public function get marginWidth() : int
      {
         return var_1342;
      }
      
      public function updateWindowDimensions() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:IItemListWindow = _window.findChildByName("content_list") as IItemListWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _window.height = _loc1_.height + var_1343;
         _window.width = _loc1_.width + var_1342;
      }
      
      public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param1.type)
         {
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
               if(param2.tags.indexOf("close") > -1)
               {
                  hideUI();
                  return;
               }
               if(param2.tags.indexOf("back") > -1)
               {
                  if(false)
                  {
                     showUI(var_498.pop(),false);
                  }
                  return;
               }
               break;
            case WindowMouseEvent.const_29:
               if(param2.tags.indexOf("back_image") > -1)
               {
                  setBackButtonActiveState(false);
                  return;
               }
               break;
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
               if(param2.tags.indexOf("back_image") > -1)
               {
                  setBackButtonActiveState(true);
                  return;
               }
               break;
         }
      }
      
      public function setRoomSessionStatus(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_113.length)
         {
            _loc3_ = var_113.getWithIndex(_loc2_) as IHelpViewController;
            if(_loc3_ != null)
            {
               _loc3_.roomSessionActive = param1;
               if(!_loc3_.disposed)
               {
                  _loc3_.update();
               }
            }
            _loc2_++;
         }
      }
      
      public function showUI(param1:String = null, param2:Boolean = true) : void
      {
         if(param1 == null)
         {
            param1 = var_246;
         }
         var _loc3_:* = !visible;
         if(_window == null)
         {
            createWindow();
            if(_window == null)
            {
               return;
            }
            _window.visible = true;
         }
         else
         {
            removeCurrentView();
         }
         if(param1 == var_1745)
         {
            var_498 = new Array();
         }
         else if(param2)
         {
            if(param1 != var_246)
            {
               var_498.push(var_246);
            }
         }
         var_246 = param1;
         var _loc4_:IHelpViewController = getViewController();
         if(_loc4_ == null)
         {
            Logger.log("* No view controller found for " + var_246);
            return;
         }
         var _loc5_:IWindowContainer = _window.findChildByName("content_area") as IWindowContainer;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc6_:IItemListWindow = _window.findChildByName("content_list") as IItemListWindow;
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.height = 0;
         _loc4_.render();
         var _loc7_:IWindow = _loc4_.getWindowContainer() as IWindow;
         if(_loc7_ != null)
         {
            _loc6_.addListItemAt(_loc7_,0);
         }
         addBackButtonWindow();
         updateWindowDimensions();
         if(_loc3_)
         {
            if(var_198 != null)
            {
               var_198.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_74,HabboToolbarIconEnum.HELP,_window));
            }
         }
         var_90.events.dispatchEvent(new Event(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT));
      }
      
      public function isCallForGuideBotEnabled() : Boolean
      {
         return var_1746;
      }
      
      public function hideUI() : void
      {
         if(_window != null)
         {
            removeCurrentView();
            _window.dispose();
            _window = null;
         }
         var_246 = var_1745;
         var_90.events.dispatchEvent(new Event(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED));
      }
      
      public function sendMessage(param1:IMessageComposer) : void
      {
         var_90.sendMessage(param1);
      }
      
      public function getFaq() : FaqIndex
      {
         return var_90.getFaq();
      }
      
      public function toggleUI() : void
      {
         if(_window != null && false)
         {
            hideUI();
         }
         else
         {
            showUI();
         }
      }
      
      public function get visible() : Boolean
      {
         if(_window == null)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function get marginHeight() : int
      {
         return var_1343;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function showCallForHelpReply(param1:String) : void
      {
         var message:String = param1;
         _windowManager.alert("${help.cfh.reply.title}",message,0,function(param1:IAlertDialog, param2:Event):void
         {
            param1.dispose();
         });
      }
      
      public function get component() : HabboHelp
      {
         return var_90;
      }
      
      public function getConfigurationKey(param1:String, param2:String = null, param3:Dictionary = null) : String
      {
         return var_90.getConfigurationKey(param1,param2,param3);
      }
   }
}
