package com.sulake.room
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.renderer.IRoomRendererBase;
   import flash.utils.Dictionary;
   
   public class RoomInstance implements IRoomInstance
   {
       
      
      private var _container:IRoomInstanceContainer;
      
      private var var_913:Array;
      
      private var var_140:IRoomRendererBase;
      
      private var var_452:Array;
      
      private var var_914:Array;
      
      private var _id:String;
      
      private var var_227:Map;
      
      private var var_432:Dictionary;
      
      private var var_431:Dictionary;
      
      public function RoomInstance(param1:String, param2:IRoomInstanceContainer)
      {
         super();
         var_227 = new Map();
         var_452 = [];
         _container = param2;
         _id = param1;
         var_431 = new Dictionary();
         var_432 = new Dictionary();
         var_914 = [];
         var_913 = [];
      }
      
      public function getString(param1:String) : String
      {
         return var_432[param1];
      }
      
      protected function disposeObjectManager(param1:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:String = String(param1);
         disposeObjects(param1);
         if(var_227.getValue(_loc2_) != null)
         {
            _loc3_ = var_227.remove(_loc2_) as IRoomObjectManager;
            if(_loc3_ != null)
            {
               _loc3_.dispose();
            }
            return true;
         }
         return false;
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(var_913.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_913.push(param1);
         }
         if(var_432[param1] != param2)
         {
            var_432[param1] = param2;
         }
      }
      
      public function createRoomObject(param1:int, param2:String, param3:int) : IRoomObject
      {
         if(_container != null)
         {
            return _container.createRoomObject(_id,param1,param2,param3);
         }
         return null;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(var_227 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_227.length)
            {
               _loc3_ = var_227.getWithIndex(_loc2_) as IRoomObjectManager;
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               _loc2_++;
            }
            var_227.dispose();
            var_227 = null;
         }
         if(var_140 != null)
         {
            var_140.dispose();
            var_140 = null;
         }
         _container = null;
         var_452 = null;
         if(var_431 != null)
         {
            for(_loc1_ in var_431)
            {
               delete var_431[_loc1_];
            }
            var_431 = null;
         }
         if(var_432 != null)
         {
            for(_loc1_ in var_432)
            {
               delete var_432[_loc1_];
            }
            var_432 = null;
         }
         var_913 = [];
         var_914 = [];
      }
      
      public function removeObjectUpdateCategory(param1:int) : void
      {
         var _loc2_:int = var_452.indexOf(param1);
         if(_loc2_ >= 0)
         {
            var_452.splice(_loc2_,1);
         }
      }
      
      public function createObjectInternal(param1:int, param2:int, param3:int) : IRoomObject
      {
         var _loc5_:* = null;
         var _loc4_:IRoomObjectManager = createObjectManager(param3);
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.createObject(param1,param2);
            if(var_140 != null)
            {
               var_140.feedRoomObject(_loc5_,String(param3));
            }
            return _loc5_;
         }
         return null;
      }
      
      public function getObject(param1:int, param2:int) : IRoomObject
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObject(param1);
         }
         return null;
      }
      
      public function disposeObject(param1:int, param2:int) : Boolean
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            if(var_140)
            {
               var_140.removeRoomObject(param1,String(param2));
            }
            return _loc3_.disposeObject(param1);
         }
         return false;
      }
      
      public function getRenderer() : IRoomRendererBase
      {
         return var_140;
      }
      
      public function getNumber(param1:String) : Number
      {
         return var_431[param1];
      }
      
      public function addObjectUpdateCategory(param1:int) : void
      {
         var _loc2_:int = var_452.indexOf(param1);
         if(_loc2_ >= 0)
         {
            return;
         }
         var_452.push(param1);
      }
      
      public function update() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:int = -1;
         while(_loc1_ >= 0)
         {
            _loc2_ = int(var_452[_loc1_]);
            _loc3_ = getObjectCount(_loc2_) - 1;
            while(_loc3_ >= 0)
            {
               _loc4_ = getObjectWithIndex(_loc3_,_loc2_) as IRoomObjectController;
               if(_loc4_ != null)
               {
                  _loc5_ = _loc4_.getEventHandler();
                  if(_loc5_ != null)
                  {
                     _loc5_.update();
                  }
               }
               _loc3_--;
            }
            _loc1_--;
         }
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(var_914.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_914.push(param1);
         }
         if(var_431[param1] != param2)
         {
            var_431[param1] = param2;
         }
      }
      
      public function setRenderer(param1:IRoomRendererBase) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         if(param1 == var_140)
         {
            return;
         }
         if(var_140 != null)
         {
            var_140.dispose();
         }
         var_140 = param1;
         if(var_140 == null)
         {
            return;
         }
         var_140.reset();
         var _loc2_:Array = getObjectManagerIds();
         var _loc3_:int = _loc2_.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = int(_loc2_[_loc3_]);
            _loc5_ = getObjectCount(_loc4_);
            _loc6_ = _loc5_ - 1;
            while(_loc6_ >= 0)
            {
               _loc7_ = getObjectWithIndex(_loc6_,_loc4_) as IRoomObjectController;
               if(_loc7_ != null)
               {
                  var_140.feedRoomObject(_loc7_,String(_loc4_));
               }
               _loc6_--;
            }
            _loc3_--;
         }
      }
      
      protected function createObjectManager(param1:int) : IRoomObjectManager
      {
         var _loc2_:String = String(param1);
         if(var_227.getValue(_loc2_) != null)
         {
            return var_227.getValue(_loc2_) as IRoomObjectManager;
         }
         if(_container == null)
         {
            return null;
         }
         var _loc3_:IRoomObjectManager = _container.createRoomObjectManager();
         if(_loc3_ != null)
         {
            var_227.add(_loc2_,_loc3_);
         }
         return _loc3_;
      }
      
      public function getObjectCount(param1:int) : int
      {
         var _loc2_:IRoomObjectManager = getObjectManager(param1);
         if(_loc2_ != null)
         {
            return _loc2_.getObjectCount();
         }
         return -1;
      }
      
      public function getObjectManagerIds() : Array
      {
         return var_227.getKeys();
      }
      
      protected function getObjectManager(param1:int) : IRoomObjectManager
      {
         return var_227.getValue(String(param1)) as IRoomObjectManager;
      }
      
      public function disposeObjects(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc2_:int = -1;
         var _loc3_:IRoomObjectManager = getObjectManager(param1);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getObjectCount();
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc5_ = _loc3_.getObjectWithIndex(_loc4_) as IRoomObjectController;
               if(_loc5_ != null)
               {
                  _loc6_ = _loc5_.getId();
                  _loc5_.dispose();
                  if(var_140)
                  {
                     var_140.removeRoomObject(_loc6_,String(param1));
                  }
               }
               _loc4_++;
            }
            _loc3_.reset();
         }
         return _loc2_;
      }
      
      public function getObjectWithIndex(param1:int, param2:int) : IRoomObject
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObjectWithIndex(param1);
         }
         return null;
      }
   }
}
