package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
   
   public class FlatInfoMessageParser implements IMessageParser
   {
       
      
      private var var_221:RoomSettingsFlatInfo;
      
      public function FlatInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_221 = null;
         return true;
      }
      
      public function get flatInfo() : RoomSettingsFlatInfo
      {
         return var_221;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_221 = new RoomSettingsFlatInfo();
         var_221.allowFurniMoving = param1.readInteger() == 1;
         var_221.doorMode = param1.readInteger();
         var_221.id = param1.readInteger();
         var_221.ownerName = param1.readString();
         var_221.type = param1.readString();
         var_221.name = param1.readString();
         var_221.description = param1.readString();
         var_221.showOwnerName = param1.readInteger() == 1;
         var_221.allowTrading = param1.readInteger() == 1;
         var_221.categoryAlertKey = param1.readInteger() == 1;
         return true;
      }
   }
}
