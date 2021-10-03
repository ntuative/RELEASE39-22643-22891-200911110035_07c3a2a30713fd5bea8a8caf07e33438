package com.sulake.habbo.room.object.visualization.pet
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.utils.getTimer;
   
   public class PetVisualization extends RoomObjectSpriteVisualization
   {
       
      
      private var var_828:String;
      
      private var var_548:int = 0;
      
      private const const_1494:int = 1;
      
      private const const_1305:int = 0;
      
      private var _assetLibrary:AssetLibrary = null;
      
      private var _isAnimating:Boolean;
      
      private const const_1004:int = 3;
      
      private var var_887:int = 0;
      
      private var var_420:int = 0;
      
      private const const_1003:int = 3;
      
      private const const_1495:int = 2;
      
      private var var_723:PetVisualizationData = null;
      
      private var var_594:Map;
      
      private var var_722:Array;
      
      public function PetVisualization()
      {
         var_722 = new Array();
         super();
         var_594 = new Map();
         _assetLibrary = new AssetLibrary("pet visualization");
         _isAnimating = false;
      }
      
      override public function update(param1:IRoomGeometry = null) : void
      {
         var _loc16_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:Boolean = false;
         var _loc22_:* = null;
         var _loc23_:* = false;
         var _loc24_:* = null;
         var _loc25_:* = null;
         var _loc26_:* = null;
         var _loc27_:* = null;
         var _loc28_:int = 0;
         var _loc29_:* = null;
         var _loc30_:* = null;
         var _loc31_:Number = NaN;
         var _loc32_:int = 0;
         var _loc33_:* = null;
         var _loc34_:* = null;
         var _loc35_:* = null;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:* = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:* = null;
         var _loc41_:* = null;
         var _loc42_:int = 0;
         var _loc43_:int = 0;
         var _loc44_:int = 0;
         var _loc45_:int = 0;
         var _loc46_:int = 0;
         var _loc47_:* = null;
         var _loc48_:* = null;
         var _loc49_:int = 0;
         var _loc50_:int = 0;
         var _loc51_:int = 0;
         var _loc52_:* = null;
         var _loc53_:int = 0;
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(var_723 == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModel = _loc2_.getModel();
         var _loc4_:String = "avatar" + param1.scale.toString();
         var _loc5_:* = var_594.getValue(_loc4_) as IAvatarImage;
         var _loc6_:String = _loc3_.getString(RoomObjectVariableEnum.const_146);
         var _loc7_:Number = new Date().valueOf();
         var _loc9_:int = _loc2_.getUpdateID();
         var _loc10_:int = param1.scale;
         var _loc11_:int = _loc3_.getUpdateID();
         var _loc12_:Boolean = false;
         var _loc13_:String = _loc3_.getString(RoomObjectVariableEnum.const_240);
         switch(_loc13_)
         {
            case AvatarAction.const_838:
            case AvatarAction.const_930:
            case AvatarAction.const_870:
            case AvatarAction.const_865:
            case AvatarAction.const_769:
            case AvatarAction.const_388:
            case AvatarAction.const_437:
               _loc12_ = true;
         }
         var _loc14_:Boolean = var_266 != _loc2_.getUpdateID() || var_200 != param1.scale || var_177 != _loc3_.getUpdateID();
         var _loc15_:Boolean = _isAnimating || var_420 > 0 || _loc12_;
         if(_loc14_ || _loc15_)
         {
            _loc16_ = getTimer();
            --var_420;
            if(var_828 != _loc6_)
            {
               for each(_loc34_ in var_594.getKeys())
               {
                  var_594.remove(_loc34_);
               }
               _loc5_ = null;
            }
            if(_loc5_ == null)
            {
               _loc35_ = _loc3_.getString(RoomObjectVariableEnum.const_907);
               _loc5_ = var_723.getAvatar(_loc6_,_loc35_,param1.scale);
               if(_loc5_ == null)
               {
                  return;
               }
               var_594.remove(_loc4_);
               var_594.add(_loc4_,_loc5_);
               var_828 = _loc6_;
            }
            _loc17_ = _loc2_.getDirection().x - (param1.direction.x + 135 - 22.5);
            _loc17_ = (_loc17_ % 360 + 360) % 360;
            _loc5_.setDirectionAngle(AvatarSetType.const_40,_loc17_);
            _loc18_ = _loc3_.getNumber(RoomObjectVariableEnum.const_305);
            if(isNaN(_loc18_))
            {
               _loc18_ = _loc17_;
            }
            else
            {
               _loc18_ -= param1.direction.x + 135 - 22.5;
            }
            _loc18_ = (_loc18_ % 360 + 360) % 360;
            _loc5_.setDirectionAngle(AvatarSetType.const_50,_loc18_);
            _loc5_.initActionAppends();
            _loc19_ = _loc3_.getString(RoomObjectVariableEnum.const_240);
            _loc20_ = _loc3_.getString(RoomObjectVariableEnum.const_552);
            _loc5_.appendAction(AvatarAction.const_624,_loc19_,_loc20_);
            _loc21_ = false;
            if(_loc19_ == "lay")
            {
               _loc36_ = Number(_loc20_);
               if(_loc36_ < 0)
               {
                  _loc21_ = true;
               }
            }
            _loc22_ = _loc3_.getString(RoomObjectVariableEnum.const_395);
            if(_loc22_ != null && _loc22_ != "")
            {
               _loc37_ = _loc3_.getNumber(RoomObjectVariableEnum.const_444);
               _loc38_ = 3;
               _loc39_ = _loc7_ - _loc37_;
               if(_loc39_ < _loc38_ * 1000)
               {
                  _loc5_.appendAction(AvatarAction.const_333,_loc22_);
               }
            }
            _loc23_ = _loc3_.getNumber(RoomObjectVariableEnum.const_351) > 0;
            if(_loc23_)
            {
               _loc5_.appendAction(AvatarAction.const_476);
            }
            _loc5_.endActionAppends();
            ++var_548;
            ++var_887;
            if(var_887 > 1)
            {
               _loc5_.updateAnimationByFrames(1);
               var_887 = 0;
            }
            _loc24_ = _loc5_.getImage(AvatarSetType.const_40);
            if(_loc24_ == null)
            {
               return;
            }
            _isAnimating = _loc5_.isAnimating();
            _loc25_ = _loc5_.avatarSpriteData;
            if(_loc25_ != null)
            {
            }
            _loc26_ = "avatar " + param1.scale;
            _loc27_ = _assetLibrary.getAssetByName(_loc26_) as BitmapDataAsset;
            if(_loc27_ == null)
            {
               _loc27_ = new BitmapDataAsset(_assetLibrary.getAssetTypeDeclarationByClass(BitmapDataAsset));
               _assetLibrary.setAsset(_loc26_,_loc27_);
            }
            if(_loc27_.content != null)
            {
               _loc40_ = _loc27_.content as BitmapData;
               if(_loc40_ != null && _loc40_ != _loc24_)
               {
                  _loc40_.dispose();
               }
            }
            _loc27_.setUnknownContent(_loc24_);
            _loc28_ = _loc5_.getSprites().length + const_1004;
            if(_loc28_ != spriteCount)
            {
               createSprites(_loc28_);
            }
            _loc30_ = _loc5_.getCanvasOffsets();
            if(_loc30_ == null || _loc30_.length < 3)
            {
               _loc30_ = new Array(0,0,0);
            }
            _loc29_ = getSprite(const_1305);
            if(_loc29_ != null)
            {
               _loc29_.asset = _loc27_;
               _loc29_.offsetX = -1 * param1.scale / 2 + _loc30_[0];
               _loc29_.offsetY = -_loc24_.height + param1.scale / 4 + _loc30_[1];
               if(!_loc21_)
               {
               }
            }
            _loc31_ = Math.sqrt(0.5);
            _loc32_ = const_1004;
            for each(_loc33_ in _loc5_.getSprites())
            {
               _loc29_ = getSprite(_loc32_);
               if(_loc29_ != null)
               {
                  _loc41_ = _loc5_.getLayerData(_loc33_);
                  _loc42_ = 0;
                  _loc43_ = _loc33_.getDirectionOffsetX(_loc5_.getDirection());
                  _loc44_ = _loc33_.getDirectionOffsetY(_loc5_.getDirection());
                  _loc45_ = _loc33_.getDirectionOffsetZ(_loc5_.getDirection());
                  _loc46_ = 0;
                  if(_loc33_.hasDirections)
                  {
                     _loc46_ = _loc5_.getDirection();
                  }
                  if(_loc41_ != null)
                  {
                     _loc42_ = _loc41_.animationFrame;
                     _loc43_ += _loc41_.dx;
                     _loc44_ += _loc41_.dy;
                     _loc46_ += _loc41_.directionOffset;
                  }
                  if(param1.scale < 48)
                  {
                     _loc43_ /= 2;
                     _loc44_ /= 2;
                  }
                  if(_loc46_ < 0)
                  {
                     _loc46_ += 8;
                  }
                  if(_loc46_ > 7)
                  {
                     _loc46_ -= 8;
                  }
                  _loc47_ = _loc5_.getScale() + "_" + _loc33_.member + "_" + _loc46_ + "_" + _loc42_;
                  _loc48_ = _loc5_.getAsset(_loc47_);
                  if(_loc48_ != null)
                  {
                     _loc29_.asset = _loc48_;
                     _loc29_.offsetX = -1 * _loc48_.offset.x - param1.scale / 2 + _loc43_;
                     _loc29_.offsetY = -1 * _loc48_.offset.y + _loc44_;
                     _loc29_.relativeDepth = -0.01 - 0.1 * _loc32_ * _loc45_;
                     if(_loc33_.ink == 33)
                     {
                        _loc29_.blendMode = BlendMode.ADD;
                     }
                     else
                     {
                        _loc29_.blendMode = BlendMode.NORMAL;
                     }
                     _loc32_++;
                  }
               }
            }
            if(_loc19_ == "mv" || _loc19_ == "std")
            {
               _loc28_ = _loc5_.getSprites().length + const_1004;
               if(_loc28_ != spriteCount)
               {
                  createSprites(_loc28_);
               }
               _loc29_ = getSprite(const_1494);
               _loc27_ = null;
               _loc26_ = null;
               _loc49_ = 0;
               _loc50_ = 0;
               switch(param1.scale)
               {
                  case 32:
                     _loc26_ = "sh_std_sd_1_0_0";
                     _loc49_ = -8;
                     _loc50_ = -3;
                     break;
                  case 64:
                     _loc26_ = "h_std_sd_1_0_0";
                     _loc49_ = -17;
                     _loc50_ = -7;
               }
               if(_loc26_ != null)
               {
                  _loc27_ = _loc5_.getAsset(_loc26_);
               }
               if(_loc27_ != null)
               {
                  _loc29_.asset = _loc27_;
                  _loc29_.offsetX = _loc49_;
                  _loc29_.offsetY = _loc50_;
                  _loc29_.alpha = 50;
                  _loc29_.relativeDepth = 1;
               }
            }
            var_266 = _loc2_.getUpdateID();
            var_177 = _loc3_.getUpdateID();
            var_200 = param1.scale;
            var_722.push(getTimer() - _loc16_);
            if(false)
            {
               _loc51_ = 0;
               _loc52_ = "[";
               for each(_loc53_ in var_722)
               {
                  _loc51_ += _loc53_;
                  _loc52_ += "," + _loc53_;
               }
               _loc52_ += "]";
               var_722 = new Array();
            }
         }
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         var_723 = param1 as PetVisualizationData;
         createSprites(4);
         return true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_594.dispose();
         if(_assetLibrary != null)
         {
            _assetLibrary.dispose();
            _assetLibrary = null;
         }
         var_723 = null;
      }
   }
}
