package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.WardrobeMessageParser;
   
   public class WardrobeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_1443:int = 0;
      
      public static const const_1471:int = 1;
       
      
      public function WardrobeMessageEvent(param1:Function)
      {
         super(param1,WardrobeMessageParser);
      }
      
      public function get outfits() : Array
      {
         return getParser().outfits;
      }
      
      public function get state() : int
      {
         return getParser().state;
      }
      
      private function getParser() : WardrobeMessageParser
      {
         return this.var_21 as WardrobeMessageParser;
      }
   }
}
