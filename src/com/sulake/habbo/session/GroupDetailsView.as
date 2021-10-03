package com.sulake.habbo.session
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class GroupDetailsView
   {
       
      
      private var var_2026:int = -1;
      
      private var var_157:IWindowContainer;
      
      private var _sessionManager:SessionDataManager;
      
      public function GroupDetailsView(param1:SessionDataManager)
      {
         super();
         _sessionManager = param1;
      }
      
      public function showGroupDetails(param1:int) : void
      {
         var_2026 = param1;
         showGroupInfoDialog(param1);
      }
      
      private function onExternalLink(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
      }
      
      private function openExternalLink(param1:String) : void
      {
         if(param1 != "")
         {
            _sessionManager.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
            navigateToURL(new URLRequest(param1),"_empty");
         }
      }
      
      private function showGroupInfoDialog(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(true)
         {
            return;
         }
         var _loc2_:HabboGroupDetails = _sessionManager.getGroupDetails(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(var_157 == null)
         {
            _loc3_ = _sessionManager.assets.getAssetByName("group_info") as XmlAsset;
            if(_loc3_ != null)
            {
               var_157 = _sessionManager.windowManager.createWindow("habbo_group_details_window","${group.window.title}",HabboWindowType.const_289,HabboWindowStyle.const_37,0 | 0,new Rectangle(10,10,300,220),null) as IWindowContainer;
               var_157.buildFromXML(_loc3_.content as XML) as IWindowContainer;
               _loc4_ = var_157.findChildByTag("close");
               if(_loc4_ != null)
               {
                  _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onGroupDetailsEvents);
               }
               _loc5_ = ["group_homepage_link","group_room_link"];
               for each(_loc6_ in _loc5_)
               {
                  _loc7_ = var_157.findChildByName(_loc6_);
                  if(_loc7_ != null)
                  {
                     _loc7_.alphaTreshold = 0;
                     _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onGroupDetailsEvents);
                  }
               }
            }
         }
         if(var_157 != null)
         {
            var_157.visible = true;
            var_157.center();
            var_157.findChildByName("group_name").caption = _loc2_.name;
            var_157.findChildByName("group_description").caption = _loc2_.description;
            if(_loc2_.roomId < 0)
            {
               var_157.findChildByName("group_room_link").visible = false;
            }
            else
            {
               var_157.findChildByName("group_room_link").visible = true;
            }
            _sessionManager.windowManager.registerLocalizationParameter("group.room.link","room_name",_loc2_.roomName);
            _loc8_ = var_157.findChildByName("group_logo") as IBitmapWrapperWindow;
            if(_loc8_ != null)
            {
               _loc9_ = _sessionManager.getGroupBadgeImage(_sessionManager.getGroupBadgeId(_loc2_.id));
               if(_loc9_ != null)
               {
                  _loc8_.bitmap = _loc9_.clone();
                  _loc8_.width = _loc9_.width;
                  _loc8_.height = _loc9_.height;
               }
            }
         }
         else
         {
            _sessionManager.windowManager.alert(_loc2_.name,_loc2_.description,0,alertDialogEventProcessor);
         }
      }
      
      private function onGroupDetailsEvents(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:HabboGroupDetails = _sessionManager.getGroupDetails(var_2026);
         switch(_loc2_.name)
         {
            case "group_homepage_link":
               if(_loc3_ != null)
               {
                  _loc4_ = _sessionManager.configuration.getKey("group.homepage.url","http://%predefined%/groups/%groupid%/id");
                  _loc4_ = _loc4_.replace("%groupid%",_loc3_.id);
                  openExternalLink(_loc4_);
               }
               break;
            case "group_room_link":
               if(_loc3_ != null)
               {
                  _sessionManager.roomSessionManager.gotoRoom(false,_loc3_.roomId);
                  if(var_157 != null)
                  {
                     var_157.visible = false;
                  }
               }
               break;
            case "close":
            case "header_button_close":
               if(var_157 != null)
               {
                  var_157.visible = false;
               }
               break;
            default:
               Logger.log("Group link unknown: " + _loc2_.name);
         }
      }
      
      private function alertDialogEventProcessor(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
      }
   }
}
