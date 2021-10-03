package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class GetSelectedBadgesMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var var_39:Array;
      
      public function GetSelectedBadgesMessageComposer(param1:int)
      {
         var_39 = [];
         super();
         this.var_39.push(int(param1));
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function getMessageArray() : Array
      {
         return this.var_39;
      }
      
      public function dispose() : void
      {
         this.var_39 = null;
      }
   }
}
