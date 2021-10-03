package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetPetInfoMessageComposer implements IMessageComposer
   {
       
      
      private var var_154:int;
      
      private var _name:String;
      
      public function GetPetInfoMessageComposer(param1:int, param2:String)
      {
         super();
         var_154 = param1;
         _name = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_154,_name];
      }
   }
}
