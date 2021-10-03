package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
   
   public class FurniListParser implements IMessageParser
   {
       
      
      protected var var_975:Array;
      
      public function FurniListParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_975 = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_975.push(parseItem(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_975 = null;
         return true;
      }
      
      public function parseItem(param1:IMessageDataWrapper) : FurniData
      {
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc4_:String = param1.readString();
         var _loc5_:int = param1.readInteger();
         var _loc6_:int = param1.readInteger();
         var _loc7_:int = param1.readInteger();
         var _loc8_:String = param1.readString();
         var _loc9_:Boolean = param1.readBoolean();
         var _loc10_:Boolean = param1.readBoolean();
         var _loc11_:Boolean = param1.readBoolean();
         var _loc12_:int = param1.readInteger();
         var _loc13_:FurniData = new FurniData(_loc2_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc11_,_loc9_,_loc10_,_loc12_);
         if(_loc4_ == "S")
         {
            _loc14_ = param1.readString();
            _loc15_ = param1.readInteger();
            _loc13_.setSongData(_loc14_,_loc15_);
         }
         return _loc13_;
      }
      
      public function getFurni() : Array
      {
         return var_975;
      }
   }
}
