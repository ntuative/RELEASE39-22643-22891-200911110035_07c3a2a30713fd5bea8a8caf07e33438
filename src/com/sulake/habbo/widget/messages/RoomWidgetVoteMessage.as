package com.sulake.habbo.widget.messages
{
   public class RoomWidgetVoteMessage extends RoomWidgetMessage
   {
      
      public static const const_120:String = "RWVM_VOTE_MESSAGE";
       
      
      private var var_1156:int;
      
      public function RoomWidgetVoteMessage(param1:int)
      {
         super(const_120);
         var_1156 = param1;
      }
      
      public function get vote() : int
      {
         return var_1156;
      }
   }
}
