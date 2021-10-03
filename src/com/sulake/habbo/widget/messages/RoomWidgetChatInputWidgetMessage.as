package com.sulake.habbo.widget.messages
{
   import com.sulake.core.window.IWindowContainer;
   
   public class RoomWidgetChatInputWidgetMessage extends RoomWidgetMessage
   {
      
      public static const const_662:String = "RWCIW_MESSAGE_POSITION_WINDOW";
      
      public static const const_1355:String = "RWCIW_MESSAGE_GET_INFO_FOR_CHAT_INPUT";
       
      
      private var _window:IWindowContainer;
      
      public function RoomWidgetChatInputWidgetMessage(param1:String, param2:IWindowContainer = null)
      {
         super(param1);
         _window = param2;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
   }
}
