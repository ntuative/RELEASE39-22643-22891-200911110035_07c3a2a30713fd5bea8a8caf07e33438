package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class AvatarEffectExpiredMessageParser implements IMessageParser
   {
       
      
      private var _type:int;
      
      public function AvatarEffectExpiredMessageParser()
      {
         super();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function flush() : Boolean
      {
         _type = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _type = param1.readInteger();
         return true;
      }
   }
}
