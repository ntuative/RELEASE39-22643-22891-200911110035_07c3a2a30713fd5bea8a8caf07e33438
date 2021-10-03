package com.sulake.habbo.room.object.visualization.room.publicroom
{
   import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData;
   import com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer.LayoutRasterizer;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   
   public class PublicRoomVisualizationData extends RoomVisualizationData
   {
       
      
      private var _layoutRasterizer:LayoutRasterizer;
      
      private var var_676:Boolean = false;
      
      public function PublicRoomVisualizationData()
      {
         super();
         _layoutRasterizer = new LayoutRasterizer();
      }
      
      override public function initialize(param1:XML) : Boolean
      {
         var _loc4_:* = null;
         if(!super.initialize(param1))
         {
            return false;
         }
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:XMLList = param1.layoutData;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length())
         {
            _loc4_ = _loc2_[_loc3_];
            _layoutRasterizer.initialize(_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      override protected function reset() : void
      {
         super.reset();
      }
      
      public function get layoutRasterizer() : LayoutRasterizer
      {
         return _layoutRasterizer;
      }
      
      override public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         if(initialized)
         {
            return;
         }
         super.initializeAssetCollection(param1);
         _layoutRasterizer.initializeAssetCollection(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_layoutRasterizer != null)
         {
            _layoutRasterizer.dispose();
            _layoutRasterizer = null;
         }
      }
   }
}
