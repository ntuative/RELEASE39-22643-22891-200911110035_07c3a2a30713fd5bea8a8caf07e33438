package com.sulake.habbo.widget.events
{
   public class RoomWidgetVoteUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_108:String = "RWPUE_VOTE_RESULT";
      
      public static const const_119:String = "RWPUE_VOTE_QUESTION";
       
      
      private var var_1195:int;
      
      private var var_935:String;
      
      private var var_615:Array;
      
      private var var_952:Array;
      
      public function RoomWidgetVoteUpdateEvent(param1:String, param2:String, param3:Array, param4:Array = null, param5:int = 0, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         var_935 = param2;
         var_952 = param3;
         var_615 = param4;
         if(var_615 == null)
         {
            var_615 = [];
         }
         var_1195 = param5;
      }
      
      public function get votes() : Array
      {
         return var_615.slice();
      }
      
      public function get totalVotes() : int
      {
         return var_1195;
      }
      
      public function get question() : String
      {
         return var_935;
      }
      
      public function get choices() : Array
      {
         return var_952.slice();
      }
   }
}
