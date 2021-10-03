package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class ColorData
   {
      
      public static const const_61:uint = 16777215;
       
      
      private var _colors:Array;
      
      public function ColorData(param1:int)
      {
         _colors = [];
         super();
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _colors.push(const_61);
            _loc2_++;
         }
      }
      
      public function setColor(param1:uint, param2:int) : void
      {
         if(param2 < 0 || param2 >= _colors.length)
         {
            return;
         }
         _colors[param2] = param1;
      }
      
      public function dispose() : void
      {
         _colors = null;
      }
      
      public function getColor(param1:int) : uint
      {
         if(param1 < 0 || param1 >= _colors.length)
         {
            return const_61;
         }
         return _colors[param1];
      }
   }
}
