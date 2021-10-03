package com.sulake.room.object.logic
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import flash.events.IEventDispatcher;
   
   public interface IRoomObjectEventHandler extends IRoomObjectMouseHandler
   {
       
      
      function initialize(param1:XML) : void;
      
      function get eventDispatcher() : IEventDispatcher;
      
      function set eventDispatcher(param1:IEventDispatcher) : void;
      
      function processUpdateMessage(param1:RoomObjectUpdateMessage) : void;
      
      function get object() : IRoomObjectController;
      
      function update() : void;
      
      function set object(param1:IRoomObjectController) : void;
      
      function dispose() : void;
   }
}
