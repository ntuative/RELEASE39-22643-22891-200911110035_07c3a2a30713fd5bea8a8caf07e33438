package com.sulake.habbo.widget.messages
{
   public class RoomWidgetChatTypingMessage extends RoomWidgetMessage
   {
      
      public static const const_643:String = "RWCTM_TYPING_STATUS";
       
      
      private var var_439:Boolean;
      
      public function RoomWidgetChatTypingMessage(param1:Boolean)
      {
         super(const_643);
         var_439 = param1;
      }
      
      public function get isTyping() : Boolean
      {
         return var_439;
      }
   }
}
