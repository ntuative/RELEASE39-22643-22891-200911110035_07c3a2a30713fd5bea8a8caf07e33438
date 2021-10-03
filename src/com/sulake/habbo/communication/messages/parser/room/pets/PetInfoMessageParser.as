package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetInfoMessageParser implements IMessageParser
   {
       
      
      private var var_1127:int;
      
      private var _hungerType:int;
      
      private var var_1125:int;
      
      private var var_1144:int;
      
      private var var_1124:Array;
      
      private var var_1126:int;
      
      public function PetInfoMessageParser()
      {
         super();
      }
      
      public function get age() : int
      {
         return var_1127;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_1144 = param1.readInteger();
         var_1127 = param1.readInteger();
         _hungerType = param1.readInteger();
         var_1126 = param1.readInteger();
         var_1125 = param1.readInteger();
         var_1124 = new Array(param1.readInteger(),param1.readInteger());
         return true;
      }
      
      public function flush() : Boolean
      {
         var_1144 = -1;
         var_1127 = 0;
         _hungerType = 0;
         var_1126 = 0;
         var_1125 = 0;
         var_1124 = new Array();
         return true;
      }
      
      public function get natureTypeArray() : Array
      {
         return var_1124;
      }
      
      public function get roomIndex() : int
      {
         return var_1144;
      }
      
      public function get hungerType() : int
      {
         return _hungerType;
      }
      
      public function get moodType() : int
      {
         return var_1125;
      }
      
      public function get thirstType() : int
      {
         return var_1126;
      }
   }
}
