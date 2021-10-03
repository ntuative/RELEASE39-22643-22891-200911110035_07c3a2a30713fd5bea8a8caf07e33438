package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class RedeemVoucherMessageComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function RedeemVoucherMessageComposer(param1:String)
      {
         _data = [];
         super();
         _data.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return _data;
      }
      
      public function dispose() : void
      {
         _data = null;
      }
   }
}
