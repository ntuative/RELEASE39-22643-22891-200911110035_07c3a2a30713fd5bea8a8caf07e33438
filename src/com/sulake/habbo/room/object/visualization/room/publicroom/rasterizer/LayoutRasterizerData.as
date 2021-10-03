package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
   public class LayoutRasterizerData
   {
       
      
      private var var_998:XMLList;
      
      public function LayoutRasterizerData(param1:XML)
      {
         super();
         var_998 = param1.elements.element;
      }
      
      public function get elementList() : XMLList
      {
         return var_998;
      }
      
      public function dispose() : void
      {
         var_998 = null;
      }
   }
}
