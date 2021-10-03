package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class AvatarEffectActivatedMessageParser implements IMessageParser
   {
       
      
      private var var_1108:int;
      
      private var _type:int;
      
      public function AvatarEffectActivatedMessageParser()
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
         var_1108 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _type = param1.readInteger();
         var_1108 = param1.readInteger();
         return true;
      }
      
      public function get duration() : int
      {
         return var_1108;
      }
   }
}
