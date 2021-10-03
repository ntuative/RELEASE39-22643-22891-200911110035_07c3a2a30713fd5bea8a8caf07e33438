package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
   
   public class HabboAchievementNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
       
      
      public function HabboAchievementNotificationMessageEvent(param1:Function)
      {
         super(param1,HabboAchievementNotificationMessageParser);
      }
      
      public function get type() : int
      {
         return (var_21 as HabboAchievementNotificationMessageParser).type;
      }
      
      public function get level() : int
      {
         return (var_21 as HabboAchievementNotificationMessageParser).level;
      }
      
      public function get removedBadgeID() : String
      {
         return (var_21 as HabboAchievementNotificationMessageParser).removedBadgeID;
      }
      
      public function get badgeID() : String
      {
         return (var_21 as HabboAchievementNotificationMessageParser).badgeID;
      }
   }
}
