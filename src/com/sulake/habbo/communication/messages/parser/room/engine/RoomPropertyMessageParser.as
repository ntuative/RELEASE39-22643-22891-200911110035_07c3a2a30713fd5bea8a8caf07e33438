package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomPropertyMessageParser implements IMessageParser
   {
       
      
      private var var_1043:String = null;
      
      private var _floorType:String = null;
      
      private var var_1041:String = null;
      
      private var _roomId:int = 0;
      
      private var var_1042:String = null;
      
      private var _roomCategory:int = 0;
      
      public function RoomPropertyMessageParser()
      {
         super();
      }
      
      public function get wallType() : String
      {
         return var_1043;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get floorType() : String
      {
         return _floorType;
      }
      
      public function get animatedLandskapeType() : String
      {
         return var_1041;
      }
      
      public function flush() : Boolean
      {
         _floorType = null;
         var_1043 = null;
         var_1042 = null;
         var_1041 = null;
         return true;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:String = param1.readString();
         var _loc3_:String = param1.readString();
         switch(_loc2_)
         {
            case "floor":
               _floorType = _loc3_;
               break;
            case "wallpaper":
               var_1043 = _loc3_;
               break;
            case "landscape":
               var_1042 = _loc3_;
               break;
            case "landscapeanim":
               var_1041 = _loc3_;
         }
         return true;
      }
      
      public function get landscapeType() : String
      {
         return var_1042;
      }
   }
}
