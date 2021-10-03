package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.enum.WindowState;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.IBitmapDrawable;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapSkinRenderer extends SkinRenderer implements ISkinRenderer
   {
       
      
      protected var var_543:Dictionary;
      
      private var var_579:Matrix;
      
      protected var var_544:Dictionary;
      
      public function BitmapSkinRenderer(param1:Array)
      {
         super(param1);
         var_544 = new Dictionary(false);
         var_543 = new Dictionary(false);
         var_579 = new Matrix();
      }
      
      private function getBitmapFromCache(param1:ISkinTemplate, param2:String) : BitmapData
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:String = param2 + "@" + param1.name;
         var _loc4_:BitmapData = var_544[_loc3_];
         if(_loc4_ == null)
         {
            _loc5_ = param1.getChildByName(param2) as ISkinTemplateEntity;
            if(_loc5_ == null)
            {
               throw new Error("Template entity" + param2 + "not found!");
            }
            _loc6_ = BitmapDataAsset(param1.asset).content as BitmapData;
            if(_loc6_ == null)
            {
               throw new Error("Asset " + param1.asset + " not found!");
            }
            _loc4_ = new BitmapData(_loc5_.region.width,_loc5_.region.height,false);
            _loc4_.copyPixels(_loc6_,_loc5_.region,_loc4_.rect.topLeft);
            var_544[_loc3_] = _loc4_;
         }
         return _loc4_;
      }
      
      override public function draw(param1:IWindow, param2:IBitmapDrawable, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc9_:* = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:* = null;
         var _loc28_:* = null;
         var _loc29_:* = null;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:* = null;
         var _loc33_:* = null;
         var _loc6_:BitmapData = param2 as BitmapData;
         var _loc7_:ISkinLayout = _layoutsByState[param4];
         var _loc8_:ISkinTemplate = var_296[param4];
         if(_loc7_ == null)
         {
            Logger.log("LAYOUT NULL " + param4);
            _loc7_ = _layoutsByState["null"];
            _loc8_ = var_296["null"];
         }
         _loc9_ = uint(_loc7_.numChildren);
         if(_loc7_ != null && _loc9_ > 0)
         {
            _loc10_ = new Point();
            _loc16_ = param3.width - _loc7_.width;
            _loc17_ = param3.height - _loc7_.height;
            _loc18_ = 0;
            while(_loc18_ < _loc9_)
            {
               _loc11_ = _loc7_.getChildAt(_loc18_) as ISkinLayoutEntity;
               _loc12_ = _loc8_.getChildByName(_loc11_.name) as ISkinTemplateEntity;
               if(_loc12_ != null)
               {
                  _loc19_ = getBitmapFromCache(_loc8_,_loc11_.name);
                  _loc20_ = getAlphaFromCache(_loc8_,_loc11_.name);
                  _loc14_ = false;
                  _loc15_ = false;
                  _loc13_ = _loc11_.region.clone();
                  _loc13_.x += param3.x;
                  _loc13_.y += param3.y;
                  if(_loc11_.scaleH == SkinLayoutEntity.const_235)
                  {
                     _loc13_.x += _loc16_;
                  }
                  else if(_loc11_.scaleH == SkinLayoutEntity.const_422)
                  {
                     _loc14_ = true;
                     _loc13_.right += _loc16_;
                     if(_loc13_.width < 1)
                     {
                        break;
                     }
                  }
                  else if(_loc11_.scaleH == SkinLayoutEntity.const_224)
                  {
                     _loc14_ = true;
                     _loc13_.right += _loc16_;
                     if(_loc13_.width < 1)
                     {
                        break;
                     }
                  }
                  if(_loc11_.scaleV == SkinLayoutEntity.const_235)
                  {
                     _loc13_.y += _loc17_;
                  }
                  else if(_loc11_.scaleV == SkinLayoutEntity.const_422)
                  {
                     _loc15_ = true;
                     _loc13_.bottom += _loc17_;
                     if(_loc13_.height < 1)
                     {
                        break;
                     }
                  }
                  else if(_loc11_.scaleV == SkinLayoutEntity.const_224)
                  {
                     _loc15_ = true;
                     _loc13_.bottom += _loc17_;
                     if(_loc13_.height < 1)
                     {
                        break;
                     }
                  }
                  if(!_loc14_ && !_loc15_)
                  {
                     _loc6_.copyPixels(_loc19_,_loc19_.rect,_loc13_.topLeft,_loc20_,_loc10_,true);
                  }
                  else if(_loc11_.scaleV == SkinLayoutEntity.const_224 || _loc11_.scaleH == SkinLayoutEntity.const_224)
                  {
                     _loc21_ = _loc19_.width;
                     _loc22_ = _loc19_.height;
                     _loc23_ = _loc13_.width / _loc21_;
                     _loc24_ = _loc13_.height / _loc22_;
                     _loc25_ = _loc13_.width % _loc21_;
                     _loc26_ = _loc13_.height % _loc22_;
                     _loc27_ = new Point(_loc13_.x,_loc13_.y);
                     _loc28_ = new Rectangle(0,0,_loc25_,_loc19_.height);
                     _loc29_ = new Rectangle(0,0,_loc19_.width,_loc26_);
                     _loc30_ = 0;
                     while(_loc30_ < _loc24_)
                     {
                        _loc27_.x = _loc13_.x;
                        _loc31_ = 0;
                        while(_loc31_ < _loc23_)
                        {
                           _loc6_.copyPixels(_loc19_,_loc19_.rect,_loc27_,_loc20_,_loc10_,true);
                           _loc27_.x += _loc21_;
                           _loc31_++;
                        }
                        if(_loc25_ > 0)
                        {
                           _loc6_.copyPixels(_loc19_,_loc28_,_loc27_,_loc20_,_loc10_,true);
                        }
                        _loc27_.y += _loc22_;
                        _loc30_++;
                     }
                     if(_loc26_ > 0)
                     {
                        _loc27_.x = _loc13_.x;
                        _loc30_ = 0;
                        while(_loc30_ < _loc23_)
                        {
                           _loc6_.copyPixels(_loc19_,_loc29_,_loc27_,_loc20_,_loc10_,true);
                           _loc27_.x += _loc21_;
                           _loc30_++;
                        }
                     }
                  }
                  else
                  {
                     var_579.a = _loc13_.width / _loc19_.width;
                     var_579.d = _loc13_.height / _loc19_.height;
                     _loc32_ = new BitmapData(_loc13_.width,_loc13_.height,false);
                     _loc32_.draw(_loc19_,var_579);
                     _loc33_ = new BitmapData(_loc13_.width,_loc13_.height,true,0);
                     _loc33_.draw(_loc20_,var_579,null);
                     _loc6_.copyPixels(_loc32_,_loc32_.rect,_loc13_.topLeft,_loc33_,_loc10_,true);
                     _loc33_.dispose();
                     _loc32_.dispose();
                  }
               }
               _loc18_++;
            }
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return false;
      }
      
      private function drawBorders(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.bottom - 1;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right - 1)
         {
            param1.setPixel32(_loc4_,0,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc4_++;
         }
         _loc5_ = param2.top;
         while(_loc5_ < param2.bottom - 1)
         {
            param1.setPixel32(0,_loc5_,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc5_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         super.dispose();
         var_579 = null;
         for(_loc1_ in var_544)
         {
            _loc2_ = var_544[_loc1_] as BitmapData;
            _loc2_.dispose();
            delete var_544[_loc1_];
         }
         var_544 = null;
         for(_loc1_ in var_543)
         {
            _loc2_ = var_543[_loc1_] as BitmapData;
            _loc2_.dispose();
            delete var_543[_loc1_];
         }
         var_543 = null;
      }
      
      private function getAlphaFromCache(param1:ISkinTemplate, param2:String) : BitmapData
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:String = param2 + "@" + param1.name;
         var _loc4_:BitmapData = var_543[_loc3_];
         if(_loc4_ == null)
         {
            _loc5_ = param1.getChildByName(param2) as ISkinTemplateEntity;
            if(_loc5_ == null)
            {
               throw new Error("Template entity" + param2 + "not found!");
            }
            _loc6_ = BitmapDataAsset(param1.asset).content as BitmapData;
            if(_loc6_ == null)
            {
               throw new Error("Asset " + param1.asset + " not found!");
            }
            _loc4_ = new BitmapData(_loc5_.region.width,_loc5_.region.height,true);
            _loc4_.copyChannel(_loc6_,_loc5_.region,_loc4_.rect.topLeft,BitmapDataChannel.ALPHA,BitmapDataChannel.ALPHA);
            var_543[_loc3_] = _loc4_;
         }
         return _loc4_;
      }
      
      protected function drawStaticLayoutEntity(param1:BitmapData, param2:Rectangle, param3:ISkinLayout, param4:ISkinLayoutEntity, param5:ISkinTemplate, param6:ISkinTemplateEntity) : void
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc7_:Rectangle = param4.region.clone();
         _loc7_.x += param2.x;
         _loc7_.y += param2.y;
         switch(param6.type)
         {
            case "bitmap":
               _loc8_ = getBitmapFromCache(param5,param4.name);
               _loc9_ = getAlphaFromCache(param5,param4.name);
               if(param4.scaleH == SkinLayoutEntity.const_235)
               {
                  _loc7_.x += param2.width - param3.width;
               }
               if(param4.scaleV == SkinLayoutEntity.const_235)
               {
                  _loc7_.y += param2.height - param3.height;
               }
               param1.copyPixels(_loc8_,_loc8_.rect,_loc7_.topLeft,_loc9_,new Point(),true);
               break;
            case "fill":
               param1.fillRect(_loc7_,param4.color);
         }
      }
   }
}
