package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class RedeemClubPromoMessageComposer implements IMessageComposer
   {
       
      
      private var _data:Array;
      
      public function RedeemClubPromoMessageComposer(param1:String, param2:Boolean)
      {
         _data = [];
         super();
         _data.push(param1);
         _data.push(param2);
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
