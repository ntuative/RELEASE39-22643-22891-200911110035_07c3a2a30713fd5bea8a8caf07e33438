package com.sulake.habbo.widget.messages
{
   public class RoomWidgetChatMessage extends RoomWidgetMessage
   {
      
      public static const const_121:int = 0;
      
      public static const const_98:int = 1;
      
      public static const const_95:int = 2;
      
      public static const const_484:String = "RWCM_MESSAGE_CHAT";
       
      
      private var var_637:int = 0;
      
      private var var_1894:String = "";
      
      private var var_197:String = "";
      
      public function RoomWidgetChatMessage(param1:String, param2:String, param3:int = 0, param4:String = "")
      {
         super(param1);
         var_197 = param2;
         var_637 = param3;
         var_1894 = param4;
      }
      
      public function get recipientName() : String
      {
         return var_1894;
      }
      
      public function get chatType() : int
      {
         return var_637;
      }
      
      public function get text() : String
      {
         return var_197;
      }
   }
}
