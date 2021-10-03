package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterial;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualizationLayer;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.XMLValidator;
   import flash.display.BitmapData;
   
   public class LandscapeRasterizer extends PlaneRasterizer
   {
      
      private static const const_323:int = 500;
       
      
      private var _landscapeHeight:int = 0;
      
      private var var_2066:int = 0;
      
      private var var_310:Map = null;
      
      public function LandscapeRasterizer()
      {
         super();
         var_310 = new Map();
      }
      
      override public function initializeDimensions(param1:int, param2:int) : Boolean
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         var_2066 = param1;
         _landscapeHeight = param2;
         return true;
      }
      
      private function parseLandscapes(param1:XML) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = NaN;
         var _loc16_:* = NaN;
         var _loc17_:int = 0;
         var _loc18_:* = null;
         var _loc19_:int = 0;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:int = 0;
         var _loc24_:* = null;
         var _loc25_:int = 0;
         var _loc26_:* = null;
         var _loc27_:* = 0;
         var _loc28_:* = null;
         var _loc29_:* = null;
         var _loc30_:* = null;
         var _loc31_:* = null;
         var _loc32_:int = 0;
         var _loc33_:* = null;
         var _loc34_:int = 0;
         var _loc35_:* = null;
         var _loc36_:* = NaN;
         var _loc37_:* = NaN;
         var _loc38_:* = NaN;
         var _loc39_:* = NaN;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:* = ["id","assetId"];
         var _loc3_:int = Math.random() * 654321;
         var _loc4_:XMLList = param1.landscape;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length())
         {
            _loc6_ = _loc4_[_loc5_];
            if(XMLValidator.checkRequiredAttributes(_loc6_,["id"]))
            {
               _loc7_ = _loc6_.@id;
               _loc8_ = _loc6_.animatedVisualization;
               _loc9_ = new LandscapePlane();
               _loc10_ = 0;
               while(_loc10_ < _loc8_.length())
               {
                  _loc11_ = _loc8_[_loc10_];
                  if(XMLValidator.checkRequiredAttributes(_loc11_,["size"]))
                  {
                     _loc12_ = parseInt(_loc11_.@size);
                     _loc13_ = _loc11_.@horizontalAngle;
                     _loc14_ = _loc11_.@verticalAngle;
                     _loc15_ = 0;
                     if(_loc13_ != "")
                     {
                        _loc15_ = Number(parseFloat(_loc13_));
                     }
                     _loc16_ = 0;
                     if(_loc14_ != "")
                     {
                        _loc16_ = Number(parseFloat(_loc14_));
                     }
                     _loc17_ = _loc11_.visualizationLayer.length() + _loc11_.animationLayer.length();
                     _loc18_ = _loc9_.createPlaneVisualization(_loc12_,_loc17_,_loc15_,_loc16_);
                     if(_loc18_ != null)
                     {
                        Randomizer.setSeed(_loc3_);
                        _loc19_ = 0;
                        while(_loc19_ < _loc11_.children().length())
                        {
                           _loc20_ = _loc11_.children()[_loc19_];
                           if(_loc20_.name() == "visualizationLayer")
                           {
                              _loc21_ = _loc20_;
                              _loc22_ = null;
                              _loc23_ = 0;
                              if(XMLValidator.checkRequiredAttributes(_loc21_,["materialId"]))
                              {
                                 _loc29_ = _loc21_.@materialId;
                                 _loc22_ = getMaterial(_loc29_);
                              }
                              _loc24_ = _loc21_.@offset;
                              _loc25_ = 0;
                              if(_loc24_.length > 0)
                              {
                                 _loc25_ = parseInt(_loc24_);
                              }
                              _loc26_ = _loc21_.@color;
                              _loc27_ = 0;
                              if(_loc26_.length > 0)
                              {
                                 _loc27_ = uint(parseInt(_loc26_));
                              }
                              _loc28_ = _loc21_.@align;
                              if(_loc28_ == "bottom")
                              {
                                 _loc23_ = 0;
                              }
                              else if(_loc28_ == "top")
                              {
                                 _loc23_ = 0;
                              }
                              _loc18_.setLayer(_loc19_,_loc22_,_loc27_,_loc23_,_loc25_);
                           }
                           else if(_loc20_.name() == "animationLayer")
                           {
                              _loc30_ = _loc20_.animationItem;
                              _loc31_ = <animation/>;
                              _loc32_ = 0;
                              while(_loc32_ < _loc30_.length())
                              {
                                 _loc33_ = _loc30_[_loc32_] as XML;
                                 if(_loc33_ != null)
                                 {
                                    if(XMLValidator.checkRequiredAttributes(_loc33_,_loc2_))
                                    {
                                       _loc34_ = parseInt(_loc33_.@id);
                                       _loc35_ = _loc33_.@assetId;
                                       _loc36_ = 0;
                                       _loc37_ = 0;
                                       _loc36_ = Number(getCoordinateValue(_loc33_.@x,_loc33_.@randomX));
                                       _loc37_ = Number(getCoordinateValue(_loc33_.@y,_loc33_.@randomY));
                                       _loc38_ = 0;
                                       _loc39_ = 0;
                                       _loc38_ = Number(parseFloat(_loc33_.@speedX));
                                       _loc39_ = Number(parseFloat(_loc33_.@speedY));
                                       _loc31_.appendChild(<item x="{_loc36_}" y="{_loc37_}" speedX="{_loc38_}" speedY="{_loc39_}" asset="{_loc35_}"/>);
                                    }
                                 }
                                 _loc32_++;
                              }
                              _loc18_.setAnimationLayer(_loc19_,_loc31_,assetCollection);
                           }
                           _loc19_++;
                        }
                     }
                  }
                  _loc10_++;
               }
               if(var_310.getValue(_loc7_) == null)
               {
                  var_310.add(_loc7_,_loc9_);
               }
               else
               {
                  _loc9_.dispose();
               }
            }
            _loc5_++;
         }
      }
      
      private function getCoordinateValue(param1:String, param2:String) : Number
      {
         var _loc4_:* = NaN;
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         var _loc3_:* = 0;
         if(param1.length > 0)
         {
            if(param1.charAt(param1.length - 1) == "%")
            {
               param1 = param1.substr(0,param1.length - 1);
               _loc3_ = Number(parseFloat(param1) / 100);
            }
         }
         if(param2.length > 0)
         {
            _loc4_ = 10000;
            _loc5_ = Randomizer.getValues(1,0,_loc4_);
            _loc6_ = _loc5_[0] / _loc4_;
            if(param2.charAt(param2.length - 1) == "%")
            {
               param2 = param2.substr(0,param2.length - 1);
               _loc3_ += _loc6_ * parseFloat(param2) / 100;
            }
         }
         return _loc3_;
      }
      
      override public function getTextureIdentifier(param1:Number, param2:IVector3d) : String
      {
         if(param2 != null)
         {
            if(param2.x < 0)
            {
               return String(param1 + "_0");
            }
            return String(param1 + "_1");
         }
         return super.getTextureIdentifier(param1,param2);
      }
      
      override public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData
      {
         var _loc13_:LandscapePlane = var_310.getValue(param2);
         if(_loc13_ == null)
         {
            _loc13_ = var_310.getValue(const_691);
         }
         if(_loc13_ == null)
         {
            return null;
         }
         if(param1 != null)
         {
            param1.fillRect(param1.rect,16777215);
         }
         var _loc14_:BitmapData = _loc13_.render(param1,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         if(_loc14_ != null && _loc14_ != param1)
         {
            _loc14_ = _loc14_.clone();
         }
         var _loc15_:* = null;
         if(!_loc13_.isStatic(param5) && const_323 > 0)
         {
            _loc15_ = new PlaneBitmapData(_loc14_,Math.round(param12 / const_323) * const_323 + const_323);
         }
         else
         {
            _loc15_ = new PlaneBitmapData(_loc14_,-1);
         }
         return _loc15_;
      }
      
      override public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         super.initializeAssetCollection(param1);
         if(data == null)
         {
            return;
         }
         var _loc2_:XMLList = data.landscapes;
         if(_loc2_.length() > 0)
         {
            parseLandscapes(_loc2_[0]);
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(var_310 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_310.length)
            {
               _loc2_ = var_310.getWithIndex(_loc1_) as LandscapePlane;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_310.dispose();
            var_310 = null;
         }
         super.dispose();
      }
   }
}
