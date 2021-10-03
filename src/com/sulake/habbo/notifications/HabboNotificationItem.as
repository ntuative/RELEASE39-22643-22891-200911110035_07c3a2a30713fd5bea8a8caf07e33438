package com.sulake.habbo.notifications
{
   public class HabboNotificationItem
   {
       
      
      private var var_85:HabboNotificationItemStyle;
      
      private var var_30:String;
      
      private var var_90:HabboNotifications;
      
      public function HabboNotificationItem(param1:String, param2:HabboNotificationItemStyle, param3:HabboNotifications)
      {
         super();
         var_30 = param1;
         var_85 = param2;
         var_90 = param3;
      }
      
      public function ExecuteUiLinks() : void
      {
         var _loc2_:* = null;
         var _loc1_:Array = var_85.componentLinks;
         for each(_loc2_ in _loc1_)
         {
            if(var_90 != null)
            {
               var_90.onExecuteLink(_loc2_);
            }
         }
      }
      
      public function get style() : HabboNotificationItemStyle
      {
         return var_85;
      }
      
      public function get content() : String
      {
         return var_30;
      }
   }
}
