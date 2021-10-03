package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import flash.display.BitmapData;
   
   public class GraphicAsset implements IGraphicAsset
   {
       
      
      private var _height:int;
      
      private var _width:int;
      
      private var var_1367:Boolean;
      
      private var _offsetX:int;
      
      private var var_681:int;
      
      private var _name:String;
      
      private var var_726:IAsset;
      
      private var var_1368:Boolean;
      
      public function GraphicAsset(param1:String, param2:IAsset, param3:Boolean, param4:Boolean, param5:int, param6:int)
      {
         var _loc8_:* = null;
         super();
         _name = param1;
         var _loc7_:BitmapDataAsset = param2 as BitmapDataAsset;
         if(_loc7_ != null)
         {
            _loc8_ = _loc7_.content as BitmapData;
         }
         if(_loc8_ != null)
         {
            var_726 = param2;
            _width = _loc8_.width;
            _height = _loc8_.height;
         }
         else
         {
            var_726 = null;
            _width = 0;
            _height = 0;
         }
         var_1368 = param3;
         var_1367 = param4;
         _offsetX = param5;
         var_681 = param6;
      }
      
      public function get flipH() : Boolean
      {
         return var_1368;
      }
      
      public function get flipV() : Boolean
      {
         return var_1367;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function dispose() : void
      {
         var_726 = null;
      }
      
      public function get offsetX() : int
      {
         if(!var_1368)
         {
            return _offsetX;
         }
         return -(_width + _offsetX);
      }
      
      public function get offsetY() : int
      {
         if(!var_1367)
         {
            return var_681;
         }
         return -(_height + var_681);
      }
      
      public function get asset() : IAsset
      {
         return var_726;
      }
   }
}
