package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetCatalogPageComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function GetCatalogPageComposer(param1:int)
      {
         _data = [];
         super();
         _data.push(param1);
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
