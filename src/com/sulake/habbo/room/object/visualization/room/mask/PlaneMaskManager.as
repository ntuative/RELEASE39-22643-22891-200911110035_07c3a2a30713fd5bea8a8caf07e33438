package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.XMLValidator;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class PlaneMaskManager
   {
       
      
      private var var_146:Map = null;
      
      private var _data:XML = null;
      
      private var _assetCollection:IGraphicAssetCollection = null;
      
      public function PlaneMaskManager()
      {
         super();
         var_146 = new Map();
      }
      
      public function get data() : XML
      {
         return _data;
      }
      
      private function parseMaskBitmaps(param1:XMLList, param2:PlaneMaskVisualization, param3:IGraphicAssetCollection) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = null;
         var _loc11_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param1.length())
         {
            _loc5_ = param1[_loc4_];
            if(XMLValidator.checkRequiredAttributes(_loc5_,["assetName"]))
            {
               _loc6_ = 0;
               _loc7_ = 0;
               _loc8_ = 0;
               _loc9_ = 0;
               if(String(_loc5_.@normalMinX) != "")
               {
                  _loc6_ = Number(parseFloat(_loc5_.@normalMinX));
               }
               if(String(_loc5_.@normalMaxX) != "")
               {
                  _loc7_ = Number(parseFloat(_loc5_.@normalMaxX));
               }
               if(String(_loc5_.@normalMinY) != "")
               {
                  _loc8_ = Number(parseFloat(_loc5_.@normalMinY));
               }
               if(String(_loc5_.@normalMaxY) != "")
               {
                  _loc9_ = Number(parseFloat(_loc5_.@normalMaxY));
               }
               _loc10_ = _loc5_.@assetName;
               _loc11_ = param3.getAsset(_loc10_);
               if(_loc11_ != null)
               {
                  param2.addBitmap(_loc11_,_loc6_,_loc7_,_loc8_,_loc9_);
               }
            }
            _loc4_++;
         }
      }
      
      private function parseMasks(param1:XML, param2:IGraphicAssetCollection) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc3_:* = ["id"];
         var _loc4_:* = ["size"];
         var _loc5_:XMLList = param1.mask;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc7_ = _loc5_[_loc6_];
            if(XMLValidator.checkRequiredAttributes(_loc7_,_loc3_))
            {
               _loc8_ = _loc7_.@id;
               if(var_146.getValue(_loc8_) == null)
               {
                  _loc9_ = new PlaneMask();
                  _loc10_ = _loc7_.maskVisualization;
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_.length())
                  {
                     _loc12_ = _loc10_[_loc11_];
                     if(XMLValidator.checkRequiredAttributes(_loc12_,_loc4_))
                     {
                        _loc13_ = parseInt(_loc12_.@size);
                        _loc14_ = _loc9_.createMaskVisualization(_loc13_);
                        if(_loc14_ != null)
                        {
                           _loc15_ = _loc12_.bitmap;
                           parseMaskBitmaps(_loc15_,_loc14_,param2);
                        }
                     }
                     _loc11_++;
                  }
                  var_146.add(_loc8_,_loc9_);
               }
            }
            _loc6_++;
         }
      }
      
      public function updateMask(param1:BitmapData, param2:String, param3:Number, param4:IVector3d, param5:int, param6:int) : Boolean
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:* = NaN;
         var _loc16_:* = NaN;
         var _loc7_:PlaneMask = var_146.getValue(param2) as PlaneMask;
         if(_loc7_ != null)
         {
            _loc8_ = _loc7_.getGraphicAsset(param3,param4);
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.asset as BitmapDataAsset;
               if(_loc9_ != null)
               {
                  _loc10_ = _loc9_.content as BitmapData;
                  if(_loc10_ != null)
                  {
                     _loc11_ = new Point(param5 + _loc8_.offsetX,param6 + _loc8_.offsetY);
                     _loc12_ = new Matrix();
                     _loc13_ = 1;
                     _loc14_ = 1;
                     _loc15_ = 0;
                     _loc16_ = 0;
                     if(_loc8_.flipH)
                     {
                        _loc13_ = -1;
                        _loc15_ = Number(_loc10_.width);
                     }
                     if(_loc8_.flipV)
                     {
                        _loc14_ = -1;
                        _loc16_ = Number(_loc10_.height);
                     }
                     _loc12_.scale(_loc13_,_loc14_);
                     _loc12_.translate(_loc11_.x + _loc15_,_loc11_.y + _loc16_);
                     param1.draw(_loc10_,_loc12_);
                  }
               }
            }
         }
         return true;
      }
      
      public function initialize(param1:XML) : void
      {
         _data = param1;
      }
      
      public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         if(data == null)
         {
            return;
         }
         _assetCollection = param1;
         parseMasks(data,param1);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _assetCollection = null;
         _data = null;
         if(var_146 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_146.length)
            {
               _loc2_ = var_146.getWithIndex(_loc1_) as PlaneMask;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_146.dispose();
         }
      }
   }
}
