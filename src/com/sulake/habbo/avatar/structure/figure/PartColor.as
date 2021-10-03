package com.sulake.habbo.avatar.structure.figure
{
   import flash.geom.ColorTransform;
   
   public class PartColor implements IPartColor
   {
       
      
      private var _id:int;
      
      private var var_1279:uint;
      
      private var var_848:uint;
      
      private var _index:int;
      
      private var var_1551:int;
      
      private var var_1276:Number;
      
      private var _b:uint;
      
      private var var_1277:Number;
      
      private var var_1278:uint;
      
      private var _colorTransform:ColorTransform;
      
      private var var_1275:Number;
      
      private var var_1550:Boolean = false;
      
      public function PartColor(param1:XML)
      {
         super();
         _id = parseInt(param1.@id);
         _index = parseInt(param1.@index);
         var_1551 = parseInt(param1.@club);
         var_1550 = Boolean(parseInt(param1.@selectable));
         var _loc2_:String = param1.text();
         var_848 = parseInt(_loc2_,16);
         var_1279 = var_848 >> 16 & 255;
         var_1278 = var_848 >> 8 & 255;
         _b = var_848 >> 0 & 255;
         var_1275 = var_1279 / 255 * 1;
         var_1277 = var_1278 / 255 * 1;
         var_1276 = _b / 255 * 1;
         _colorTransform = new ColorTransform(var_1275,var_1277,var_1276);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return _colorTransform;
      }
      
      public function get rgb() : uint
      {
         return var_848;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get blueMultiplier() : Number
      {
         return var_1276;
      }
      
      public function get r() : uint
      {
         return var_1279;
      }
      
      public function get isSelectable() : Boolean
      {
         return var_1550;
      }
      
      public function get b() : uint
      {
         return _b;
      }
      
      public function get greenMultiplier() : Number
      {
         return var_1277;
      }
      
      public function get g() : uint
      {
         return var_1278;
      }
      
      public function get redMultiplier() : Number
      {
         return var_1275;
      }
      
      public function get club() : int
      {
         return var_1551;
      }
   }
}
