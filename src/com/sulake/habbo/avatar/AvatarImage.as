package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.cache.AvatarImageBodyPartCache;
   import com.sulake.habbo.avatar.cache.AvatarImageCache;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AvatarImage implements IAvatarImage
   {
      
      private static const CHANNELS_UNIQUE:String = "CHANNELS_UNIQUE";
      
      private static const CHANNELS_EQUAL:String = "CHANNELS_EQUAL";
      
      private static const CHANNELS_SATURATED:String = "CHANNELS_SATURATED";
      
      private static const CHANNELS_BLUE:String = "CHANNELS_BLUE";
      
      private static const CHANNELS_RED:String = "CHANNELS_RED";
      
      private static const CHANNELS_GREEN:String = "CHANNELS_GREEN";
      
      private static const const_950:int = 2;
      
      private static const const_953:String = AvatarSetType.const_40;
      
      private static const const_952:String = "Default";
      
      private static const const_951:int = 125;
       
      
      private var var_1460:String = "";
      
      private var var_138:AvatarImageCache;
      
      private var var_268:Boolean;
      
      private var var_828:AvatarFigureContainer;
      
      private var var_169:Array;
      
      private var _isAnimating:Boolean;
      
      private var var_669:Boolean = false;
      
      private var _assets:AssetAliasCollection;
      
      private var var_555:IAvatarDataContainer;
      
      private var var_399:int = 0;
      
      private var var_2128:int;
      
      private var var_984:int = 0;
      
      private var var_231:Array;
      
      private var var_101:int;
      
      private var var_598:Array;
      
      private var var_179:String;
      
      private var var_767:String;
      
      private var var_2127:int;
      
      private var var_203:IActiveActionData;
      
      private var _image:BitmapData;
      
      private var var_98:AvatarStructure;
      
      public function AvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:String, param4:String, param5:String, ... rest)
      {
         var_231 = [];
         var_598 = new Array();
         super();
         var_268 = true;
         var_98 = param1;
         _assets = param2;
         var_179 = param4;
         var_767 = param5;
         if(var_179 == null)
         {
            var_179 = AvatarScaleType.const_66;
         }
         if(param3 == null || param3 == "")
         {
            if(param5 == "user")
            {
               param3 = "hr-893-45.hd-180-2.ch-210-66.lg-270-82.sh-300-91.wa-2007-.ri-1-";
            }
            else
            {
               param3 = "phd-1-5.pbd-1-5.ptl-1-5";
            }
         }
         var_828 = new AvatarFigureContainer(param3);
         if(param5 == AvatarType.PET && rest != null)
         {
            var_1460 = rest[0];
         }
         var_138 = new AvatarImageCache(var_98,this,_assets,var_179);
         setDirection(const_953,const_950);
         var_231 = new Array();
         resetActions();
      }
      
      private function logThis(param1:String) : void
      {
      }
      
      private function addActionData(param1:String, param2:String = "") : void
      {
         var _loc3_:* = null;
         if(var_231 == null)
         {
            var_231 = new Array();
         }
         var _loc4_:int = 0;
         while(_loc4_ < var_231.length)
         {
            _loc3_ = var_231[_loc4_];
            if(_loc3_.actionType == param1 && _loc3_.actionParameter == param2)
            {
               return;
            }
            _loc4_++;
         }
         var_231.push(new ActiveActionData(param1,param2));
      }
      
      public function getScale() : String
      {
         return var_179;
      }
      
      public function setScale(param1:String) : void
      {
         if(var_138 != null)
         {
         }
      }
      
      public function getSprites() : Array
      {
         return var_169;
      }
      
      public function getCanvasOffsets() : Array
      {
         return var_598;
      }
      
      public function setDirectionAngle(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2 / 45;
         setDirection(param1,_loc3_);
      }
      
      public function getImage(param1:String) : BitmapData
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:* = null;
         var _loc17_:int = 0;
         var _loc18_:* = null;
         if(!var_268)
         {
            return null;
         }
         if(var_203 == null)
         {
            return null;
         }
         if(!var_669)
         {
            endActionAppends();
         }
         var _loc2_:AvatarImageCache = getCache();
         var _loc3_:AvatarCanvas = var_98.getCanvas(var_179,var_203.definition.geometryType);
         if(_image == null || _loc3_ != null && (_image.width != _loc3_.width || _image.height != _loc3_.height))
         {
            _loc6_ = var_98.getCanvas(var_179,var_203.definition.geometryType);
            if(_loc6_ == null)
            {
               return null;
            }
            _image = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
         }
         var _loc4_:Array = var_98.getBodyParts(param1,var_203.definition,var_101);
         _image.lock();
         _image.fillRect(_image.rect,16777215);
         var _loc5_:int = _loc4_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc7_ = _loc4_[_loc5_];
            _loc8_ = _loc2_.getImageContainer(_loc7_,var_399);
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.getImage();
               _loc10_ = _loc8_.regPoint.clone();
               if(var_767 == AvatarType.PET)
               {
                  _loc11_ = getCache().getBodyPartCache(_loc7_);
                  _loc12_ = _loc11_.getAction();
                  _loc13_ = _loc12_.definition.assetPartDefinition;
                  _loc14_ = var_98.getParts(_loc7_,var_828,_loc12_,"pet",_loc11_.getDirection());
                  _loc15_ = 32;
                  if(var_179 == AvatarScaleType.const_93)
                  {
                     _loc15_ = 6;
                  }
                  if(_loc14_.length > 0)
                  {
                     _loc16_ = _loc14_[0];
                     _loc17_ = _loc16_.getFrameIndex(var_399);
                     _loc18_ = var_98.getPartActionOffset(getSubType(),var_179,_loc7_,_loc13_,_loc17_,var_101);
                     if(_loc18_ != null)
                     {
                        _loc10_.x += _loc18_.x;
                        _loc10_.y += _loc18_.y;
                        if(var_101 == 7 && _loc11_.getDirection() == 6)
                        {
                           _loc10_.offset(-1 * _loc15_,0);
                        }
                        else if(var_101 == 4 && _loc11_.getDirection() == 3)
                        {
                           _loc10_.offset(_loc15_,0);
                        }
                        else if(var_101 == 3 && _loc11_.getDirection() == 4)
                        {
                           _loc10_.offset(-1 * _loc15_,0);
                        }
                        else if(var_101 == 6 && _loc11_.getDirection() == 7)
                        {
                           _loc10_.offset(_loc15_,0);
                        }
                     }
                  }
               }
               _image.copyPixels(_loc9_,_loc9_.rect,_loc10_,null,null,true);
            }
            _loc5_--;
         }
         _image.unlock();
         var_268 = false;
         if(var_555 != null)
         {
            if(false)
            {
               _image = convertToGrayscale(_image);
               _image.paletteMap(_image,_image.rect,new Point(0,0),var_555.reds,[],[]);
            }
            else
            {
               _image.copyChannel(_image,_image.rect,new Point(0,0),2,8);
            }
         }
         return _image;
      }
      
      private function resetActions() : Boolean
      {
         var_169 = [];
         var_555 = null;
         var_984 = 0;
         var_98.removeDynamicItems();
         var_203 = new ActiveActionData(AvatarAction.const_805);
         var_203.definition = var_98.getActionDefinition(const_952);
         setActionToParts(var_203);
         getCache().resetBodyPartCache(var_203);
         return true;
      }
      
      public function updateAnimation(param1:Number) : void
      {
         var_399 = int(param1 % const_951);
         var_268 = true;
      }
      
      public function setDirection(param1:String, param2:int) : void
      {
         param2 += var_984;
         if(param2 < AvatarDirectionAngle.const_1263)
         {
            param2 = AvatarDirectionAngle.const_607 + (param2 + 1);
         }
         if(param2 > AvatarDirectionAngle.const_607)
         {
            param2 -= NaN;
         }
         if(var_767 == AvatarType.PET && param1 == AvatarSetType.const_50)
         {
            if((var_101 == 6 || var_101 == 0) && param2 == 7)
            {
               param2 = var_101;
            }
         }
         if(var_98.isMainAvatarSet(param1))
         {
            var_101 = param2;
         }
         getCache().setDirection(param1,param2);
         var_268 = true;
      }
      
      public function updateAnimationByFrames(param1:int = 1) : void
      {
         var_399 += param1;
         var_268 = true;
      }
      
      public function getAsset(param1:String) : BitmapDataAsset
      {
         return _assets.getAssetByName(param1) as BitmapDataAsset;
      }
      
      public function getMainAction() : IActiveActionData
      {
         return var_203;
      }
      
      private function errorThis(param1:String) : void
      {
         Logger.log("[AvatarImageError] " + param1);
      }
      
      public function get avatarSpriteData() : IAvatarDataContainer
      {
         return var_555;
      }
      
      private function setActionToParts(param1:IActiveActionData) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.definition.assetPartDefinition == "")
         {
            return;
         }
         if(param1.definition.isMain)
         {
            var_203 = param1;
            getCache().setGeometryType(param1.definition.geometryType);
         }
         getCache().setAction(param1);
         var_268 = true;
      }
      
      public function initActionAppends() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_231)
         {
            _loc1_.dispose();
         }
         var_231 = new Array();
         var_669 = false;
      }
      
      public function getCroppedImage(param1:String) : BitmapData
      {
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:int = 0;
         var _loc19_:* = null;
         var _loc20_:int = 0;
         var _loc21_:* = null;
         if(var_203 == null)
         {
            return null;
         }
         var _loc2_:AvatarImageCache = getCache();
         var _loc3_:AvatarCanvas = var_98.getCanvas(var_179,var_203.definition.geometryType);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,16777215);
         var _loc5_:Array = var_98.getBodyParts(param1,var_203.definition,var_101);
         var _loc7_:int = _loc5_.length - 1;
         while(_loc7_ >= 0)
         {
            _loc9_ = _loc5_[_loc7_];
            _loc10_ = _loc2_.getImageContainer(_loc9_,var_399);
            if(_loc10_ != null)
            {
               _loc11_ = _loc10_.getImage();
               if(_loc11_ == null)
               {
                  return null;
               }
               _loc12_ = _loc10_.regPoint.clone();
               if(var_767 == AvatarType.PET)
               {
                  _loc14_ = getCache().getBodyPartCache(_loc9_);
                  _loc15_ = _loc14_.getAction();
                  _loc16_ = _loc15_.definition.assetPartDefinition;
                  _loc17_ = var_98.getParts(_loc9_,var_828,_loc15_,"pet",_loc14_.getDirection());
                  _loc18_ = 32;
                  if(var_179 == AvatarScaleType.const_93)
                  {
                     _loc18_ = 6;
                  }
                  if(_loc17_.length > 0)
                  {
                     _loc19_ = _loc17_[0];
                     _loc20_ = _loc19_.getFrameIndex(var_399);
                     _loc21_ = var_98.getPartActionOffset(getSubType(),var_179,_loc9_,_loc16_,_loc20_,var_101);
                     if(_loc21_ != null)
                     {
                        _loc12_.x += _loc21_.x;
                        _loc12_.y += _loc21_.y;
                        if(var_101 == 7 && _loc14_.getDirection() == 6)
                        {
                           _loc12_.offset(-1 * _loc18_,0);
                        }
                        else if(var_101 == 4 && _loc14_.getDirection() == 3)
                        {
                           _loc12_.offset(_loc18_,0);
                        }
                        else if(var_101 == 3 && _loc14_.getDirection() == 4)
                        {
                           _loc12_.offset(-1 * _loc18_,0);
                        }
                        else if(var_101 == 6 && _loc14_.getDirection() == 7)
                        {
                           _loc12_.offset(_loc18_,0);
                        }
                     }
                  }
               }
               _loc4_.copyPixels(_loc11_,_loc11_.rect,_loc12_,null,null,true);
               _loc13_ = new Rectangle(_loc12_.x,_loc12_.y,_loc11_.width,_loc11_.height);
               if(_loc6_ == null)
               {
                  _loc6_ = _loc13_;
               }
               else
               {
                  _loc6_ = _loc6_.union(_loc13_);
               }
            }
            _loc7_--;
         }
         if(_loc6_ == null)
         {
            _loc6_ = new Rectangle(0,0,10,10);
         }
         var _loc8_:BitmapData = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
         _loc8_.copyPixels(_loc4_,_loc6_,new Point(0,0),null,null,true);
         return _loc8_;
      }
      
      private function convertToGrayscale(param1:BitmapData, param2:String = "CHANNELS_EQUAL") : BitmapData
      {
         var _loc3_:* = 0.33;
         var _loc4_:* = 0.33;
         var _loc5_:* = 0.33;
         switch(param2)
         {
            case "CHANNELS_UNIQUE":
               _loc3_ = 0.3;
               _loc4_ = 0.59;
               _loc5_ = 0.11;
               break;
            case "CHANNELS_RED":
               _loc3_ = 1;
               _loc4_ = 0;
               _loc5_ = 0;
               break;
            case "CHANNELS_GREEN":
               _loc3_ = 0;
               _loc4_ = 1;
               _loc5_ = 0;
               break;
            case "CHANNELS_BLUE":
               _loc3_ = 0;
               _loc4_ = 0;
               _loc5_ = 1;
               break;
            case "CHANNELS_DESATURATED":
               _loc3_ = 0.3086;
               _loc4_ = 0.6094;
               _loc5_ = 0.082;
         }
         var _loc7_:Array = [_loc3_,_loc4_,_loc5_,0,0,_loc3_,_loc4_,_loc5_,0,0,_loc3_,_loc4_,_loc5_,0,0,0,0,0,1,0];
         var _loc8_:ColorMatrixFilter = new ColorMatrixFilter(_loc7_);
         var _loc9_:BitmapData = new BitmapData(param1.width,param1.height,param1.transparent,4294967295);
         _loc9_.copyPixels(param1,param1.rect,new Point(0,0),null,null,false);
         _loc9_.applyFilter(_loc9_,_loc9_.rect,new Point(0,0),_loc8_);
         return _loc9_;
      }
      
      public function isAnimating() : Boolean
      {
         return _isAnimating;
      }
      
      public function getFigure() : AvatarFigureContainer
      {
         return var_828;
      }
      
      public function getSubType() : String
      {
         return var_1460;
      }
      
      public function getLayerData(param1:ISpriteDataContainer) : IAnimationLayerData
      {
         return var_98.getBodyPartData(param1.animation.id,var_399,param1.id);
      }
      
      public function endActionAppends() : void
      {
         sortActions();
         var_669 = true;
      }
      
      public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var_669 = false;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = rest[0];
         }
         switch(param1)
         {
            case AvatarAction.const_624:
               switch(_loc3_)
               {
                  case "wav":
                     addActionData("wave");
                     break;
                  case AvatarAction.const_1235:
                     if(var_101 == 0)
                     {
                        setDirection(AvatarSetType.const_40,4);
                     }
                     else if(var_101 == 6)
                     {
                        setDirection(AvatarSetType.const_40,2);
                     }
                     addActionData(_loc3_);
                     break;
                  case AvatarAction.const_761:
                  case AvatarAction.const_559:
                  case AvatarAction.const_838:
                  case AvatarAction.const_1151:
                  case AvatarAction.const_805:
                  case AvatarAction.const_930:
                  case AvatarAction.const_870:
                  case AvatarAction.const_1179:
                  case AvatarAction.const_1063:
                  case AvatarAction.const_1208:
                  case AvatarAction.const_865:
                  case AvatarAction.const_769:
                  case AvatarAction.const_1162:
                  case AvatarAction.const_924:
                     addActionData(_loc3_);
                     break;
                  default:
                     errorThis("appendAction() >> UNKNOWN POSTURE TYPE: " + _loc3_);
               }
               break;
            case AvatarAction.const_333:
               switch(_loc3_)
               {
                  case AvatarAction.const_887:
                  case AvatarAction.const_852:
                  case AvatarAction.const_586:
                  case AvatarAction.const_945:
                     addActionData(_loc3_);
                     break;
                  default:
                     errorThis("appendAction() >> UNKNOWN GESTURE TYPE: " + _loc3_);
               }
               break;
            case AvatarAction.const_388:
            case AvatarAction.const_437:
            case AvatarAction.const_850:
            case AvatarAction.const_669:
            case AvatarAction.const_476:
            case AvatarAction.const_788:
               addActionData(param1,_loc3_);
               break;
            case AvatarAction.const_786:
            case AvatarAction.const_842:
               _loc4_ = var_98.getActionDefinitionWithState(param1);
               if(_loc4_ != null)
               {
                  logThis("appendAction:" + [_loc3_,"->",_loc4_.getParameterValue(_loc3_)]);
                  _loc3_ = _loc4_.getParameterValue(_loc3_);
               }
               addActionData(param1,_loc3_);
               break;
            default:
               errorThis("appendAction() >> UNKNOWN ACTION TYPE: " + param1);
         }
         return true;
      }
      
      private function sortActions() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         resetActions();
         _isAnimating = false;
         var _loc1_:Array = var_98.sortActions(var_231);
         if(_loc1_ == null)
         {
            var_598 = new Array(0,0,0);
         }
         else
         {
            var_598 = var_98.getCanvasOffsets(_loc1_,var_179,var_101);
         }
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.definition.isAnimation && _loc2_.actionParameter == "")
            {
               _loc2_.actionParameter = "1";
            }
            setActionToParts(_loc2_);
            if(_loc2_.definition.isAnimation)
            {
               _isAnimating = true;
               _loc3_ = var_98.getAnimation(_loc2_.definition.state + "." + _loc2_.actionParameter);
               if(_loc3_ != null)
               {
                  var_169 = var_169.concat(_loc3_.spriteData);
                  if(_loc3_.hasDirectionData())
                  {
                     var_984 = _loc3_.directionData.offset;
                  }
                  if(_loc3_.hasAvatarData())
                  {
                     var_555 = _loc3_.avatarData;
                  }
               }
            }
            if(_loc2_.actionType == AvatarAction.const_559)
            {
               _isAnimating = true;
            }
            if(_loc2_.actionType == AvatarAction.const_437)
            {
               _isAnimating = true;
            }
            if(_loc2_.actionType == AvatarAction.const_388)
            {
               _isAnimating = true;
            }
         }
      }
      
      public function getDirection() : int
      {
         return var_101;
      }
      
      private function getCache() : AvatarImageCache
      {
         if(var_138 == null)
         {
            var_138 = new AvatarImageCache(var_98,this,_assets,var_179);
         }
         return var_138;
      }
      
      public function getPartColor(param1:String) : IPartColor
      {
         return var_98.getPartColor(var_828,param1);
      }
   }
}
