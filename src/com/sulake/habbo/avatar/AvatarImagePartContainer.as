package com.sulake.habbo.avatar
{
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.geom.ColorTransform;
   
   public class AvatarImagePartContainer
   {
       
      
      private var _frames:Array;
      
      private var var_1620:int;
      
      private var var_1622:String;
      
      private var var_1410:IActionDefinition;
      
      private var var_1621:Boolean;
      
      private var _color:IPartColor;
      
      private var var_1618:String;
      
      private var var_1617:String;
      
      private var var_1619:Boolean;
      
      private var var_1616:ColorTransform;
      
      private var var_1623:int;
      
      public function AvatarImagePartContainer(param1:String, param2:String, param3:int, param4:IPartColor, param5:Array, param6:IActionDefinition, param7:Boolean, param8:int, param9:String = "", param10:Boolean = false, param11:Number = 1)
      {
         super();
         var_1622 = param1;
         var_1618 = param2;
         var_1620 = param3;
         _color = param4;
         _frames = param5;
         var_1410 = param6;
         var_1619 = param7;
         var_1623 = param8;
         var_1617 = param9;
         var_1621 = param10;
         var_1616 = new ColorTransform(1,1,1,param11);
      }
      
      public function get isColorable() : Boolean
      {
         return var_1619;
      }
      
      public function get partType() : String
      {
         return var_1618;
      }
      
      public function getFrameIndex(param1:int) : int
      {
         return 0;
      }
      
      public function get paletteMapId() : int
      {
         return var_1623;
      }
      
      public function get isBlendable() : Boolean
      {
         return var_1621;
      }
      
      public function get color() : IPartColor
      {
         return _color;
      }
      
      public function get partId() : int
      {
         return var_1620;
      }
      
      public function get flippedPartType() : String
      {
         return var_1617;
      }
      
      public function get bodyPartId() : String
      {
         return var_1622;
      }
      
      public function get action() : IActionDefinition
      {
         return var_1410;
      }
      
      public function get blendTransform() : ColorTransform
      {
         return var_1616;
      }
   }
}
