package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.InitCryptoMessageParser;
   
   public class InitCryptoMessageEvent extends MessageEvent implements IMessageEvent
   {
       
      
      public function InitCryptoMessageEvent(param1:Function)
      {
         super(param1,InitCryptoMessageParser);
      }
      
      public function get token() : String
      {
         return (this.var_21 as InitCryptoMessageParser).token;
      }
      
      public function get isClientEncrypted() : Boolean
      {
         return (this.var_21 as InitCryptoMessageParser).isClientEncrypted;
      }
      
      public function get isServerEncrypted() : Boolean
      {
         return (this.var_21 as InitCryptoMessageParser).isServerEncrypted;
      }
   }
}
