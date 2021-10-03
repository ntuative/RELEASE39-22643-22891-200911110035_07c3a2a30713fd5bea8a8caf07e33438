package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;
   
   public class TradingItemListParser implements IMessageParser
   {
       
      
      private var var_921:Array;
      
      private var _firstUserItemArray:Array;
      
      private var var_1140:int;
      
      private var var_1141:int;
      
      public function TradingItemListParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1140 = param1.readInteger();
         _firstUserItemArray = new Array();
         if(!parseItemData(param1,_firstUserItemArray))
         {
            return false;
         }
         var_1141 = param1.readInteger();
         var_921 = new Array();
         if(!parseItemData(param1,var_921))
         {
            return false;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_1140 = -1;
         _firstUserItemArray = null;
         var_1141 = -1;
         var_921 = null;
         return true;
      }
      
      public function get secondUserItemArray() : Array
      {
         return var_921;
      }
      
      public function get firstUserItemArray() : Array
      {
         return _firstUserItemArray;
      }
      
      public function get firstUserID() : int
      {
         return var_1140;
      }
      
      public function get secondUserID() : int
      {
         return var_1141;
      }
      
      private function parseItemData(param1:IMessageDataWrapper, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         _loc3_ = param1.readInteger();
         while(_loc3_ > 0)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readString().toUpperCase();
            _loc6_ = param1.readInteger();
            _loc7_ = param1.readInteger();
            _loc8_ = param1.readInteger();
            _loc14_ = param1.readBoolean();
            _loc9_ = param1.readString();
            _loc10_ = -1;
            _loc11_ = param1.readInteger();
            _loc12_ = param1.readInteger();
            _loc13_ = param1.readInteger();
            _loc15_ = _loc5_ == "S" ? int(param1.readInteger()) : -1;
            param2.push(new ItemDataStructure(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_));
            _loc3_--;
         }
         return true;
      }
   }
}
