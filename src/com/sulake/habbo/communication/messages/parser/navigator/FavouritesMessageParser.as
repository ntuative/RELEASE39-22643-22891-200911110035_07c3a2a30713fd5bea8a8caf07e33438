package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class FavouritesMessageParser implements IMessageParser
   {
       
      
      private var var_1235:Array;
      
      private var var_1907:int;
      
      public function FavouritesMessageParser()
      {
         super();
      }
      
      public function get favouriteRoomIds() : Array
      {
         return var_1235;
      }
      
      public function flush() : Boolean
      {
         var_1235 = new Array();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1907 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_1235.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get limit() : int
      {
         return var_1907;
      }
   }
}
