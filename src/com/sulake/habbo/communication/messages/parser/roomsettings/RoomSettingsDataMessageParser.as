package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
   
   public class RoomSettingsDataMessageParser implements IMessageParser
   {
       
      
      private var var_106:RoomSettingsData;
      
      public function RoomSettingsDataMessageParser()
      {
         super();
      }
      
      public function get data() : RoomSettingsData
      {
         return var_106;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_106 = new RoomSettingsData();
         var_106.roomId = param1.readInteger();
         var_106.name = param1.readString();
         var_106.description = param1.readString();
         var_106.doorMode = param1.readInteger();
         var_106.categoryId = param1.readInteger();
         var_106.maximumVisitors = param1.readInteger();
         var_106.maximumVisitorsLimit = param1.readInteger();
         var_106.showOwnerName = param1.readInteger() == 1 ? true : false;
         var_106.allowFurniMoving = param1.readInteger() == 1 ? true : false;
         var_106.allowTrading = param1.readInteger() == 1 ? true : false;
         var_106.tags = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_106.tags.push(param1.readString());
            _loc3_++;
         }
         var_106.controllers = [];
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            var_106.controllers.push(new FlatControllerData(param1));
            _loc5_++;
         }
         var_106.controllerCount = param1.readInteger();
         Logger.log("BOOORROSH: undefined");
         return true;
      }
      
      public function flush() : Boolean
      {
         var_106 = null;
         return true;
      }
   }
}
