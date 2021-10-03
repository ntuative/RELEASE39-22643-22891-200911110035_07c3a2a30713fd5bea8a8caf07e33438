package com.sulake.habbo.help.cfh
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.help.HelpUI;
   import com.sulake.habbo.help.HelpViewController;
   import com.sulake.habbo.help.cfh.data.UserRegistryItem;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class CallForHelpReportUserSelection extends HelpViewController
   {
       
      
      private var var_513:Map;
      
      public function CallForHelpReportUserSelection(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         var_513 = new Map();
         super(param1,param2,param3);
      }
      
      override public function update(param1:* = null) : void
      {
         var t:String = null;
         var u:UserRegistryItem = null;
         var item:IWindowContainer = null;
         var parameter:* = param1;
         super.update();
         if(disposed)
         {
            return;
         }
         if(container == null)
         {
            return;
         }
         var content:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(content == null)
         {
            return;
         }
         while(content.numListItems > 0)
         {
            content.removeListItemAt(0);
         }
         var_513 = main.component.userRegistry.getRegistry();
         if(false)
         {
            main.showUI(HabboHelpViewEnum.const_129);
            windowManager.alert("${generic.alert.title}","${report.user.error.nolist}",0,function(param1:IAlertDialog, param2:Event):void
            {
               param1.dispose();
            });
            return;
         }
         var i:int = 0;
         while(i < var_513.length)
         {
            u = var_513.getWithIndex(i);
            t = u.userName + "/" + u.roomName;
            main.localization.registerParameter("report.user.list.entry","name",u.userName);
            main.localization.registerParameter("report.user.list.entry","room",u.roomName);
            t = getText("report.user.list.entry");
            item = buildListEntryItem(t,windowProcedure);
            if(item != null)
            {
               content.addListItem(item);
            }
            i++;
         }
      }
      
      override public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "item_bg":
               handleListItemClick(param2);
         }
      }
      
      private function buildListEntryItem(param1:String, param2:Function = null) : IWindowContainer
      {
         var _loc3_:IWindowContainer = buildXmlWindow("report_user_pick_user_item") as IWindowContainer;
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
      
      override public function render() : void
      {
         super.render();
         if(container != null)
         {
            container.dispose();
         }
         container = buildXmlWindow("report_user_pick_user") as IWindowContainer;
         update();
         if(container == null)
         {
            return;
         }
         container.procedure = windowProcedure;
      }
      
      private function handleListItemClick(param1:IWindow) : void
      {
         var _loc2_:IItemListWindow = container.findChildByTag("content") as IItemListWindow;
         if(_loc2_ == null || param1 == null || param1.parent == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.getListItemIndex(param1.parent);
         if(_loc3_ < 0 || _loc3_ > var_513.length)
         {
            return;
         }
         var _loc4_:UserRegistryItem = var_513.getWithIndex(_loc3_);
         if(_loc4_ == null)
         {
            return;
         }
         main.component.callForHelpData.reportedUserId = _loc4_.userId;
         main.component.callForHelpData.reportedUserName = _loc4_.userName;
         if(_loc3_ > -1)
         {
            main.showUI(HabboHelpViewEnum.const_293);
         }
      }
   }
}
