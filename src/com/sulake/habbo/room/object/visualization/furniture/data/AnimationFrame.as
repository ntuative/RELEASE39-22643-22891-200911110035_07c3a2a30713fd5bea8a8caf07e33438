package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class AnimationFrame
   {
      
      public static const const_499:int = -1;
      
      public static const const_876:int = -1;
       
      
      private var _y:int = 0;
      
      private var var_1810:int = -1;
      
      private var var_88:int = 0;
      
      private var var_1113:int = 1;
      
      private var var_745:int = 1;
      
      private var var_1809:Boolean = false;
      
      private var var_1811:int = 0;
      
      private var _id:int = 0;
      
      public function AnimationFrame(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int = -1, param7:int = 0)
      {
         super();
         _id = param1;
         var_88 = param2;
         _y = param3;
         var_1809 = param5;
         if(param4 < 0)
         {
            param4 = const_499;
         }
         var_745 = param4;
         var_1113 = param4;
         if(param6 >= 0)
         {
            var_1810 = param6;
            var_1811 = param7;
         }
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set remainingFrameRepeats(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(var_745 > 0 && param1 > var_745)
         {
            param1 = var_745;
         }
         var_1113 = param1;
      }
      
      public function get frameRepeats() : int
      {
         return var_745;
      }
      
      public function get activeSequenceOffset() : int
      {
         return var_1811;
      }
      
      public function get id() : int
      {
         if(_id >= 0)
         {
            return _id;
         }
         return -_id * Math.random();
      }
      
      public function get remainingFrameRepeats() : int
      {
         if(var_745 < 0)
         {
            return const_499;
         }
         return var_1113;
      }
      
      public function get activeSequence() : int
      {
         return var_1810;
      }
      
      public function get isLastFrame() : Boolean
      {
         return var_1809;
      }
      
      public function get x() : int
      {
         return var_88;
      }
   }
}
