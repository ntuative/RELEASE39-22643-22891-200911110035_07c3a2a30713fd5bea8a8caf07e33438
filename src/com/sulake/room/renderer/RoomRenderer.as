package com.sulake.room.renderer
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.RoomGeometry;
   import flash.utils.getTimer;
   
   public class RoomRenderer implements IRoomRenderer, IRoomSpriteCanvasContainer
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _objects:Map;
      
      private var var_184:Map;
      
      private var var_1584:String = null;
      
      private var var_90:Component;
      
      public function RoomRenderer(param1:Component)
      {
         super();
         _objects = new Map();
         var_184 = new Map();
         if(param1 != null)
         {
            var_90 = param1;
         }
      }
      
      public function getRoomObjectIdWithIndex(param1:int) : String
      {
         return _objects.getKey(param1) as String;
      }
      
      public function getRoomObjectCount() : int
      {
         return _objects.length;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:* = null;
         render();
         var _loc2_:int = -1;
         while(_loc2_ >= 0)
         {
            _loc3_ = var_184.getWithIndex(_loc2_) as RoomSpriteCanvas;
            if(_loc3_ != null)
            {
               _loc3_.update();
            }
            _loc2_--;
         }
      }
      
      public function reset() : void
      {
         _objects.reset();
      }
      
      public function getCanvas(param1:int) : IRoomRenderingCanvas
      {
         return var_184.getValue(String(param1)) as IRoomRenderingCanvas;
      }
      
      public function disposeCanvas(param1:int) : Boolean
      {
         var _loc2_:RoomSpriteCanvas = var_184.remove(String(param1)) as RoomSpriteCanvas;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         return false;
      }
      
      public function getRoomObjectWithIndex(param1:int) : IRoomObject
      {
         return _objects.getWithIndex(param1) as IRoomObject;
      }
      
      public function render() : void
      {
         var _loc3_:* = null;
         var _loc1_:int = getTimer();
         var _loc2_:int = -1;
         while(_loc2_ >= 0)
         {
            _loc3_ = var_184.getWithIndex(_loc2_) as IRoomRenderingCanvas;
            if(_loc3_ != null)
            {
               _loc3_.render(_loc1_);
            }
            _loc2_--;
         }
      }
      
      public function set roomObjectVariableAccurateZ(param1:String) : void
      {
         var_1584 = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(disposed)
         {
            return;
         }
         if(var_184 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_184.length)
            {
               _loc2_ = var_184.getWithIndex(_loc1_) as RoomSpriteCanvas;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_184.dispose();
            var_184 = null;
         }
         if(_objects != null)
         {
            _objects.dispose();
            _objects = null;
         }
         if(var_90 != null)
         {
            var_90 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function removeRoomObject(param1:int, param2:String) : void
      {
         _objects.remove(String(param1) + "-" + param2);
      }
      
      public function get roomObjectVariableAccurateZ() : String
      {
         return var_1584;
      }
      
      public function createCanvas(param1:int, param2:int, param3:int, param4:int) : IRoomRenderingCanvas
      {
         var _loc6_:* = null;
         var _loc5_:IRoomRenderingCanvas = var_184.getValue(String(param1)) as IRoomRenderingCanvas;
         if(_loc5_ != null)
         {
            _loc5_.initialize(param2,param3);
            _loc6_ = _loc5_.geometry as RoomGeometry;
            if(_loc6_)
            {
               _loc6_.scale = param4;
            }
            return _loc5_;
         }
         _loc5_ = new RoomSpriteCanvas(this,"canvas_" + param1,param2,param3,param4);
         var_184.add(String(param1),_loc5_);
         return _loc5_;
      }
      
      public function getRoomObject(param1:String) : IRoomObject
      {
         return _objects.getValue(param1) as IRoomObject;
      }
      
      public function feedRoomObject(param1:IRoomObject, param2:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         _objects.add(String(param1.getId()) + "-" + param2,param1);
      }
   }
}
