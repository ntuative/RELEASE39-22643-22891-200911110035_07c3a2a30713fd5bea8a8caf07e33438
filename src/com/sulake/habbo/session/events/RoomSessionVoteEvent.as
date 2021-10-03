package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionVoteEvent extends RoomSessionEvent
   {
      
      public static const const_108:String = "RSPE_VOTE_RESULT";
      
      public static const const_119:String = "RSPE_VOTE_QUESTION";
       
      
      private var var_1195:int = 0;
      
      private var var_935:String = "";
      
      private var var_615:Array;
      
      private var var_952:Array;
      
      public function RoomSessionVoteEvent(param1:String, param2:IRoomSession, param3:String, param4:Array, param5:Array = null, param6:int = 0, param7:Boolean = false, param8:Boolean = false)
      {
         var_952 = [];
         var_615 = [];
         super(param1,param2,param7,param8);
         var_935 = param3;
         var_952 = param4;
         var_615 = param5;
         if(var_615 == null)
         {
            var_615 = [];
         }
         var_1195 = param6;
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
