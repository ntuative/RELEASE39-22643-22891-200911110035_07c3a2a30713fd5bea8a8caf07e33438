package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class RoomDimmerSavePresetMessageComposer implements IMessageComposer
   {
       
      
      private var var_1542:int;
      
      private var var_1543:int;
      
      private var var_1544:Boolean;
      
      private var var_1546:String;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1545:int;
      
      public function RoomDimmerSavePresetMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:int = 0, param7:int = 0)
      {
         super();
         _roomId = param6;
         _roomCategory = param7;
         var_1543 = param1;
         var_1542 = param2;
         var_1546 = param3;
         var_1545 = param4;
         var_1544 = param5;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1543,var_1542,var_1546,var_1545,int(var_1544)];
      }
      
      public function dispose() : void
      {
      }
   }
}
