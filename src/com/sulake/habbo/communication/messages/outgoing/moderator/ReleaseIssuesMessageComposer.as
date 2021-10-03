package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class ReleaseIssuesMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var var_39:Array;
      
      public function ReleaseIssuesMessageComposer(param1:Array)
      {
         var_39 = new Array();
         super();
         this.var_39.push(param1.length);
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.var_39.push(param1[_loc2_]);
            _loc2_++;
         }
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
