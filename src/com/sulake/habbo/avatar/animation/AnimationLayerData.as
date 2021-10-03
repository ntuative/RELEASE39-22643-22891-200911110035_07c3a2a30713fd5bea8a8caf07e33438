package com.sulake.habbo.avatar.animation
{
   import com.sulake.habbo.avatar.AvatarStructure;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   
   public class AnimationLayerData implements IAnimationLayerData
   {
      
      public static const const_667:String = "bodypart";
      
      public static const const_418:String = "fx";
       
      
      private var _id:String;
      
      private var _dx:int;
      
      private var var_1410:IActiveActionData;
      
      private var _type:String;
      
      private var var_1943:int;
      
      private var var_399:int;
      
      private var var_940:String;
      
      private var var_984:int;
      
      private var var_1129:int;
      
      private var var_1128:int;
      
      public function AnimationLayerData(param1:AvatarStructure, param2:XML, param3:String, param4:int, param5:IActionDefinition)
      {
         super();
         var_399 = param4;
         _id = String(param2.@id);
         var_1943 = parseInt(param2.@frame);
         _dx = parseInt(param2.@dx);
         var_1128 = parseInt(param2.@dy);
         var_1129 = parseInt(param2.@dz);
         var_984 = parseInt(param2.@dd);
         _type = param3;
         var_940 = String(param2.@base);
         var _loc6_:String = "";
         if(var_940 != "")
         {
            _loc6_ = String(baseAsInt());
         }
         if(param5 != null)
         {
            var_1410 = new ActiveActionData(param5.state,_loc6_);
            var_1410.definition = param5;
         }
      }
      
      public function get animationFrame() : int
      {
         return var_1943;
      }
      
      public function baseAsInt() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_940.length)
         {
            _loc1_ += var_940.charCodeAt(_loc2_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get frameCounter() : int
      {
         return var_399;
      }
      
      public function get base() : String
      {
         return var_940;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get dx() : int
      {
         return _dx;
      }
      
      public function get dz() : int
      {
         return var_1129;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get dy() : int
      {
         return var_1128;
      }
      
      public function get action() : IActiveActionData
      {
         return var_1410;
      }
      
      public function get directionOffset() : int
      {
         return var_984;
      }
   }
}
