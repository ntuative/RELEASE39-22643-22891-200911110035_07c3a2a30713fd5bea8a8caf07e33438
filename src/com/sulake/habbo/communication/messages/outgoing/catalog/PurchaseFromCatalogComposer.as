package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class PurchaseFromCatalogComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function PurchaseFromCatalogComposer(param1:int, param2:int, param3:String, param4:Boolean, param5:String = "", param6:String = "")
      {
         _data = [];
         super();
         _data.push(param1);
         _data.push(param2);
         _data.push(param3);
         _data.push(int(param4));
         if(param4)
         {
            _data.push(param5);
            _data.push(param6);
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return _data;
      }
   }
}
