package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   
   public class UserFlatCatsMessageParser implements IMessageParser
   {
       
      
      private var _nodes:Array;
      
      public function UserFlatCatsMessageParser()
      {
         super();
      }
      
      public function get nodes() : Array
      {
         return _nodes;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:* = null;
         _nodes = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new FlatCategory();
            _loc4_.nodeId = param1.readInteger();
            _loc4_.nodeName = param1.readString();
            _nodes.push(_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _nodes = null;
         return true;
      }
   }
}
