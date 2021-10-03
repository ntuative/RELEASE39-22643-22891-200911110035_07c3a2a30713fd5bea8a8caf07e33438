package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionErrorMessageEvent extends RoomSessionEvent
   {
      
      public static const const_184:String = "RSEME_MAX_PETS";
      
      public static const const_193:String = "RSEME_KICKED";
      
      public static const const_209:String = "RSEME_MAX_STICKIES";
      
      public static const const_892:String = "RSEME_DOOR_OTHER_DELETED";
      
      public static const const_189:String = "RSEME_MAX_SOUND";
      
      public static const const_203:String = "RSEME_MAX_FURNITURE";
      
      public static const const_181:String = "RSEME_GUIDE_BUSY";
      
      public static const const_194:String = "RSEME_GUIDE_EXISTS";
      
      public static const const_186:String = "RSEME_INVALID_ITEM_LOC";
      
      public static const const_183:String = "RSEME_MAX_QUEUE";
      
      public static const const_609:String = "RSEME_CANT_SET_NOT_OWNER";
      
      public static const const_847:String = "RSEME_DOOR_NOT_INSTALLED";
      
      public static const const_206:String = "RSEME_CANT_TRADE_STUFF";
       
      
      private var _message:String;
      
      public function RoomSessionErrorMessageEvent(param1:String, param2:IRoomSession, param3:String = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param4,param5);
         _message = param3;
      }
      
      public function get message() : String
      {
         return _message;
      }
   }
}
