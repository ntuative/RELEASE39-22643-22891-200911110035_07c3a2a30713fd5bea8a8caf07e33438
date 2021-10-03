package com.sulake.habbo.widget.messages
{
   import com.sulake.core.window.IWindowContainer;
   
   public class RoomWidgetAvatarEditorMessage extends RoomWidgetMessage
   {
      
      public static const const_1268:String = "RWCM_GET_WARDROBE";
      
      public static const const_651:String = "RWCM_OPEN_AVATAR_EDITOR";
       
      
      private var _context:IWindowContainer;
      
      public function RoomWidgetAvatarEditorMessage(param1:String, param2:IWindowContainer)
      {
         super(param1);
         _context = param2;
      }
      
      public function get context() : IWindowContainer
      {
         return _context;
      }
   }
}
