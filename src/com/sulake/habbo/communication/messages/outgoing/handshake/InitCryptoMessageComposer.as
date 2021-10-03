package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class InitCryptoMessageComposer implements IMessageComposer
   {
       
      
      private var var_30:Array;
      
      public function InitCryptoMessageComposer(param1:int)
      {
         super();
         var_30 = new Array();
         var_30.push(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return var_30;
      }
   }
}
