package com.sulake.room.utils
{
   public class ColorConverter
   {
       
      
      public function ColorConverter()
      {
         super();
      }
      
      public static function hslToRGB(param1:int) : int
      {
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc2_:Number = (param1 >> 16 & 255) / 255;
         var _loc3_:Number = (param1 >> 8 & 255) / 255;
         var _loc4_:Number = (param1 & 255) / 255;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         if(_loc3_ > 0)
         {
            _loc12_ = 0;
            _loc13_ = 0;
            if(_loc4_ < 0.5)
            {
               _loc12_ = Number(_loc4_ * (1 + _loc3_));
            }
            else
            {
               _loc12_ = Number(_loc4_ + _loc3_ - _loc4_ * _loc3_);
            }
            _loc13_ = Number(2 * _loc4_ - _loc12_);
            _loc14_ = _loc2_ + 0.3333333333333333;
            _loc15_ = _loc2_;
            _loc16_ = _loc2_ - 0.3333333333333333;
            if(_loc14_ < 0)
            {
               _loc14_ += 1;
            }
            else if(_loc14_ > 1)
            {
               _loc14_--;
            }
            if(_loc15_ < 0)
            {
               _loc15_ += 1;
            }
            else if(_loc15_ > 1)
            {
               _loc15_--;
            }
            if(_loc16_ < 0)
            {
               _loc16_ += 1;
            }
            else if(_loc16_ > 1)
            {
               _loc16_--;
            }
            if(_loc14_ * 6 < 1)
            {
               _loc5_ = Number(_loc13_ + (_loc12_ - _loc13_) * 6 * _loc14_);
            }
            else if(_loc14_ * 2 < 1)
            {
               _loc5_ = Number(_loc12_);
            }
            else if(_loc14_ * 3 < 2)
            {
               _loc5_ = Number(_loc13_ + (_loc12_ - _loc13_) * 6 * (0.6666666666666666 - _loc14_));
            }
            else
            {
               _loc5_ = Number(_loc13_);
            }
            if(_loc15_ * 6 < 1)
            {
               _loc6_ = Number(_loc13_ + (_loc12_ - _loc13_) * 6 * _loc15_);
            }
            else if(_loc15_ * 2 < 1)
            {
               _loc6_ = Number(_loc12_);
            }
            else if(_loc15_ * 3 < 2)
            {
               _loc6_ = Number(_loc13_ + (_loc12_ - _loc13_) * 6 * (0.6666666666666666 - _loc15_));
            }
            else
            {
               _loc6_ = Number(_loc13_);
            }
            if(_loc16_ * 6 < 1)
            {
               _loc7_ = Number(_loc13_ + (_loc12_ - _loc13_) * 6 * _loc16_);
            }
            else if(_loc16_ * 2 < 1)
            {
               _loc7_ = Number(_loc12_);
            }
            else if(_loc16_ * 3 < 2)
            {
               _loc7_ = Number(_loc13_ + (_loc12_ - _loc13_) * 6 * (0.6666666666666666 - _loc16_));
            }
            else
            {
               _loc7_ = Number(_loc13_);
            }
         }
         else
         {
            _loc5_ = Number(_loc4_);
            _loc6_ = Number(_loc4_);
            _loc7_ = Number(_loc4_);
         }
         var _loc8_:int = Math.round(_loc5_ * 255);
         var _loc9_:int = Math.round(_loc6_ * 255);
         var _loc10_:int = Math.round(_loc7_ * 255);
         return int((_loc8_ << 16) + (_loc9_ << 8) + _loc10_);
      }
      
      public static function rgbToHSL(param1:int) : int
      {
         var _loc2_:Number = (param1 >> 16 & 255) / 255;
         var _loc3_:Number = (param1 >> 8 & 255) / 255;
         var _loc4_:Number = (param1 & 255) / 255;
         var _loc5_:Number = Math.max(_loc2_,_loc3_,_loc4_);
         var _loc6_:Number = Math.min(_loc2_,_loc3_,_loc4_);
         var _loc7_:Number = _loc5_ - _loc6_;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         if(_loc7_ == 0)
         {
            _loc8_ = 0;
         }
         else if(_loc5_ == _loc2_)
         {
            if(_loc3_ > _loc4_)
            {
               _loc8_ = Number(60 * (_loc3_ - _loc4_) / _loc7_);
            }
            else
            {
               _loc8_ = Number(60 * (_loc3_ - _loc4_) / _loc7_ + 360);
            }
         }
         else if(_loc5_ == _loc3_)
         {
            _loc8_ = Number(60 * (_loc4_ - _loc2_) / _loc7_ + 120);
         }
         else if(_loc5_ == _loc4_)
         {
            _loc8_ = Number(60 * (_loc2_ - _loc3_) / _loc7_ + 240);
         }
         _loc9_ = Number(0.5 * (_loc5_ + _loc6_));
         if(_loc7_ == 0)
         {
            _loc10_ = 0;
         }
         else if(_loc9_ <= 0.5)
         {
            _loc10_ = Number(_loc7_ / _loc9_ * 0.5);
         }
         else
         {
            _loc10_ = Number(_loc7_ / (1 - _loc9_) * 0.5);
         }
         var _loc11_:int = Math.round(_loc8_ / 360 * 255);
         var _loc12_:int = Math.round(_loc10_ * 255);
         var _loc13_:int = Math.round(_loc9_ * 255);
         return int((_loc11_ << 16) + (_loc12_ << 8) + _loc13_);
      }
   }
}
