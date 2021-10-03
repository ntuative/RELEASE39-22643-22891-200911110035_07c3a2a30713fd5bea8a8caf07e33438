package com.sulake.habbo.communication.messages.outgoing.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetWardrobeMessageComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function GetWardrobeMessageComposer()
      {
         _data = [];
         super();
      }
      
      public function dispose() : void
      {
         _data = null;
      }
      
      public function getMessageArray() : Array
      {
         return _data;
      }
   }
}
