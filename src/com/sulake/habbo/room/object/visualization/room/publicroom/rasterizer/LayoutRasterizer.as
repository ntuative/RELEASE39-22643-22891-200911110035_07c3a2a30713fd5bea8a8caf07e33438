package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.Point;
   
   public class LayoutRasterizer
   {
       
      
      private var var_475:Array;
      
      private var var_1487:Vector3d;
      
      private var var_64:Map = null;
      
      private var var_1250:IRoomObjectSprite = null;
      
      private var var_1248:IRoomObjectSprite = null;
      
      private var var_999:String = "";
      
      private var var_835:String;
      
      private var _offsetX:int;
      
      private var var_681:int;
      
      private var var_405:Array;
      
      private var _graphicsChanged:Boolean = true;
      
      private var var_1249:int = -1;
      
      private var _assetCollection:IGraphicAssetCollection;
      
      private var var_1251:int = -1;
      
      private var var_476:Array;
      
      private var var_998:XMLList;
      
      public function LayoutRasterizer()
      {
         var_405 = [];
         var_476 = [];
         var_475 = [];
         super();
         var_64 = new Map();
         var_835 = "";
      }
      
      public function showAd(param1:IRoomGeometry, param2:String = "", param3:Boolean = false) : void
      {
         if(var_1249 == -1 || var_1251 == -1)
         {
            Logger.log("ERROR! Billboard sprite indices not defined, cannot show room ad!");
            return;
         }
         if(var_1250 == null || var_1248 == null)
         {
            Logger.log("ERROR! Billboard sprites not defined, cannot show room ad!");
            return;
         }
         setElementToSprite(var_1249,var_1250,param1,param2,param3);
         setElementToSprite(var_1251,var_1248,param1,param2,param3);
      }
      
      public function setElementToSprite(param1:int, param2:IRoomObjectSprite, param3:IRoomGeometry, param4:String = "", param5:Boolean = false) : void
      {
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc6_:LayoutRasterizerData = var_64.getValue(var_835);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:XMLList = _loc6_.elementList;
         if(_loc7_ == null)
         {
            return;
         }
         if(param1 < 0 || param1 >= _loc7_.length())
         {
            return;
         }
         var _loc8_:XML = _loc7_[param1];
         if(_loc8_ == null)
         {
            return;
         }
         var _loc9_:XMLList = _loc8_.visualization;
         if(_loc9_.length() == 0 || _loc9_.visualizationLayer.length() == 0)
         {
            return;
         }
         var _loc10_:XML = _loc9_.visualizationLayer[0];
         if(_loc10_ == null)
         {
            return;
         }
         var _loc11_:IGraphicAsset = _assetCollection.getAsset(_loc10_.@asset);
         if(_loc11_ == null)
         {
            return;
         }
         var _loc12_:Point = param3.getScreenPoint(new Vector3d(0,0,0));
         var _loc13_:Point = param3.getScreenPoint(var_1487);
         _loc13_.x -= _loc12_.x;
         _loc13_.y -= _loc12_.y;
         _loc13_.x = Math.round(_loc13_.x);
         _loc13_.y = Math.round(_loc13_.y);
         param2.asset = _loc11_.asset;
         param2.offsetX = int(_loc10_.@x) + _loc11_.offsetX + _loc13_.x;
         param2.offsetY = int(_loc10_.@y) + _loc11_.offsetY + _loc13_.y;
         param2.blendMode = getBlendMode(String(_loc10_.@ink));
         param2.capturesMouse = false;
         if(parseInt(_loc10_.@capturesMouse) > 0)
         {
            param2.capturesMouse = true;
            param2.tag = String(_loc8_.@id);
         }
         if(String(_loc10_.@z) != "")
         {
            param2.relativeDepth = -Number(_loc10_.@z) / Math.sqrt(2) - 0.00001 * param1;
         }
         else
         {
            param2.relativeDepth = -(0.001 * param1);
         }
         if(_loc10_.@blend.toString().length > 0)
         {
            param2.alpha = int(Number(_loc10_.@blend) * 2.55);
         }
         if(_loc10_.@flipH.toString().length > 0)
         {
            param2.flipH = Boolean(_loc10_.@flipH);
         }
         if(_loc8_.@id.toString().length > 0)
         {
            _loc14_ = String(_loc8_.@id);
            if(_loc14_ == "billboard_bg")
            {
               var_1249 = param1;
               var_1250 = param2;
               param2.visible = false;
               param2.alpha = 0;
               if(param4 != "")
               {
                  param2.visible = true;
                  param2.alpha = 255;
                  _loc15_ = String(_loc10_.@asset);
                  if(_loc15_.indexOf("left") > -1)
                  {
                     var_999 = RoomObjectVariableEnum.const_835;
                  }
                  if(_loc15_.indexOf("right") > -1)
                  {
                     var_999 = RoomObjectVariableEnum.const_779;
                  }
               }
            }
            if(_loc14_ == "billboard_img")
            {
               var_1251 = param1;
               var_1248 = param2;
               param2.visible = false;
               param2.alpha = 0;
               if(param4 != "")
               {
                  param2.visible = true;
                  param2.alpha = 255;
                  if(param5)
                  {
                     _loc11_ = _assetCollection.getAsset(param4);
                     param2.capturesMouse = true;
                     param2.tag = RoomObjectVariableEnum.const_414;
                  }
                  else
                  {
                     _loc11_ = _assetCollection.getAsset(var_999);
                  }
                  if(_loc11_ != null)
                  {
                     param2.asset = _loc11_.asset;
                     _loc16_ = param2.asset.content as BitmapData;
                     if(_loc16_ != null)
                     {
                        param2.offsetX -= _loc16_.width / 2;
                        param2.offsetY -= _loc16_.height / 2;
                     }
                  }
               }
            }
            if(var_405.indexOf(_loc14_) >= 0 && _graphicsChanged)
            {
               param1 = var_405.indexOf(_loc14_);
               if(true)
               {
                  _loc11_ = _assetCollection.getAsset(var_476[param1]);
                  if(_loc11_ != null)
                  {
                     param2.asset = _loc11_.asset;
                  }
               }
               if(true)
               {
                  param2.alpha = var_475[param1];
               }
               var_405.splice(param1,1);
               var_476.splice(param1,1);
               var_475.splice(param1,1);
               if(false)
               {
                  _graphicsChanged = false;
               }
            }
         }
      }
      
      public function exchangeElementGraphics(param1:String, param2:String) : void
      {
         _graphicsChanged = true;
         var_405.push(param1);
         var_476.push(param2);
         var_475.push(-1);
      }
      
      public function initialize(param1:XML) : void
      {
         var _loc2_:String = String(param1.@name);
         var _loc3_:LayoutRasterizerData = new LayoutRasterizerData(param1);
         var_64.add(_loc2_,_loc3_);
         var_1487 = new Vector3d(-0.5,0.5,0);
         _graphicsChanged = false;
      }
      
      public function changeElementAlpha(param1:String, param2:Number) : void
      {
         _graphicsChanged = true;
         var_405.push(param1);
         var_476.push("");
         var_475.push(param2);
      }
      
      public function set layout(param1:String) : void
      {
         var_835 = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _assetCollection = null;
         var_998 = null;
         var_405 = null;
         var_476 = null;
         var_475 = null;
         if(var_64 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_64.length)
            {
               _loc2_ = var_64.getWithIndex(_loc1_) as LayoutRasterizerData;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_64.dispose();
            var_64 = null;
         }
      }
      
      private function getBlendMode(param1:String) : String
      {
         var _loc2_:String = "null";
         switch(param1)
         {
            case "ADD":
               _loc2_ = "null";
               break;
            case "SUBTRACT":
               _loc2_ = "null";
               break;
            case "DARKEN":
               _loc2_ = "null";
         }
         return _loc2_;
      }
      
      public function get graphicsChanged() : Boolean
      {
         return _graphicsChanged;
      }
      
      public function elementCount() : int
      {
         var _loc1_:LayoutRasterizerData = var_64.getValue(var_835);
         if(_loc1_ == null)
         {
            return 0;
         }
         var _loc2_:XMLList = _loc1_.elementList;
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.length();
      }
      
      public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         _assetCollection = param1;
      }
   }
}
