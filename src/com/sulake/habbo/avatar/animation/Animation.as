package com.sulake.habbo.avatar.animation
{
   import com.sulake.habbo.avatar.AvatarStructure;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   
   public class Animation implements IAnimation
   {
       
      
      private var var_1138:Array;
      
      private var var_1381:AvatarDataContainer;
      
      private var _frames:Array;
      
      private var var_1382:DirectionDataContainer;
      
      private var var_1383:ShadowDataContainer;
      
      private var var_621:Array;
      
      private var var_1136:Array;
      
      private var var_1137:Array;
      
      private var _id:String;
      
      public function Animation(param1:AvatarStructure, param2:XML)
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         _frames = [];
         var_1137 = [];
         var_1138 = [];
         var_1136 = [];
         var_621 = [];
         super();
         _id = String(param2.@name);
         if(param2.hasOwnProperty("sprite"))
         {
            for each(_loc5_ in param2.sprite)
            {
               var_1137.push(new SpriteDataContainer(this as IAnimation,_loc5_));
            }
         }
         if(param2.hasOwnProperty("avatar"))
         {
            var_1381 = new AvatarDataContainer(param2.avatar[0]);
         }
         if(param2.hasOwnProperty("canvas"))
         {
            for each(_loc6_ in param2.canvas)
            {
               var_1138.push(new CanvasDataContainer(_loc6_));
            }
         }
         if(param2.hasOwnProperty("direction"))
         {
            var_1382 = new DirectionDataContainer(param2.direction[0]);
         }
         if(param2.hasOwnProperty("shadow"))
         {
            var_1383 = new ShadowDataContainer(param2.shadow[0]);
         }
         if(param2.hasOwnProperty("remove"))
         {
            for each(_loc7_ in param2.remove)
            {
               var_1136.push(new RemoveDataContainer(_loc7_));
            }
         }
         if(param2.hasOwnProperty("add"))
         {
            for each(_loc8_ in param2.add)
            {
               var_621.push(new AddDataContainer(_loc8_));
            }
         }
         var _loc3_:int = 0;
         for each(_loc4_ in param2.frame)
         {
            _loc9_ = new Array();
            for each(_loc11_ in _loc4_.bodypart)
            {
               _loc10_ = param1.getActionDefinition(String(_loc11_.@action));
               if(_loc10_ != null)
               {
                  _loc13_ = new AnimationLayerData(param1,_loc11_,AnimationLayerData.const_667,_loc3_,_loc10_);
                  _loc9_.push(_loc13_);
               }
            }
            for each(_loc12_ in _loc4_.fx)
            {
               _loc10_ = param1.getActionDefinition(String(_loc12_.@action));
               _loc14_ = new AnimationLayerData(param1,_loc12_,AnimationLayerData.const_418,_loc3_,_loc10_);
               _loc9_.push(_loc14_);
               if(_loc10_ != null)
               {
               }
            }
            _frames.push(_loc9_);
            _loc3_++;
         }
      }
      
      public function get addData() : Array
      {
         return var_621;
      }
      
      public function hasRemoveData() : Boolean
      {
         return var_1136 != null;
      }
      
      public function get removeData() : Array
      {
         return var_1136;
      }
      
      public function hasDirectionData() : Boolean
      {
         return var_1382 != null;
      }
      
      public function hasSpriteData() : Boolean
      {
         return var_1137 != null;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function hasAvatarData() : Boolean
      {
         return var_1381 != null;
      }
      
      public function get spriteData() : Array
      {
         return var_1137;
      }
      
      public function hasCanvasData() : Boolean
      {
         return var_1138 != null;
      }
      
      public function getLayerData(param1:int, param2:String) : AnimationLayerData
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         for each(_loc3_ in getFrame(param1))
         {
            if(_loc3_.id == param2)
            {
               return _loc3_ as AnimationLayerData;
            }
            if(_loc3_.type == AnimationLayerData.const_418)
            {
               for each(_loc4_ in var_621)
               {
                  if(_loc4_.align == param2 && _loc4_.id == _loc3_.id)
                  {
                     return _loc3_ as AnimationLayerData;
                  }
               }
            }
         }
         return null;
      }
      
      public function get canvasData() : Array
      {
         return var_1138;
      }
      
      public function getAnimatedBodyPartIds(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in getFrame(param1))
         {
            if(_loc3_.type == AnimationLayerData.const_667)
            {
               _loc2_.push(_loc3_.id);
            }
            if(_loc3_.type == AnimationLayerData.const_418)
            {
               for each(_loc4_ in var_621)
               {
                  if(_loc4_.id == _loc3_.id)
                  {
                     _loc2_.push(_loc4_.align);
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function hasAddData() : Boolean
      {
         return var_621 != null;
      }
      
      public function get avatarData() : AvatarDataContainer
      {
         return var_1381;
      }
      
      public function getAddData(param1:String) : AddDataContainer
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_621)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get directionData() : DirectionDataContainer
      {
         return var_1382;
      }
      
      private function getFrame(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:* = [];
         if(false)
         {
            _loc3_ = param1 % 0;
            _loc2_ = _frames[_loc3_];
         }
         return _loc2_;
      }
      
      public function get shadowData() : ShadowDataContainer
      {
         return var_1383;
      }
      
      public function hasShadowData() : Boolean
      {
         return var_1383 != null;
      }
   }
}
