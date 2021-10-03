package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class LayerData
   {
      
      public static const const_356:int = 255;
      
      public static const INK_DARKEN:int = 3;
      
      public static const const_517:int = 0;
      
      public static const const_829:int = 2;
      
      public static const const_748:int = 1;
      
      public static const const_483:Boolean = false;
      
      public static const const_546:String = "";
      
      public static const const_432:int = 0;
      
      public static const const_348:int = 0;
      
      public static const const_401:int = 0;
       
      
      private var var_1711:int = 0;
      
      private var var_1689:String = "";
      
      private var var_1371:int = 0;
      
      private var var_1709:int = 0;
      
      private var var_1707:Number = 0;
      
      private var var_1710:int = 255;
      
      private var var_1708:Boolean = false;
      
      public function LayerData()
      {
         super();
      }
      
      public function get yOffset() : int
      {
         return var_1711;
      }
      
      public function copyValues(param1:LayerData) : void
      {
         if(param1 != null)
         {
            tag = param1.tag;
            ink = param1.ink;
            alpha = param1.alpha;
            ignoreMouse = param1.ignoreMouse;
            xOffset = param1.xOffset;
            yOffset = param1.yOffset;
            zOffset = param1.zOffset;
         }
      }
      
      public function set ink(param1:int) : void
      {
         var_1371 = param1;
      }
      
      public function get zOffset() : Number
      {
         return var_1707;
      }
      
      public function set xOffset(param1:int) : void
      {
         var_1709 = param1;
      }
      
      public function set yOffset(param1:int) : void
      {
         var_1711 = param1;
      }
      
      public function get tag() : String
      {
         return var_1689;
      }
      
      public function get alpha() : int
      {
         return var_1710;
      }
      
      public function get ink() : int
      {
         return var_1371;
      }
      
      public function set zOffset(param1:Number) : void
      {
         var_1707 = param1;
      }
      
      public function get xOffset() : int
      {
         return var_1709;
      }
      
      public function set ignoreMouse(param1:Boolean) : void
      {
         var_1708 = param1;
      }
      
      public function get ignoreMouse() : Boolean
      {
         return var_1708;
      }
      
      public function set tag(param1:String) : void
      {
         var_1689 = param1;
      }
      
      public function set alpha(param1:int) : void
      {
         var_1710 = param1;
      }
   }
}
