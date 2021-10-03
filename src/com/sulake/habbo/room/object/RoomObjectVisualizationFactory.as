package com.sulake.habbo.room.object
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData;
   import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureBottleVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureHabboWheelVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurniturePartyBeamerVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurniturePlanetSystemVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurniturePosterVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureQueueTileVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureShadowVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureValRandomizerVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
   import com.sulake.habbo.room.object.visualization.pet.PetVisualization;
   import com.sulake.habbo.room.object.visualization.pet.PetVisualizationData;
   import com.sulake.habbo.room.object.visualization.room.RoomTileCursorVisualization;
   import com.sulake.habbo.room.object.visualization.room.RoomVisualization;
   import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData;
   import com.sulake.habbo.room.object.visualization.room.SelectionArrowVisualization;
   import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomParkVisualization;
   import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomPoolVisualization;
   import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomVisualization;
   import com.sulake.habbo.room.object.visualization.room.publicroom.PublicRoomVisualizationData;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.room.object.IRoomObjectVisualizationFactory;
   import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.utils.GraphicAssetCollection;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   
   public class RoomObjectVisualizationFactory extends Component implements IRoomObjectVisualizationFactory
   {
       
      
      private var var_436:Map;
      
      private var var_760:IAvatarRenderManager = null;
      
      public function RoomObjectVisualizationFactory(param1:IContext, param2:uint = 0)
      {
         super(param1,param2);
         var_436 = new Map();
         queueInterface(new IIDAvatarRenderManager(),avatarReady);
      }
      
      public function createGraphicAssetCollection() : IGraphicAssetCollection
      {
         return new GraphicAssetCollection();
      }
      
      public function getRoomObjectVisualizationData(param1:String, param2:String, param3:XML) : IRoomObjectVisualizationData
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         _loc4_ = var_436.getValue(param1) as IRoomObjectVisualizationData;
         if(_loc4_ != null)
         {
            return _loc4_;
         }
         var _loc5_:* = null;
         switch(param2)
         {
            case RoomObjectVisualizationEnum.const_811:
            case RoomObjectVisualizationEnum.const_222:
            case RoomObjectVisualizationEnum.const_242:
               _loc5_ = PublicRoomVisualizationData;
               break;
            case RoomObjectVisualizationEnum.const_156:
               _loc5_ = RoomVisualizationData;
               break;
            case RoomObjectVisualizationEnum.const_112:
               _loc5_ = AvatarVisualizationData;
               break;
            case RoomObjectVisualizationEnum.BOT:
               _loc5_ = AvatarVisualizationData;
               break;
            case RoomObjectVisualizationEnum.PET:
               _loc5_ = PetVisualizationData;
               break;
            case RoomObjectVisualizationEnum.const_869:
               _loc5_ = FurnitureVisualizationData;
               break;
            case RoomObjectVisualizationEnum.const_946:
            case RoomObjectVisualizationEnum.const_738:
            case RoomObjectVisualizationEnum.const_249:
            case RoomObjectVisualizationEnum.const_757:
            case RoomObjectVisualizationEnum.const_859:
            case RoomObjectVisualizationEnum.const_252:
            case RoomObjectVisualizationEnum.const_789:
            case RoomObjectVisualizationEnum.const_800:
               _loc5_ = AnimatedFurnitureVisualizationData;
               break;
            case RoomObjectVisualizationEnum.const_163:
               _loc5_ = FurnitureVisualizationData;
               break;
            case RoomObjectVisualizationEnum.const_228:
               _loc5_ = FurnitureVisualizationData;
               break;
            case RoomObjectVisualizationEnum.const_250:
               _loc5_ = AnimatedFurnitureVisualizationData;
         }
         if(_loc5_ == null)
         {
            return null;
         }
         _loc4_ = new _loc5_();
         if(_loc4_ != null)
         {
            _loc6_ = null;
            _loc6_ = _loc4_ as IRoomObjectVisualizationData;
            if(!_loc6_.initialize(param3))
            {
               _loc6_.dispose();
               return null;
            }
            if(_loc6_ is AvatarVisualizationData)
            {
               _loc7_ = _loc4_ as AvatarVisualizationData;
               _loc7_.avatarRenderer = var_760;
            }
            else if(_loc6_ is PetVisualizationData)
            {
               _loc8_ = _loc4_ as PetVisualizationData;
               _loc8_.avatarRenderer = var_760;
            }
            var_436.add(param1,_loc6_);
            return _loc6_;
         }
         return null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         super.dispose();
         if(var_760 != null)
         {
            release(new IIDAvatarRenderManager());
            var_760 = null;
         }
         if(var_436 != null)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < var_436.length)
            {
               _loc1_ = var_436.getWithIndex(_loc2_) as IRoomObjectVisualizationData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_436.dispose();
            var_436 = null;
         }
      }
      
      private function avatarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_760 = param2 as IAvatarRenderManager;
      }
      
      public function createRoomObjectVisualization(param1:String) : IRoomObjectGraphicVisualization
      {
         Logger.log("Creating room object visualization instance of type: " + param1);
         var _loc2_:* = null;
         switch(param1)
         {
            case RoomObjectVisualizationEnum.const_156:
               _loc2_ = RoomVisualization;
               break;
            case RoomObjectVisualizationEnum.const_242:
               _loc2_ = PublicRoomVisualization;
               break;
            case RoomObjectVisualizationEnum.const_222:
               _loc2_ = PublicRoomParkVisualization;
               break;
            case RoomObjectVisualizationEnum.const_811:
               _loc2_ = PublicRoomPoolVisualization;
               break;
            case RoomObjectVisualizationEnum.const_112:
               _loc2_ = AvatarVisualization;
               break;
            case RoomObjectVisualizationEnum.BOT:
               _loc2_ = AvatarVisualization;
               break;
            case RoomObjectVisualizationEnum.PET:
               _loc2_ = PetVisualization;
               break;
            case RoomObjectVisualizationEnum.const_869:
               _loc2_ = FurnitureVisualization;
               break;
            case RoomObjectVisualizationEnum.const_738:
               _loc2_ = AnimatedFurnitureVisualization;
               break;
            case RoomObjectVisualizationEnum.const_163:
               _loc2_ = FurnitureShadowVisualization;
               break;
            case RoomObjectVisualizationEnum.const_946:
               _loc2_ = FurniturePosterVisualization;
               break;
            case RoomObjectVisualizationEnum.const_249:
               _loc2_ = FurnitureHabboWheelVisualization;
               break;
            case RoomObjectVisualizationEnum.const_757:
               _loc2_ = FurnitureValRandomizerVisualization;
               break;
            case RoomObjectVisualizationEnum.const_859:
               _loc2_ = FurnitureBottleVisualization;
               break;
            case RoomObjectVisualizationEnum.const_252:
               _loc2_ = FurniturePlanetSystemVisualization;
               break;
            case RoomObjectVisualizationEnum.const_789:
               _loc2_ = FurnitureQueueTileVisualization;
               break;
            case RoomObjectVisualizationEnum.const_800:
               _loc2_ = FurniturePartyBeamerVisualization;
               break;
            case RoomObjectVisualizationEnum.const_228:
               _loc2_ = RoomTileCursorVisualization;
               break;
            case RoomObjectVisualizationEnum.const_250:
               _loc2_ = SelectionArrowVisualization;
         }
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Object = new _loc2_();
         if(_loc3_ is IRoomObjectGraphicVisualization)
         {
            return _loc3_ as IRoomObjectGraphicVisualization;
         }
         return null;
      }
   }
}
