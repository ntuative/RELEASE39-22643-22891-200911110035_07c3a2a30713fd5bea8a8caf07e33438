package com.sulake.core.window.graphics.renderer
{
   import flash.geom.Rectangle;
   
   public class SkinLayoutEntity implements ISkinLayoutEntity
   {
      
      public static const const_235:uint = 1;
      
      public static const const_403:uint = 0;
      
      public static const const_920:uint = 8;
      
      public static const const_224:uint = 4;
      
      public static const const_422:uint = 2;
       
      
      private var var_365:uint;
      
      private var var_1703:uint;
      
      private var _color:uint;
      
      private var _name:String;
      
      private var var_1704:uint;
      
      private var var_100:Rectangle;
      
      private var var_546:Array;
      
      private var _id:uint;
      
      public function SkinLayoutEntity(param1:uint, param2:String, param3:Rectangle, param4:uint = 4.294967295E9, param5:uint = 100, param6:uint = 0, param7:uint = 0)
      {
         super();
         _id = param1;
         _name = param2;
         var_100 = param3;
         _color = param4;
         var_365 = param5;
         var_1703 = param6;
         var_1704 = param7;
         var_546 = new Array();
      }
      
      public function get scaleH() : uint
      {
         return var_1703;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get blend() : uint
      {
         return var_365;
      }
      
      public function get scaleV() : uint
      {
         return var_1704;
      }
      
      public function get tags() : Array
      {
         return var_546;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function dispose() : void
      {
         var_100 = null;
         var_546 = null;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get region() : Rectangle
      {
         return var_100;
      }
   }
}
