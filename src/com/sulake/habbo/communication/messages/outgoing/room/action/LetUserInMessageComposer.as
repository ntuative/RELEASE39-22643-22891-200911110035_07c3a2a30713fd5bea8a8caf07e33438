package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class LetUserInMessageComposer implements IMessageComposer
   {
       
      
      private var _message:Array;
      
      public function LetUserInMessageComposer(param1:String, param2:Boolean, param3:int = 0, param4:int = 0)
      {
         super();
         _message = [param1,param2];
      }
      
      public function dispose() : void
      {
         _message = null;
      }
      
      public function getMessageArray() : Array
      {
         return _message;
      }
   }
}
