package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
   
   public class RoomDimmerPresetsMessageParser implements IMessageParser
   {
       
      
      private var _selectedPresetId:int = 0;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var _presets:Array;
      
      public function RoomDimmerPresetsMessageParser()
      {
         _presets = [];
         super();
      }
      
      public function get selectedPresetId() : int
      {
         return _selectedPresetId;
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         _roomCategory = 0;
         _presets = [];
         return true;
      }
      
      public function getPreset(param1:int) : RoomDimmerPresetsMessageData
      {
         if(param1 < 0 || param1 >= presetCount)
         {
            return null;
         }
         return _presets[param1];
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get presetCount() : int
      {
         return _presets.length;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc2_:int = param1.readInteger();
         _selectedPresetId = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            _loc6_ = param1.readString();
            _loc7_ = parseInt(_loc6_.substr(1),16);
            _loc8_ = param1.readInteger();
            _loc9_ = new RoomDimmerPresetsMessageData(_loc4_);
            _loc9_.type = _loc5_;
            _loc9_.color = _loc7_;
            _loc9_.light = _loc8_;
            _loc9_.setReadOnly();
            _presets.push(_loc9_);
            _loc3_++;
         }
         return true;
      }
   }
}
