package com.sulake.habbo.notifications
{
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class HabboAlertDialogManager
   {
       
      
      private var _localization:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      public function HabboAlertDialogManager(param1:IHabboWindowManager, param2:IHabboLocalizationManager)
      {
         super();
         _windowManager = param1;
         _localization = param2;
      }
      
      public function handleLoginFailedHotelClosedMessage(param1:int, param2:int) : void
      {
         var openHour:int = param1;
         var openMinute:int = param2;
         _localization.registerParameter("opening.hours.disconnected","h",getTimeZeroPadded(openHour));
         _localization.registerParameter("opening.hours.disconnected","m",getTimeZeroPadded(openMinute));
         _windowManager.alert("${opening.hours.title}","${opening.hours.disconnected}",0,function(param1:IAlertDialog, param2:Event):void
         {
            param1.dispose();
         });
      }
      
      public function handleHotelClosingMessage(param1:int) : void
      {
         var minutesUntilClosing:int = param1;
         _localization.registerParameter("opening.hours.shutdown","m",String(minutesUntilClosing));
         _windowManager.alert("${opening.hours.title}","${opening.hours.shutdown}",0,function(param1:IAlertDialog, param2:Event):void
         {
            param1.dispose();
         });
      }
      
      public function handleUserBannedMessage(param1:String) : void
      {
         var message:String = param1;
         _windowManager.alert("${mod.ban.title}",message,0,function(param1:IAlertDialog, param2:Event):void
         {
            param1.dispose();
         });
      }
      
      public function handleHotelClosedMessage(param1:int, param2:int, param3:Boolean) : void
      {
         var openHour:int = param1;
         var openMinute:int = param2;
         var userThrownOutAtClose:Boolean = param3;
         if(userThrownOutAtClose)
         {
            _localization.registerParameter("opening.hours.disconnected","h",getTimeZeroPadded(openHour));
            _localization.registerParameter("opening.hours.disconnected","m",getTimeZeroPadded(openMinute));
            _windowManager.alert("${opening.hours.title}","${opening.hours.disconnected}",0,function(param1:IAlertDialog, param2:Event):void
            {
               param1.dispose();
            });
         }
         else
         {
            _localization.registerParameter("opening.hours.closed","h",getTimeZeroPadded(openHour));
            _localization.registerParameter("opening.hours.closed","m",getTimeZeroPadded(openMinute));
            _windowManager.alert("${opening.hours.title}","${opening.hours.closed}",0,function(param1:IAlertDialog, param2:Event):void
            {
               param1.dispose();
            });
         }
      }
      
      private function getTimeZeroPadded(param1:int) : String
      {
         var _loc2_:String = "0" + String(param1);
         return _loc2_.substr(_loc2_.length - 2,_loc2_.length);
      }
      
      public function handleModMessage(param1:String, param2:String = "") : void
      {
         var message:String = param1;
         var url:String = param2;
         var p:RegExp = /\\r/g;
         message = message.replace(p,"\r");
         if(url.length > 0)
         {
            _windowManager.alertWithLink("${mod.alert.title}",message,"${mod.alert.link}",url,0,function(param1:IAlertDialog, param2:Event):void
            {
               param1.dispose();
            });
         }
         else
         {
            _windowManager.alert("${mod.alert.title}",message,0,function(param1:IAlertDialog, param2:Event):void
            {
               param1.dispose();
            });
         }
      }
      
      public function dispose() : void
      {
         _windowManager = null;
         _localization = null;
      }
   }
}
