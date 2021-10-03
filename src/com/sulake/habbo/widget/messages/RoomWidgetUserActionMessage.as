package com.sulake.habbo.widget.messages
{
   public class RoomWidgetUserActionMessage extends RoomWidgetMessage
   {
      
      public static const const_664:String = "RWUAM_RESPECT_USER";
      
      public static const const_485:String = "RWUAM_GIVE_RIGHTS";
      
      public static const const_540:String = "RWUAM_START_TRADING";
      
      public static const const_558:String = "RWUAM_TAKE_RIGHTS";
      
      public static const const_530:String = "RWUAM_WHISPER_USER";
      
      public static const const_561:String = "RWUAM_IGNORE_USER";
      
      public static const const_550:String = "RWUAM_BAN_USER";
      
      public static const const_560:String = "RWUAM_UNIGNORE_USER";
      
      public static const const_482:String = "RWUAM_KICK_USER";
      
      public static const const_503:String = "RWUAM_SEND_FRIEND_REQUEST";
      
      public static const const_436:String = "RWUAM_KICK_BOT";
      
      public static const const_668:String = "RWUAM_OPEN_HOME_PAGE";
      
      public static const const_658:String = "RWUAM_REPORT";
       
      
      private var _userId:int = 0;
      
      public function RoomWidgetUserActionMessage(param1:String, param2:int = 0)
      {
         super(param1);
         _userId = param2;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}
