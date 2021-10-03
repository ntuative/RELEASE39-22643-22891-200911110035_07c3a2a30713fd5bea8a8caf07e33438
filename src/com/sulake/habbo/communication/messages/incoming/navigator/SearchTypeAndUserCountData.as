package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SearchTypeAndUserCountData
   {
       
      
      private var _searchType:int;
      
      private var var_1531:int;
      
      public function SearchTypeAndUserCountData(param1:IMessageDataWrapper)
      {
         super();
         this._searchType = param1.readInteger();
         this.var_1531 = param1.readInteger();
      }
      
      public function get userCount() : int
      {
         return this.var_1531;
      }
      
      public function set userCount(param1:int) : void
      {
         this.var_1531 = param1;
      }
      
      public function get searchType() : int
      {
         return this._searchType;
      }
   }
}
