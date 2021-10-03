package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Rasterizer;
   import com.sulake.room.utils.XMLValidator;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneRasterizer implements IPlaneRasterizer
   {
      
      protected static const const_691:String = "default";
       
      
      private var _data:XML = null;
      
      private var var_96:Map = null;
      
      private var _materials:Map = null;
      
      private var _assetCollection:IGraphicAssetCollection = null;
      
      public function PlaneRasterizer()
      {
         super();
         var_96 = new Map();
         _materials = new Map();
      }
      
      private function parsePlaneMaterialCells(param1:XML) : Array
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:int = 0;
         var _loc20_:* = null;
         var _loc21_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:* = [];
         var _loc3_:XMLList = param1.materialCell;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length())
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = _loc5_.@textureId;
            _loc7_ = null;
            _loc8_ = null;
            _loc9_ = null;
            _loc10_ = 0;
            _loc11_ = _loc5_.extraItemData;
            if(_loc11_.length() > 0)
            {
               _loc14_ = _loc11_[0];
               _loc15_ = _loc14_.extraItemTypes;
               _loc16_ = _loc14_.offsets;
               if(_loc15_.length() > 0 && _loc16_.length() > 0)
               {
                  _loc17_ = _loc15_[0];
                  _loc18_ = _loc16_[0];
                  _loc7_ = parseExtraItemTypes(_loc17_);
                  _loc9_ = parseExtraItemOffsets(_loc18_);
                  _loc10_ = _loc9_.length;
                  if(String(_loc14_.@limitMax) != "")
                  {
                     _loc10_ = parseInt(_loc14_.@limitMax);
                  }
               }
            }
            if(_loc7_ != null)
            {
               _loc8_ = [];
               _loc19_ = 0;
               while(_loc19_ < _loc7_.length)
               {
                  _loc20_ = _loc7_[_loc4_];
                  _loc21_ = _assetCollection.getAsset(_loc20_);
                  if(_loc21_ != null)
                  {
                     _loc8_.push(_loc21_);
                  }
                  _loc19_++;
               }
            }
            _loc12_ = getTexture(_loc6_);
            _loc13_ = new PlaneMaterialCell(_loc12_,_loc8_,_loc9_,_loc10_);
            _loc2_.push(_loc13_);
            _loc4_++;
         }
         if(_loc2_.length == 0)
         {
            _loc2_ = null;
         }
         return _loc2_;
      }
      
      private function parsePlaneMaterials(param1:XML) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = NaN;
         var _loc15_:* = NaN;
         var _loc16_:* = NaN;
         var _loc17_:* = NaN;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:int = 0;
         var _loc21_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.material;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length())
         {
            _loc4_ = _loc2_[_loc3_];
            if(XMLValidator.checkRequiredAttributes(_loc4_,["id"]))
            {
               _loc5_ = _loc4_.@id;
               _loc6_ = new PlaneMaterial();
               _loc7_ = _loc4_.materialCellMatrix;
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length())
               {
                  _loc9_ = _loc7_[_loc8_];
                  _loc10_ = _loc9_.@repeatMode;
                  _loc11_ = _loc9_.@align;
                  _loc12_ = 0;
                  switch(_loc10_)
                  {
                     case "borders":
                        _loc12_ = 0;
                        break;
                     case "center":
                        _loc12_ = 0;
                        break;
                     case "first":
                        _loc12_ = 0;
                        break;
                     case "last":
                        _loc12_ = 0;
                        break;
                     case "random":
                        _loc12_ = 0;
                  }
                  _loc13_ = 0;
                  switch(_loc11_)
                  {
                     case "top":
                        _loc13_ = 0;
                        break;
                     case "bottom":
                        _loc13_ = 0;
                        break;
                  }
                  _loc14_ = 0;
                  _loc15_ = 0;
                  _loc16_ = 0;
                  _loc17_ = 0;
                  if(String(_loc9_.@normalMinX) != "")
                  {
                     _loc14_ = Number(parseFloat(_loc9_.@normalMinX));
                  }
                  if(String(_loc9_.@normalMaxX) != "")
                  {
                     _loc15_ = Number(parseFloat(_loc9_.@normalMaxX));
                  }
                  if(String(_loc9_.@normalMinY) != "")
                  {
                     _loc16_ = Number(parseFloat(_loc9_.@normalMinY));
                  }
                  if(String(_loc9_.@normalMaxY) != "")
                  {
                     _loc17_ = Number(parseFloat(_loc9_.@normalMaxY));
                  }
                  _loc18_ = _loc9_.materialCellColumn;
                  if(_loc18_.length() > 0)
                  {
                     _loc19_ = null;
                     _loc19_ = _loc6_.addMaterialCellMatrix(_loc18_.length(),_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_);
                     _loc20_ = 0;
                     while(_loc20_ < _loc18_.length())
                     {
                        _loc21_ = _loc18_[_loc20_];
                        parsePlaneMaterialCellColumn(_loc21_,_loc19_,_loc20_);
                        _loc20_++;
                     }
                  }
                  _materials.add(_loc5_,_loc6_);
                  _loc8_++;
               }
            }
            _loc3_++;
         }
      }
      
      public function initializeDimensions(param1:int, param2:int) : Boolean
      {
         return true;
      }
      
      public function getTextureIdentifier(param1:Number, param2:IVector3d) : String
      {
         return String(param1);
      }
      
      private function parseTextures(param1:XML, param2:IGraphicAssetCollection) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc3_:XMLList = param1.texture;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length())
         {
            _loc5_ = _loc3_[_loc4_];
            if(XMLValidator.checkRequiredAttributes(_loc5_,["id"]))
            {
               _loc6_ = _loc5_.@id;
               if(var_96.getValue(_loc6_) == null)
               {
                  _loc7_ = new PlaneTexture();
                  _loc8_ = _loc5_.bitmap;
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_.length())
                  {
                     _loc10_ = _loc8_[_loc9_];
                     if(XMLValidator.checkRequiredAttributes(_loc10_,["assetName"]))
                     {
                        _loc11_ = 0;
                        _loc12_ = 0;
                        _loc13_ = 0;
                        _loc14_ = 0;
                        if(String(_loc10_.@normalMinX) != "")
                        {
                           _loc11_ = Number(parseFloat(_loc10_.@normalMinX));
                        }
                        if(String(_loc10_.@normalMaxX) != "")
                        {
                           _loc12_ = Number(parseFloat(_loc10_.@normalMaxX));
                        }
                        if(String(_loc10_.@normalMinY) != "")
                        {
                           _loc13_ = Number(parseFloat(_loc10_.@normalMinY));
                        }
                        if(String(_loc10_.@normalMaxY) != "")
                        {
                           _loc14_ = Number(parseFloat(_loc10_.@normalMaxY));
                        }
                        _loc15_ = _loc10_.@assetName;
                        _loc16_ = param2.getAsset(_loc15_);
                        if(_loc16_ != null)
                        {
                           _loc17_ = _loc16_.asset as BitmapDataAsset;
                           if(_loc17_ != null)
                           {
                              _loc18_ = _loc17_.content as BitmapData;
                              if(_loc18_ != null)
                              {
                                 if(_loc16_.flipH)
                                 {
                                    _loc18_ = Rasterizer.getFlipHBitmapData(_loc18_);
                                 }
                                 else
                                 {
                                    _loc18_ = _loc18_.clone();
                                 }
                                 _loc7_.addBitmap(_loc18_,_loc11_,_loc12_,_loc13_,_loc14_);
                              }
                           }
                        }
                     }
                     _loc9_++;
                  }
                  var_96.add(_loc6_,_loc7_);
               }
            }
            _loc4_++;
         }
      }
      
      public function initialize(param1:XML) : void
      {
         _data = param1;
      }
      
      public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData
      {
         return null;
      }
      
      private function parseExtraItemOffsets(param1:XML) : Array
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:* = [];
         var _loc3_:* = ["x","y"];
         if(param1 != null)
         {
            _loc4_ = param1.offset;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc6_ = _loc4_[_loc5_];
               if(XMLValidator.checkRequiredAttributes(_loc6_,_loc3_))
               {
                  _loc7_ = parseInt(_loc6_.@x);
                  _loc8_ = parseInt(_loc6_.@y);
                  _loc2_.push(new Point(_loc7_,_loc8_));
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      private function parseExtraItemTypes(param1:XML) : Array
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = [];
         var _loc3_:* = ["assetName"];
         if(param1 != null)
         {
            _loc4_ = param1.extraItemType;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc6_ = _loc4_[_loc5_];
               if(XMLValidator.checkRequiredAttributes(_loc6_,_loc3_))
               {
                  _loc7_ = _loc6_.@assetName;
                  _loc2_.push(_loc7_);
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      protected function getMaterial(param1:String) : PlaneMaterial
      {
         return _materials.getValue(param1) as PlaneMaterial;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         if(_materials != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _materials.length)
            {
               _loc2_ = _materials.getWithIndex(_loc1_) as PlaneMaterial;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            _materials.dispose();
            _materials = null;
         }
         if(var_96 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_96.length)
            {
               _loc3_ = var_96.getWithIndex(_loc1_) as PlaneTexture;
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               _loc1_++;
            }
            var_96.dispose();
            var_96 = null;
         }
         _data = null;
         _assetCollection = null;
      }
      
      protected function parseVisualizations(param1:Plane, param2:XMLList) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:* = null;
         var _loc17_:int = 0;
         var _loc18_:* = null;
         var _loc19_:* = 0;
         var _loc20_:* = null;
         var _loc21_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param2.length())
         {
            _loc4_ = param2[_loc3_];
            if(XMLValidator.checkRequiredAttributes(_loc4_,["size"]))
            {
               _loc5_ = parseInt(_loc4_.@size);
               _loc6_ = _loc4_.@horizontalAngle;
               _loc7_ = _loc4_.@verticalAngle;
               _loc8_ = 0;
               if(_loc6_ != "")
               {
                  _loc8_ = Number(parseFloat(_loc6_));
               }
               _loc9_ = 0;
               if(_loc7_ != "")
               {
                  _loc9_ = Number(parseFloat(_loc7_));
               }
               _loc10_ = _loc4_.visualizationLayer;
               _loc11_ = param1.createPlaneVisualization(_loc5_,_loc10_.length(),_loc8_,_loc9_);
               if(_loc11_ != null)
               {
                  _loc12_ = 0;
                  while(_loc12_ < _loc10_.length())
                  {
                     _loc13_ = _loc10_[_loc12_];
                     _loc14_ = null;
                     _loc15_ = 0;
                     if(XMLValidator.checkRequiredAttributes(_loc13_,["materialId"]))
                     {
                        _loc21_ = _loc13_.@materialId;
                        _loc14_ = getMaterial(_loc21_);
                     }
                     _loc16_ = _loc13_.@offset;
                     _loc17_ = 0;
                     if(_loc16_.length > 0)
                     {
                        _loc17_ = parseInt(_loc16_);
                     }
                     _loc18_ = _loc13_.@color;
                     _loc19_ = 0;
                     if(_loc18_.length > 0)
                     {
                        _loc19_ = uint(parseInt(_loc18_));
                     }
                     _loc20_ = _loc13_.@align;
                     if(_loc20_ == "bottom")
                     {
                        _loc15_ = 0;
                     }
                     else if(_loc20_ == "top")
                     {
                        _loc15_ = 0;
                     }
                     _loc11_.setLayer(_loc12_,_loc14_,_loc19_,_loc15_,_loc17_);
                     _loc12_++;
                  }
               }
            }
            _loc3_++;
         }
      }
      
      protected function getTexture(param1:String) : PlaneTexture
      {
         return var_96.getValue(param1) as PlaneTexture;
      }
      
      private function parsePlaneMaterialCellColumn(param1:XML, param2:PlaneMaterialCellMatrix, param3:int) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc4_:String = param1.@repeatMode;
         var _loc5_:int = parseInt(param1.@width);
         var _loc6_:int = 0;
         switch(_loc4_)
         {
            case "borders":
               _loc6_ = 0;
               break;
            case "center":
               _loc6_ = 0;
               break;
            case "first":
               _loc6_ = 0;
               break;
            case "last":
               _loc6_ = 0;
               break;
            case "none":
               _loc6_ = 0;
         }
         var _loc7_:Array = parsePlaneMaterialCells(param1);
         param2.createColumn(param3,_loc5_,_loc7_,_loc6_);
      }
      
      protected function get data() : XML
      {
         return _data;
      }
      
      protected function get assetCollection() : IGraphicAssetCollection
      {
         return _assetCollection;
      }
      
      public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         if(data == null)
         {
            return;
         }
         _assetCollection = param1;
         var _loc2_:XMLList = data.textures;
         if(_loc2_.length() > 0)
         {
            parseTextures(_loc2_[0],param1);
         }
         var _loc3_:XMLList = data.materials;
         if(_loc3_.length() > 0)
         {
            parsePlaneMaterials(_loc3_[0]);
         }
      }
   }
}
