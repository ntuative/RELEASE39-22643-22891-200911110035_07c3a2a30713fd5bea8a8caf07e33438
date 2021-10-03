package com.sulake.habbo.ui
{
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.ChooserItem;
   import com.sulake.habbo.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class ChooserWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      public function ChooserWidgetHandler()
      {
         super();
      }
      
      private function handleUserChooserRequest() : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         if(_container == null || true || true)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc1_:int = _container.roomSession.roomId;
         var _loc2_:int = _container.roomSession.roomCategory;
         var _loc3_:* = [];
         var _loc5_:int = _container.roomEngine.getRoomObjectCount(_loc1_,_loc2_,RoomObjectCategoryEnum.const_42);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _container.roomEngine.getRoomObjectWithIndex(_loc1_,_loc2_,_loc6_,RoomObjectCategoryEnum.const_42);
            _loc7_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc4_.getId());
            if(_loc7_ != null)
            {
               _loc3_.push(new ChooserItem(_loc7_.id,RoomObjectCategoryEnum.const_42,_loc7_.name));
            }
            _loc6_++;
         }
         _loc3_.sort(compareItems);
         _container.events.dispatchEvent(new RoomWidgetChooserContentEvent(RoomWidgetChooserContentEvent.const_453,_loc3_));
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function update() : void
      {
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      private function compareItems(param1:ChooserItem, param2:ChooserItem) : int
      {
         if(param1 == null || param2 == null || param1.name == param2.name || param1.name.length == 0 || param2.name.length == 0)
         {
            return 1;
         }
         var _loc3_:Array = new Array(param1.name.toUpperCase(),param2.name.toUpperCase()).sort();
         if(_loc3_.indexOf(param1.name.toUpperCase()) == 0)
         {
            return -1;
         }
         return 1;
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetRequestWidgetMessage.const_355);
         _loc1_.push(RoomWidgetRequestWidgetMessage.const_425);
         _loc1_.push(RoomWidgetRoomObjectMessage.const_682);
         return _loc1_;
      }
      
      private function handleFurniChooserRequest() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         if(_container == null || true || true)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc1_:int = _container.roomSession.roomId;
         var _loc2_:int = _container.roomSession.roomCategory;
         var _loc3_:* = [];
         var _loc9_:int = _container.roomEngine.getRoomObjectCount(_loc1_,_loc2_,RoomObjectCategoryEnum.const_35);
         _loc4_ = 0;
         while(_loc4_ < _loc9_)
         {
            _loc8_ = _container.roomEngine.getRoomObjectWithIndex(_loc1_,_loc2_,_loc4_,RoomObjectCategoryEnum.const_35);
            if(_loc8_ != null)
            {
               _loc5_ = _loc8_.getModel().getNumber(RoomObjectVariableEnum.const_277);
               _loc6_ = _container.sessionDataManager.getFurnitureData(_loc5_);
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_.title;
               }
               else
               {
                  _loc7_ = _loc6_.name;
               }
               _loc3_.push(new ChooserItem(_loc8_.getId(),RoomObjectCategoryEnum.const_35,_loc7_));
            }
            _loc4_++;
         }
         _loc9_ = _container.roomEngine.getRoomObjectCount(_loc1_,_loc2_,RoomObjectCategoryEnum.const_28);
         _loc4_ = 0;
         while(_loc4_ < _loc9_)
         {
            _loc8_ = _container.roomEngine.getRoomObjectWithIndex(_loc1_,_loc2_,_loc4_,RoomObjectCategoryEnum.const_28);
            if(_loc8_ != null)
            {
               _loc10_ = _loc8_.getType();
               if(_loc10_.indexOf("poster") == 0)
               {
                  _loc11_ = int(_loc10_.replace("poster",""));
                  _loc7_ = _container.localization.getKey("poster_" + _loc11_ + "_name","poster_" + _loc11_ + "_name");
               }
               else
               {
                  _loc5_ = _loc8_.getModel().getNumber(RoomObjectVariableEnum.const_277);
                  _loc6_ = _container.sessionDataManager.getFurnitureData(_loc5_);
                  if(_loc6_ != null && _loc6_.title.length > 0)
                  {
                     _loc7_ = _loc6_.title;
                  }
                  else
                  {
                     _loc7_ = _loc10_;
                  }
               }
               _loc3_.push(new ChooserItem(_loc8_.getId(),RoomObjectCategoryEnum.const_28,_loc7_));
            }
            _loc4_++;
         }
         _loc3_.sort(compareItems);
         _container.events.dispatchEvent(new RoomWidgetChooserContentEvent(RoomWidgetChooserContentEvent.const_452,_loc3_,_container.sessionDataManager.isAnyRoomController));
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case RoomWidgetRequestWidgetMessage.const_425:
               handleFurniChooserRequest();
               break;
            case RoomWidgetRequestWidgetMessage.const_355:
               handleUserChooserRequest();
               break;
            case RoomWidgetRoomObjectMessage.const_682:
               _loc2_ = param1 as RoomWidgetRoomObjectMessage;
               if(_loc2_ == null)
               {
                  return null;
               }
               _container.roomEngine.selectRoomObject(_container.roomSession.roomId,_container.roomSession.roomCategory,_loc2_.id,_loc2_.category);
               break;
         }
         return null;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_345;
      }
   }
}
