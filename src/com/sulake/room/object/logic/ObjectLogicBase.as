package com.sulake.room.object.logic
{
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.IEventDispatcher;
   
   public class ObjectLogicBase implements IRoomObjectEventHandler
   {
       
      
      private var var_254:IRoomObjectController;
      
      private var name_1:IEventDispatcher;
      
      public function ObjectLogicBase()
      {
         super();
      }
      
      public function set eventDispatcher(param1:IEventDispatcher) : void
      {
         name_1 = param1;
      }
      
      public function dispose() : void
      {
         var_254 = null;
      }
      
      public function get eventDispatcher() : IEventDispatcher
      {
         return name_1;
      }
      
      public function update() : void
      {
      }
      
      public function get object() : IRoomObjectController
      {
         return var_254;
      }
      
      public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 != null)
         {
            if(var_254 != null)
            {
               var_254.setLocation(param1.loc);
               var_254.setDirection(param1.dir);
            }
         }
      }
      
      public function initialize(param1:XML) : void
      {
      }
      
      public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
      }
      
      public function set object(param1:IRoomObjectController) : void
      {
         if(var_254 == param1)
         {
            return;
         }
         if(var_254 != null)
         {
            var_254.setEventHandler(null);
         }
         if(param1 == null)
         {
            dispose();
            var_254 = null;
         }
         else
         {
            var_254 = param1;
            var_254.setEventHandler(this);
         }
      }
   }
}
