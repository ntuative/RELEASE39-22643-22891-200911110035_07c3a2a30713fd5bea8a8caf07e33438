package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetCatalogIndexComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function GetCatalogIndexComposer()
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
