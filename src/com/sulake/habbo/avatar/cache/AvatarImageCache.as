package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.AvatarImage;
   import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
   import com.sulake.habbo.avatar.AvatarImagePartContainer;
   import com.sulake.habbo.avatar.AvatarStructure;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.AnimationLayerData;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarBodyPartType;
   import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.palette.PaletteMap;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class AvatarImageCache
   {
      
      private static const const_1311:int = 60000;
       
      
      private var _assets:AssetAliasCollection;
      
      private var var_138:Map;
      
      private var var_1152:String;
      
      private var var_179:String;
      
      private var var_98:AvatarStructure;
      
      private var var_796:IAvatarImage;
      
      public function AvatarImageCache(param1:AvatarStructure, param2:IAvatarImage, param3:AssetAliasCollection, param4:String)
      {
         super();
         var_98 = param1;
         var_796 = param2;
         _assets = param3;
         var_179 = param4;
         var_138 = new Map();
      }
      
      private function debugInfo(param1:String) : void
      {
      }
      
      public function setAction(param1:IActiveActionData) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Array = var_98.getActiveBodyPartIds(param1);
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = getBodyPartCache(_loc3_);
            if(_loc4_ != null)
            {
               _loc4_.setAction(param1);
            }
         }
      }
      
      public function setDirection(param1:String, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:Array = var_98.getBodyPartsUnordered(param1);
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = getBodyPartCache(_loc4_);
            if(_loc5_ != null)
            {
               _loc5_.setDirection(param2);
            }
         }
      }
      
      private function renderBodyPart(param1:int, param2:Array, param3:int, param4:IActiveActionData) : AvatarImageBodyPartContainer
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:Boolean = false;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:int = 0;
         var _loc25_:* = null;
         var _loc30_:* = null;
         var _loc31_:* = null;
         var _loc32_:* = null;
         var _loc33_:* = null;
         var _loc34_:* = null;
         var _loc35_:* = null;
         var _loc36_:* = null;
         var _loc37_:* = null;
         var _loc38_:* = null;
         var _loc39_:* = NaN;
         var _loc40_:* = null;
         var _loc41_:* = null;
         if(param2 == null)
         {
            return null;
         }
         if(param2.length == 0)
         {
            return null;
         }
         var _loc5_:AvatarCanvas = var_98.getCanvas(var_179,var_1152);
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc8_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
         var _loc20_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc26_:Point = new Point(0,_loc5_.height - int(_loc5_.width / 4));
         var _loc27_:int = param2.length - 1;
         while(_loc27_ >= 0)
         {
            _loc7_ = param2[_loc27_] as AvatarImagePartContainer;
            _loc23_ = param1;
            _loc6_ = _loc7_.bodyPartId;
            _loc7_ = param2[_loc27_];
            _loc11_ = _loc7_.partType;
            _loc12_ = _loc7_.partId;
            _loc13_ = _loc7_.getFrameIndex(param3);
            _loc14_ = _loc7_.color;
            _loc18_ = _loc7_.action;
            _loc19_ = _loc7_.isColorable;
            _loc20_ = false;
            _loc24_ = _loc7_.isBlendable;
            _loc25_ = _loc7_.blendTransform;
            if(_loc11_ == "ey")
            {
               _loc19_ = false;
            }
            _loc30_ = param4.definition.assetPartDefinition;
            _loc31_ = param4.definition.state;
            if(AvatarDirectionAngle.const_1124[param1])
            {
               if(!((_loc11_ == "lh" || _loc11_ == "ls" || _loc11_ == "lhs") && _loc30_ == "wav"))
               {
                  if(!((_loc11_ == "rh" || _loc11_ == "rhs" || _loc11_ == "rs") && _loc30_ == "drk"))
                  {
                     if(!(_loc11_ == "rhs" && _loc30_ == "crr"))
                     {
                        if(_loc11_ != "ri")
                        {
                           _loc20_ = true;
                           if(param1 == 4)
                           {
                              _loc23_ = 2;
                           }
                           else if(param1 == 5)
                           {
                              _loc23_ = 1;
                           }
                           else if(param1 == 6)
                           {
                              _loc23_ = 0;
                           }
                           if(_loc7_.flippedPartType != _loc11_)
                           {
                              _loc11_ = _loc7_.flippedPartType;
                           }
                        }
                     }
                  }
               }
            }
            if((_loc11_ == "phd" || _loc11_ == "ptl") && (_loc30_ == "jmp" || _loc30_ == "scr" || _loc30_ == "bnd"))
            {
               _loc10_ = var_179 + "_std_" + _loc11_ + "_" + _loc12_ + "_" + _loc23_ + "_" + "0";
               _loc16_ = _assets.getAssetByName(_loc10_) as BitmapDataAsset;
            }
            else
            {
               _loc10_ = var_179 + "_" + _loc18_.assetPartDefinition + "_" + _loc11_ + "_" + _loc12_ + "_" + _loc23_ + "_" + _loc13_;
               _loc16_ = _assets.getAssetByName(_loc10_) as BitmapDataAsset;
            }
            if(_loc16_ != null)
            {
               if(_loc7_.paletteMapId > -1)
               {
                  _loc33_ = _assets.getAssetByName("avatar_palette_" + _loc7_.paletteMapId).content as XML;
                  _loc34_ = new PaletteMap(_loc33_);
                  _loc35_ = _loc16_.content as BitmapData;
                  if(_loc35_ != null)
                  {
                     _loc36_ = _loc35_.getPixels(_loc35_.rect);
                     _loc37_ = _loc34_.colorize(_loc36_);
                     _loc9_ = new BitmapData(_loc35_.width,_loc35_.height);
                     _loc9_.setPixels(_loc9_.rect,_loc37_);
                  }
               }
               else
               {
                  _loc9_ = (_loc16_.content as BitmapData).clone();
               }
               if(_loc9_ == null)
               {
                  return null;
               }
               _loc17_ = _loc16_.offset;
               if((_loc31_ == AvatarAction.const_761 || _loc31_ == AvatarAction.const_559) && (_loc6_ == AvatarBodyPartType.const_320 || _loc6_ == AvatarBodyPartType.const_1278 || _loc6_ == AvatarBodyPartType.const_1167) && _loc7_.color != null)
               {
                  _loc38_ = _loc7_.color.colorTransform;
                  _loc39_ = 0.7;
                  _loc40_ = new ColorTransform(_loc38_.redMultiplier * _loc39_,_loc38_.greenMultiplier * _loc39_ + 0.3,_loc38_.blueMultiplier * _loc39_ + 0.3,_loc38_.alphaMultiplier,0,0,20);
                  _loc9_.colorTransform(_loc9_.rect,_loc40_);
               }
               else if(_loc19_ && _loc7_.color != null)
               {
                  _loc9_.colorTransform(_loc9_.rect,_loc7_.color.colorTransform);
               }
               if(_loc24_)
               {
                  _loc9_.colorTransform(_loc9_.rect,_loc25_);
               }
               _loc22_ = _loc26_.subtract(_loc17_);
               if(_loc20_)
               {
                  _loc22_.x *= -1;
                  if(var_179 == AvatarScaleType.const_66)
                  {
                     _loc22_.offset(67,0);
                  }
                  else
                  {
                     _loc22_.offset(31,0);
                  }
                  _loc41_ = new Matrix(-1,0,0,1,_loc22_.x,_loc22_.y + _loc5_.offset.y);
                  _loc8_.draw(_loc9_,_loc41_);
                  _loc32_ = new Rectangle(_loc22_.x - _loc9_.width,_loc22_.y + _loc5_.offset.y,_loc9_.width,_loc9_.height);
               }
               else
               {
                  _loc8_.copyPixels(_loc9_,_loc9_.rect,_loc22_.add(_loc5_.offset),null,null,true);
                  _loc32_ = new Rectangle(_loc22_.x,_loc22_.y,_loc9_.width + _loc5_.offset.x,_loc9_.height + _loc5_.offset.y);
               }
               if(_loc21_ == null)
               {
                  _loc21_ = _loc32_;
               }
               else
               {
                  _loc21_ = _loc21_.union(_loc32_);
               }
            }
            _loc27_--;
         }
         if(_loc21_ == null)
         {
            return null;
         }
         var _loc28_:BitmapData = new BitmapData(Math.max(_loc21_.width,0),Math.max(_loc21_.height,0),true,16711935);
         _loc28_.copyPixels(_loc8_,_loc21_,new Point(0,0),null,null,true);
         return new AvatarImageBodyPartContainer(_loc28_,new Point(_loc21_.x,_loc21_.y));
      }
      
      public function setGeometryType(param1:String) : void
      {
         if(var_1152 != param1)
         {
            disposeInactiveActions(0);
            var_1152 = param1;
         }
      }
      
      public function getBodyPartCache(param1:String) : AvatarImageBodyPartCache
      {
         if(var_138 == null)
         {
            var_138 = new Map();
         }
         var _loc2_:AvatarImageBodyPartCache = var_138.getValue(param1) as AvatarImageBodyPartCache;
         if(_loc2_ == null)
         {
            _loc2_ = new AvatarImageBodyPartCache();
            var_138.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function updateBodyPartCache(param1:String, param2:AvatarImageBodyPartCache) : void
      {
         if(var_138 == null)
         {
            var_138 = new Map();
         }
         var_138.add(param1,param2);
      }
      
      public function getAnimationDataInFrame(param1:String, param2:int) : AnimationLayerData
      {
         var _loc5_:* = null;
         var _loc3_:AvatarImageBodyPartCache = getBodyPartCache(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:IActiveActionData = _loc3_.getAction();
         if(_loc4_ == null || !_loc4_.definition.isAnimation)
         {
            return null;
         }
         return var_98.getBodyPartData(_loc4_.definition.state + "." + _loc4_.actionParameter,param2,param1);
      }
      
      public function disposeInactiveActions(param1:int = 60000) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(var_138 != null)
         {
            _loc2_ = var_138.getKeys();
            for each(_loc3_ in _loc2_)
            {
               _loc4_ = var_138.getValue(_loc3_) as AvatarImageBodyPartCache;
               if(_loc4_ != null)
               {
                  _loc4_.disposeActions(param1);
               }
            }
         }
      }
      
      public function getImageContainer(param1:String, param2:int) : AvatarImageBodyPartContainer
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc3_:AvatarImageBodyPartCache = getBodyPartCache(param1);
         if(_loc3_ == null)
         {
            debugInfo("[CacheMiss (getBodyPartCache)] [AvatarImageCache.getImageContainer] bodyPartId: " + param1);
            _loc3_ = new AvatarImageBodyPartCache();
            updateBodyPartCache(param1,_loc3_);
         }
         var _loc4_:int = _loc3_.getDirection();
         var _loc5_:IActiveActionData = _loc3_.getAction();
         var _loc6_:IActiveActionData = _loc5_;
         var _loc7_:Boolean = false;
         var _loc8_:int = _loc4_;
         var _loc9_:Point = new Point(0,0);
         var _loc12_:int = param2;
         if(_loc5_ == null)
         {
            debugInfo("Action not found!!");
         }
         else if(_loc5_.definition.isAnimation)
         {
            _loc15_ = var_98.getBodyPartData(_loc5_.definition.state + "." + _loc5_.actionParameter,param2,param1);
            if(_loc15_ != null)
            {
               _loc8_ = _loc4_ + _loc15_.directionOffset;
               if(_loc15_.directionOffset < 0)
               {
                  if(_loc8_ < 0)
                  {
                     _loc8_ = 8 + _loc8_;
                  }
                  if(_loc8_ > 7)
                  {
                     _loc8_ = 8 - _loc8_;
                  }
               }
               else
               {
                  if(_loc8_ < 0)
                  {
                     _loc8_ += 8;
                  }
                  if(_loc8_ > 7)
                  {
                     _loc8_ -= 8;
                  }
               }
               if(var_179 == AvatarScaleType.const_93)
               {
                  _loc9_.x = _loc15_.dx / 2;
                  _loc9_.y = _loc15_.dy / 2;
               }
               else
               {
                  _loc9_.x = _loc15_.dx;
                  _loc9_.y = _loc15_.dy;
               }
               _loc12_ = _loc15_.animationFrame;
               _loc5_ = _loc15_.action;
               if(_loc15_.type == AnimationLayerData.const_667)
               {
                  _loc6_ = _loc15_.action;
                  _loc4_ = _loc8_;
               }
               else if(_loc15_.type == AnimationLayerData.const_418)
               {
                  _loc4_ = _loc8_;
               }
               _loc7_ = true;
            }
         }
         var _loc13_:AvatarImageActionCache = _loc3_.getActionCache(_loc6_);
         if(_loc13_ == null)
         {
            debugInfo("[CacheMiss (bodyPartCache.getActionCache)] [AvatarImageCache.getImageContainer] action.id: " + [param1,_loc5_.id]);
            _loc13_ = new AvatarImageActionCache();
            _loc3_.updateActionCache(_loc6_,_loc13_);
         }
         var _loc14_:AvatarImageDirectionCache = _loc13_.getDirectionCache(_loc4_);
         if(_loc14_ == null)
         {
            debugInfo("[CacheMiss (actionCache.getDirectionCache)] [AvatarImageCache.getImageContainer] direction: " + [param1,_loc4_]);
            _loc10_ = var_98.getParts(param1,(var_796 as AvatarImage).getFigure(),_loc6_,var_1152,_loc4_);
            _loc14_ = new AvatarImageDirectionCache(_loc10_);
            _loc13_.updateDirectionCache(_loc4_,_loc14_);
         }
         _loc11_ = _loc14_.getImageContainer(_loc12_);
         if(_loc11_ == null)
         {
            debugInfo("[ImageContainer (" + _loc5_.id + " " + _loc5_.definition + " type: " + _loc5_.actionType + ")]");
            _loc16_ = _loc14_.getPartList();
            _loc11_ = renderBodyPart(_loc4_,_loc16_,_loc12_,_loc5_);
            if(_loc11_ != null)
            {
               debugInfo("[ImageContainer creation (" + _loc5_.id + " " + _loc5_.definition + " type: " + _loc5_.actionType + ")]");
               _loc14_.updateImageContainer(_loc11_,_loc12_);
            }
            else
            {
               debugInfo("[ImageContainer was null: " + param1 + "]");
            }
         }
         if(_loc11_ != null)
         {
            _loc11_.offset = _loc9_;
         }
         return _loc11_;
      }
      
      public function resetBodyPartCache(param1:IActiveActionData) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(var_138 != null)
         {
            _loc2_ = var_138.getKeys();
            for each(_loc3_ in _loc2_)
            {
               _loc4_ = var_138.getValue(_loc3_) as AvatarImageBodyPartCache;
               if(_loc4_ != null)
               {
                  _loc4_.setAction(param1);
               }
            }
         }
      }
      
      public function dispose() : void
      {
         debugInfo("[AvatarImageCache dispose]");
         var_98 = null;
         var_796 = null;
         _assets = null;
         if(var_138 != null)
         {
            var_138.dispose();
         }
      }
   }
}
